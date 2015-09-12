//
//  CodeTableViewDataSource.swift
//  Morse
//
//  Created by 渡部郷太 on 8/23/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//





import UIKit

class CodeTableDataSource {
    let signalKeyboardBundle: SignalKeyboardBundle!
    let layout: CodeTableLayout!
    
    init(collectionView: UICollectionView, signalkeyboardBundle: SignalKeyboardBundle, codeTableLayout: CodeTableLayout) {
        self.signalKeyboardBundle = signalkeyboardBundle
        self.layout = codeTableLayout
        collectionView.registerClass(CodeTableCell.self, forCellWithReuseIdentifier: "CodeCellID")
    }
    
    func getCell(collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : CodeTableCell = collectionView.dequeueReusableCellWithReuseIdentifier("CodeCellID", forIndexPath: indexPath) as! CodeTableCell
        
        if let code = self.signalKeyboardBundle.getCode(self.layout.getLetter(indexPath)) {
            cell.letterLabel.text = code.letter
            
            var rawSignals = String()
            for signal in code.signalSequence {
                if signal == Signal.Dash {
                    rawSignals += "-"
                } else if signal == Signal.Dot {
                    rawSignals += "."
                }
            }
            cell.signalLabel.text = rawSignals
        } else {
            cell.letterLabel.text = ""
            cell.signalLabel.text = ""
        }
        
        let isOdd = (indexPath.section % 2) == 0
        if isOdd {
            cell.backgroundColor = UIColor.whiteColor()
        } else {
            cell.backgroundColor = UIColor.grayColor()
        }
        
        return cell
    }
    
    func getCellSize() -> CGSize {
        return self.layout.getCellSize()
    }
    
    func getNumberOfSections() -> Int {
        return self.layout.getNumberOfSections()
    }
    
    func getNumberOfItemsInSection(section: Int) -> Int {
        return self.layout.getNumberOfItemsInSection(section)
    }
}

class CodeTableCell : UICollectionViewCell{
    
    var letterLabel: UILabel!
    var signalLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.letterLabel = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height / 2))
        self.letterLabel.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(self.letterLabel!)
        
        self.signalLabel = UILabel(frame: CGRectMake(0, frame.height / 2, frame.width, frame.height / 2))
        self.signalLabel.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(self.signalLabel!)
    }
}
