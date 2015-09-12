//
//  SignalKeyboardManager.swift
//  Morse
//
//  Created by 渡部郷太 on 8/3/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

import Foundation
import CoreData

class SignalKeyboardManager {
    
    init() {
    }
    
    func getKeyboard(keyboardName: String) -> SignalKeyboardBundle? {
        if managedObjectContext == nil {
            return nil
        }
        
        let request = NSFetchRequest(entityName: "SignalKeyboardBundle")
        request.predicate = NSPredicate(format: "keyboardName == %@", keyboardName)
        request.resultType = .ManagedObjectResultType
        
        var keyboardObjects: [NSManagedObject]
        do {
            keyboardObjects = try self.managedObjectContext?.executeFetchRequest(request) as! [NSManagedObject]
        } catch {
            return nil
        }
        
        if keyboardObjects.count == 0 {
            return nil
        }
        
        let keyboard = keyboardObjects[0] as! SignalKeyboardBundle
        
        return keyboard
    }
    
    func getAllKeyboards() -> [SignalKeyboardBundle] {
        if managedObjectContext == nil {
            return [SignalKeyboardBundle]()
        }
        let request = NSFetchRequest(entityName: "SignalKeyboardBundle")
        request.resultType = .ManagedObjectResultType
        
        var keyboards = [SignalKeyboardBundle]()
        do {
            keyboards = try self.managedObjectContext?.executeFetchRequest(request) as! [SignalKeyboardBundle]
        } catch {
            return keyboards
        }
        
        return keyboards
    }
    
    func createKeyboard(keyboardName: String, language: String, codeList: NSDictionary) -> SignalKeyboardBundle? {
        if let _ = self.getKeyboard(keyboardName) {
            return nil
        }
        let keyboard = NSEntityDescription.insertNewObjectForEntityForName("SignalKeyboardBundle", inManagedObjectContext: self.managedObjectContext!) as! SignalKeyboardBundle
        
        keyboard.keyboardName = keyboardName
        keyboard.language = language
        
        for key in codeList.allKeys {
            let letter = key as! String
            let signalStrings = codeList.objectForKey(key) as! [String]
            var signals = [Signal]()
            for signal in signalStrings {
                signals.append(Signal(rawValue: signal)!)
            }
            keyboard.addCode(letter, signalSequence: signals)
        }
        
        self.save()

        return keyboard
    }
    
    func getKeyboardByIndex(indexPath: NSIndexPath) -> SignalKeyboardBundle? {
        if let fetchedResultsController = self.fetchedResultsController {
            return fetchedResultsController.objectAtIndexPath(indexPath) as? SignalKeyboardBundle
        } else {
            return nil
        }
    }
    
    func deleteKeyboard(keyboard: SignalKeyboardBundle) {
        self.managedObjectContext?.deleteObject(keyboard)
        self.save()
    }
    
    func savePreInstallKeyboards() {
        let dataFilePath = NSBundle.mainBundle().pathForResource("PreInstall", ofType: "plist")!
        let preInstallData = NSDictionary(contentsOfFile: dataFilePath)
        if preInstallData == nil {
            return
        }
        for key in (preInstallData?.allKeys)! {
            let keyboardInfo = preInstallData?.objectForKey(key) as! NSDictionary
            let keyboardName = keyboardInfo.objectForKey("name") as! String
            let language = keyboardInfo.objectForKey("language") as! String
            let keyboard = self.getKeyboard(keyboardName)
            let replace = keyboardInfo.objectForKey("replace") as! Bool
            
            if keyboard == nil {
                self.createKeyboard(keyboardName, language: language, codeList: keyboardInfo.objectForKey("codeList") as! NSDictionary)
            } else {
                if replace {
                    self.deleteKeyboard(keyboard!)
                    self.createKeyboard(keyboardName, language: language, codeList: keyboardInfo.objectForKey("codeList") as! NSDictionary)
                }
            }
        }
    }
    
    func save() -> Bool {
        do {
            try self.managedObjectContext!.save()
        } catch {
            return false
        }
        return true
    }
    
    // MARK: Core Data Stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        return urls[urls.count - 1] as NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let bun = NSBundle.mainBundle()
        let modelURL = NSBundle.mainBundle().URLForResource("SignalKeyboardModel", withExtension: "momd")
        
        return NSManagedObjectModel(contentsOfURL: modelURL!)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SignalKeyboardModel")
        
        print(url)
        
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            let error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: nil)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController? = {
        let request = NSFetchRequest(entityName: "SignalKeyboardBundle")
        let sorter = NSSortDescriptor(key: "keyboardName", ascending: true)
        request.sortDescriptors = [sorter]
        request.returnsObjectsAsFaults = false
        
        var fetchedResultsController = NSFetchedResultsController(fetchRequest: request,  managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            return nil
        }
        
        return fetchedResultsController
    }()

}
