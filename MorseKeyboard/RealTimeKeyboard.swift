//
//  Morse.swift
//  Morse
//
//  Created by 渡部郷太 on 7/12/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

import Foundation


enum Signal : String{
    case Dot = "Dot"
    case Dash = "Dash"
    case SpaceBetweenLetters = "SpaceBetweenLetters"
    case SpaceBetweenWords = "SpaceBetweenWords"
}

let UNIT_TIME = 0.15

let ExCode: Dictionary<String, [Signal]> =
[
    "ゔ": [Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot],
    "が": [Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot],
    "ぎ": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot],
    "ぐ": [Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot],
    "げ": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot],
    "ご": [Signal.Dash, Signal.Dash, Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot],
    "ざ": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot],
    "じ": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot],
    "ず": [Signal.Dash, Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot],
    "ぜ": [Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot],
    "ぞ": [Signal.Dash, Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot],
    "だ": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot],
    "ぢ": [Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot],
    "づ": [Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot],
    "で": [Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot],
    "ど": [Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot],
    "ぱ": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot],
    "ば": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot],
    "ぴ": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot],
    "び": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot],
    "ぷ": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot],
    "ぶ": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot],
    "ぺ": [Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot],
    "べ": [Signal.Dot, Signal.Dot, Signal.Dot],
    "ぽ": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot],
    "ぼ": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot],
]


class NormalKeyboard {
    var signalKeyboardBundle: SignalKeyboardBundle
    var currentSignalSequence: [Signal]
    
    init(signalKeyboardBundle: SignalKeyboardBundle) {
        self.signalKeyboardBundle = signalKeyboardBundle
        self.currentSignalSequence = [Signal]()
    }
    
    func addDot() {
        self.currentSignalSequence.append(Signal.Dot)
    }
    
    func addDash() {
        self.currentSignalSequence.append(Signal.Dash)
    }
    
    func fix() -> String {
        return self.signalKeyboardBundle.getLetter(self.currentSignalSequence)
    }
    
    func clear() {
        self.currentSignalSequence = [Signal]()
    }
}

class RealTimeKeyboard {
    enum KeyType: Int {
        case SignalKey = 100
        case SpaceKey = 101
        case DeleteKey = 102
        case TableKey = 103
        case SelectKey = 104
        case ReturnKey = 105
        case NextKey = 106
    }
    
    var signalKeyboardBundle: SignalKeyboardBundle
    var currentSignalSequence = [Signal]()
    var currentWord = String()
    var startSignalTime: NSDate?
    var fixLetterTimer: NSTimer?
    var fixLetterCallback: ((String) -> ())?
    var fixWordTimer: NSTimer?
    var textDisplay: TextDisplay!
    var enabledAutoSpacing = false
    var enabledAutoUpperCase = false
    
    init(signalKeyboardBundle: SignalKeyboardBundle, textDisplay: TextDisplay){
        self.signalKeyboardBundle = signalKeyboardBundle
        self.textDisplay = textDisplay
    }
    
    func startSignal(isTwoFingersTap: Bool) {
        self.clearTimer()
        self.startSignalTime = NSDate()
        self.enabledAutoUpperCase = (isTwoFingersTap || self.enabledAutoUpperCase)
    }
    
    func endSignal() {
        if let startTime = self.startSignalTime {
            let endTime = NSDate()
            let interval = endTime.timeIntervalSinceDate(startTime)
            if interval <= UNIT_TIME {
                self.currentSignalSequence.append(Signal.Dot)
                self.textDisplay.insertText(".")
            } else {
                self.currentSignalSequence.append(Signal.Dash)
                self.textDisplay.insertText("-")
            }
            self.setTimer()
        }
    }
    
    func deleteBackward() {
        // 符号表示をクリア
        self.clearTimer()
        self.clearSignals()
        self.currentWord.removeAll()

        // 1文字削除
        self.textDisplay.deleteBackward()
    }
    
    func insertSpace() {
        // 符号表示をクリア
        self.clearTimer()
        self.clearSignals()
        self.currentWord.removeAll()
        
        self.textDisplay.insertText(" ")
    }
    
    @objc func fixLetter() {
        var letter = self.signalKeyboardBundle.getLetter(self.currentSignalSequence)
        
        if letter == "゛" || letter == "゜" {
            if !self.currentWord.characters.isEmpty {
                let lastIndex = advance(self.currentWord.startIndex, self.currentWord.characters.count - 1)
                let bond = self.concat(self.currentWord[lastIndex], backwardCharacter: letter[letter.startIndex])
                if bond != "" {
                    letter = bond
                    self.currentWord.removeAtIndex(lastIndex)
                    self.textDisplay.deleteBackward()
                }
            }
        }
        self.clearSignals()
        if letter != "" {
            if self.enabledAutoUpperCase {
                letter = letter.uppercaseString
                self.enabledAutoUpperCase = false
            }
            self.textDisplay.insertText(letter)
            self.currentWord += letter
        }
    }
    
    @objc func fixWord() {
        if self.enabledAutoSpacing && !self.currentWord.isEmpty {
            self.textDisplay.insertText(" ")
            self.currentWord = String()
        }
    }
    
    func concat(fowardCharacter: Character, backwardCharacter: Character) ->String {
        if backwardCharacter == "゛" {
            switch fowardCharacter {
                case "か": return "が"
                case "き": return "ぎ"
                case "く": return "ぐ"
                case "け": return "げ"
                case "こ": return "ご"
                case "さ": return "ざ"
                case "し": return "じ"
                case "す": return "ず"
                case "せ": return "ぜ"
                case "そ": return "ぞ"
                case "た": return "だ"
                case "ち": return "ぢ"
                case "つ": return "づ"
                case "て": return "で"
                case "と": return "ど"
                case "は": return "ば"
                case "ひ": return "び"
                case "ふ": return "ぶ"
                case "へ": return "べ"
                case "ほ": return "ぼ"
                default: return ""
            }
        } else if backwardCharacter == "゜" {
            switch fowardCharacter {
                case "は": return "ぱ"
                case "ひ": return "ぴ"
                case "ふ": return "ぷ"
                case "へ": return "ぺ"
                case "ほ": return "ぽ"
                default: return ""
            }
        } else {
            return ""
        }
    }
    
    func clearSignals(){
        while self.currentSignalSequence.count > 0 {
            self.textDisplay.deleteBackward()
            self.currentSignalSequence.removeLast()
        }
    }
    
    func setTimer() {
        self.fixLetterTimer = NSTimer.scheduledTimerWithTimeInterval(
            UNIT_TIME * 3,
            target: self,
            selector: Selector("fixLetter"),
            userInfo: nil,
            repeats: false)
        
        self.fixWordTimer = NSTimer.scheduledTimerWithTimeInterval(
            UNIT_TIME * 7,
            target: self,
            selector: Selector("fixWord"),
            userInfo: nil,
            repeats: false)
    }
    
    func clearTimer() {
        if let timer = self.fixLetterTimer {
            timer.invalidate()
            self.fixLetterTimer = nil
        }
        if let timer = self.fixWordTimer {
            timer.invalidate()
            self.fixWordTimer = nil
        }
    }
}