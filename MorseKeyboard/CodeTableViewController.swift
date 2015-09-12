//
//  JapaneseCodeTableViewController.swift
//  Morse
//
//  Created by 渡部郷太 on 8/19/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

import UIKit

class JapaneseCodeTableViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var numberOfSection = 5
    var numberOfItemsInSection = 11
    var cellSize: CGSize!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UINib(nibName: "JapaneseCodeTableView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        self.inputView?.addSubview(view)
        
        // Cellに使われるクラスを登録.
        
        self.collectionView.registerClass(CodeCell.self, forCellWithReuseIdentifier: "CodeCellID")
        
        //let cellView = UINib(nibName: "CodeCellView", bundle: nil)
        //self.collectionView.registerNib(cellView, forCellWithReuseIdentifier: "CodeCellID")
        
        // Cellに使われるクラスを登録.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.cellSize = CGSize()
        let frame = self.collectionView.bounds
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        self.cellSize.width = (frame.width - (layout.minimumInteritemSpacing * CGFloat(self.numberOfItemsInSection - 1)) - layout.sectionInset.left - layout.sectionInset.right) / CGFloat(self.numberOfItemsInSection)
        self.cellSize.height = (frame.height - (layout.sectionInset.top * CGFloat(self.numberOfSection))) / CGFloat(self.numberOfSection)
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.numberOfSection
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItemsInSection
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : CodeCell = collectionView.dequeueReusableCellWithReuseIdentifier("CodeCellID", forIndexPath: indexPath) as! CodeCell
        
        cell.letterLabel.text = String(indexPath.item)
        cell.signalLabel.text = "..-"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.cellSize
    }
    
    @IBAction func pushReturnButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

class CodeCell : UICollectionViewCell{

    var letterLabel: UILabel!
    var signalLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.letterLabel = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height / 2))
        self.letterLabel.textAlignment = NSTextAlignment.Center
        self.letterLabel.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(self.letterLabel!)
        
        self.signalLabel = UILabel(frame: CGRectMake(0, frame.height / 2, frame.width, frame.height / 2))
        self.signalLabel.textAlignment = NSTextAlignment.Center
        self.signalLabel.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(self.signalLabel!)
    }
}