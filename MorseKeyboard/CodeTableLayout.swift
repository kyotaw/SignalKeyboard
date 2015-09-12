//
//  CodeTableLayout.swift
//  Morse
//
//  Created by 渡部郷太 on 8/30/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

import UIKit

let indexTableJa_V: [[String]] = [
    ["ん", "わ", "ら", "や", "ま", "は", "な", "た", "さ", "か", "あ"],
    ["", "", "り", "ゐ", "み", "ひ", "に", "ち", "し", "き", "い"],
    ["", "", "る", "ゆ", "む", "ふ", "ぬ", "つ", "す", "く", "う"],
    ["", "", "れ", "ゑ", "め", "へ", "ね", "て", "せ", "け", "え"],
    ["", "を", "ろ", "よ", "も", "ほ", "の", "と", "そ", "こ", "お"]
]

let indexTableJa_H: [[String]] = [
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

let indexTableEn_V = [
    ["a", "b", "c", "d", "e", "f", "g",
     "h", "i", "j", "k", "l", "m", "n",
     "o", "p", "q", "r", "s", "t", "u",
     "v", "w", "x", "y", "z"]
]


class CodeTableLayout {
    enum CharType: Int {
        case Hiragana = 0
        case Katakana = 1
        case Ascii = 2
        case Kanji = 3
        case Other = 4
    }
    
    var indexTable: [[String]]!
    var cellSize = CGSize()
    
    init(collectionView: UICollectionView, signalKeyboardBundle: SignalKeyboardBundle) {
        var sectionList = [[String]](count: 5, repeatedValue: [String]())
        
        let letters = signalKeyboardBundle.getAllLetters()
        for letter in letters {
            if letter.isEmpty {
                continue
            }
            if letter.unicodeScalars.count > 1 {
                indexTable[CharType.Other.rawValue].append(letter)
            } else {
                let firstChar = letter.unicodeScalars[letter.unicodeScalars.startIndex]
                if UnicodeClasifier.IsAscii(firstChar) || UnicodeClasifier.IsAsciiZenkaku(firstChar) {
                    sectionList[CharType.Ascii.rawValue].append(letter)
                } else if UnicodeClasifier.IsHiragana(firstChar) {
                    sectionList[CharType.Hiragana.rawValue].append(letter)
                } else if UnicodeClasifier.IsKatakanaHankaku(firstChar) || UnicodeClasifier.IsKatakanaZenkaku(firstChar) {
                    sectionList[CharType.Katakana.rawValue].append(letter)
                } else if UnicodeClasifier.IsKanji(firstChar) {
                    sectionList[CharType.Kanji.rawValue].append(letter)
                } else {
                    sectionList[CharType.Other.rawValue].append(letter)
                }
            }
        }
        
        sectionList = sectionList.filter({ !$0.isEmpty })
        sectionList = sectionList.map({ $0.sort({ $0 < $1 }) })
        
        self.indexTable = [[String]](count: 1, repeatedValue: [String]())
        for section in sectionList {
            self.indexTable[0] += section
        }
        
        self.cellSize.width = 40
        self.cellSize.height = 40
    }
    
    func getLetter(indexPath: NSIndexPath) -> String {
        return self.indexTable[indexPath.section][indexPath.item]
    }
    
    func getNumberOfSections() -> Int {
        return self.indexTable.count
    }
    
    func getNumberOfItemsInSection(section: Int) -> Int {
        return self.indexTable[section].count
    }
    
    func getCellSize() -> CGSize {
        return self.cellSize
    }
}
