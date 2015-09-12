//
//  CodeTableViewDataSource.swift
//  Morse
//
//  Created by 渡部郷太 on 8/23/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

let indexTableJa_H: [[String]] = [
    ["ん", "わ", "ら", "や", "ま", "は", "な", "た", "さ", "か", "あ"],
    ["", "", "り", "ゐ", "み", "ひ", "に", "ち", "し", "き", "い"],
    ["", "", "る", "ゆ", "む", "ふ", "ぬ", "つ", "す", "く", "う"],
    ["", "", "れ", "ゑ", "め", "へ", "ね", "て", "せ", "け", "え"],
    ["", "を", "ろ", "よ", "も", "ほ", "の", "と", "そ", "こ", "お"]
]

let indexTableJa_V: [[String]] = [
    ["ん", "", "", "", ""],
    ["わ", "", "", "", "を"],
    ["ら", "り", "る", "れ", "ろ"],
    ["や", "ゐ", "ゆ", "ゑ", "よ"],
    ["ま", "み", "む", "め", "も"],
    ["は", "ひ", "ふ", "へ", "ほ"],
    ["な", "に", "ぬ", "ね", "の"],
    ["た", "ち", "つ", "て", "と"],
    ["さ", "し", "す", "せ", "そ"],
    ["か", "き", "く", "け", "こ"],
    ["あ", "い", "う", "え", "お"]
]



import UIKit

class CodeTableViewDataSource {
    let signalKeyboardBundle: SignalKeyboardBundle!
    let indexTable: [[String]]!
    
    init(collectionView: UICollectionView, signalkeyboardBundle: SignalKeyboardBundle) {
        self.signalKeyboardBundle = signalkeyboardBundle
        self.indexTable = indexTableJa_V
        
        collectionView.registerClass(CodeTableCell.self, forCellWithReuseIdentifier: "CodeCellID")
    }
    
    func getCell(collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : CodeTableCell = collectionView.dequeueReusableCellWithReuseIdentifier("CodeCellID", forIndexPath: indexPath) as! CodeTableCell
        
        if let code = self.signalKeyboardBundle.getCode(self.indexTable[indexPath.section][indexPath.item]) {
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
    
    func getNumberOfSections() -> Int {
        return self.indexTable.count
    }
    
    func getNumberOfItemsInSection(section: Int) -> Int {
        return self.indexTable[section].count
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
