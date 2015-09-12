//
//  SignalKeybord.swift
//  Morse
//
//  Created by 渡部郷太 on 8/3/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

import CoreData

class SignalKeyboardBundle : NSManagedObject {
    @NSManaged var keyboardName: String
    @NSManaged var language: String
    @NSManaged var codeList: NSMutableSet
    
    func getLetter(signalSequence: [Signal]) -> String {
        for element in self.codeList {
            if let code = element as? Code {
                if code.signalSequence == signalSequence {
                    return code.letter
                }
            }
        }
        return ""
    }
    
    func getAllLetters() -> [String] {
        var letters = [String]()
        for element in self.codeList {
            if let code = element as? Code {
                letters.append(code.letter)
            }
        }
        return letters
    }
    
    func addCode(letter: String, signalSequence: [Signal]) {
        if self.managedObjectContext == nil {
            return
        }
        if let code = self.getCode(letter) {
            code.signalSequence = signalSequence
        } else {
            if let code = self.createCode(letter, signalSequence: signalSequence) {
                self.codeList.addObject(code)
            }
        }
    }
    
    func getCode(letter: String) -> Code? {
        for code in self.codeList {
            if letter == code.letter {
                return code as? Code
            }
        }
        return nil
    }
    
    func createCode(letter: String, signalSequence: [Signal]) -> Code? {
        if self.managedObjectContext == nil {
            return nil
        }
        let code = NSEntityDescription.insertNewObjectForEntityForName("Code", inManagedObjectContext: self.managedObjectContext!) as! Code
        code.letter = letter
        code.signalSequence = signalSequence
        
        return code
    }
}

class Code : NSManagedObject {
    @NSManaged var letter: String
    @NSManaged var signalSequenceData: NSData
    var signalSequenceCache: [Signal] = [Signal]()
    var reflashSignalSequence: Bool = true
    
    var signalSequence: [Signal] {
        get {
            if !self.reflashSignalSequence {
                return self.signalSequenceCache
            }
            
            self.signalSequenceCache = [Signal]()
            if let signals = NSKeyedUnarchiver.unarchiveObjectWithData(self.signalSequenceData) as! [String]? {
                for signal in signals {
                    self.signalSequenceCache.append(Signal(rawValue: signal)!)
                }
            }
            return self.signalSequenceCache
        }
        set(signalSequence) {
            var rawSignals = [String]()
            for signal in signalSequence {
                rawSignals.append(signal.rawValue)
            }
            self.signalSequenceData = NSKeyedArchiver.archivedDataWithRootObject(rawSignals)
            self.reflashSignalSequence = true
        }
    }
}
