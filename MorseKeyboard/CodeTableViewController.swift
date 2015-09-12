//
//  JapaneseCodeTableViewController.swift
//  Morse
//
//  Created by 渡部郷太 on 8/19/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

import UIKit

class CodeTableViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var signalKeyboardBundle: SignalKeyboardBundle?
    var dataSource: CodeTableDataSource!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Cellに使われるクラスを登録.
        let codeTableLayout = CodeTableLayout(collectionView: collectionView, signalKeyboardBundle: self.signalKeyboardBundle!)

        self.dataSource = CodeTableDataSource(collectionView: self.collectionView, signalkeyboardBundle: self.signalKeyboardBundle!, codeTableLayout: codeTableLayout)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.dataSource.getCellSize()
    }
    
    // MARK: UICollectionViewDataSource protocol
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.getNumberOfItemsInSection(section)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.dataSource.getNumberOfSections()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return self.dataSource.getCell(self.collectionView, indexPath: indexPath)
    }
    
    @IBAction func pushBackButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
