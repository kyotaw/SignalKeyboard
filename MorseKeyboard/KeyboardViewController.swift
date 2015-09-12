//
//  KeyboardViewController.swift
//  MorseKeyboard
//
//  Created by 渡部郷太 on 7/5/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

let MorseCodeJapanese: Dictionary<String, [Signal]> =
[
    "あ": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dash],
    "い": [Signal.Dot, Signal.Dash],
    "う": [Signal.Dot, Signal.Dot, Signal.Dash],
    "え": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dash],
    "お": [Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot],
    "か": [Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot],
    "き": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot],
    "く": [Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dash],
    "け": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dash],
    "こ": [Signal.Dash, Signal.Dash, Signal.Dash, Signal.Dash],
    "さ": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dash],
    "し": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot],
    "す": [Signal.Dash, Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dash],
    "せ": [Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dash, Signal.Dot],
    "そ": [Signal.Dash, Signal.Dash, Signal.Dash, Signal.Dot],
    "た": [Signal.Dash, Signal.Dot],
    "ち": [Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot],
    "つ": [Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot],
    "て": [Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dash],
    "と": [Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot],
    "な": [Signal.Dot, Signal.Dash, Signal.Dot],
    "に": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot],
    "ぬ": [Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot],
    "ね": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dash],
    "の": [Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dash],
    "は": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot],
    "ひ": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dash],
    "ふ": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot],
    "へ": [Signal.Dot],
    "ほ": [Signal.Dash, Signal.Dot, Signal.Dot],
    "ま": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dash],
    "み": [Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dash],
    "む": [Signal.Dash],
    "め": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dash],
    "も": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot],
    "ら": [Signal.Dot, Signal.Dot, Signal.Dot],
    "り": [Signal.Dash, Signal.Dash, Signal.Dot],
    "る": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot],
    "れ": [Signal.Dash, Signal.Dash, Signal.Dash],
    "ろ": [Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dash],
    "や": [Signal.Dot, Signal.Dash, Signal.Dash],
    "ゐ": [Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dash],
    "ゆ": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dash],
    "ゑ": [Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot],
    "よ": [Signal.Dash, Signal.Dash],
    "わ": [Signal.Dash, Signal.Dot, Signal.Dash],
    "を": [Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dash],
    "ん": [Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot],
    "゛": [Signal.Dot, Signal.Dot],
    "゜": [Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot]
]

let MorseCodeEnglish: Dictionary<String, [Signal]> = [
    "a": [Signal.Dot, Signal.Dash],
    "b": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dot],
    "c": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dot],
    "d": [Signal.Dash, Signal.Dot, Signal.Dot],
    "e": [Signal.Dot],
    "f": [Signal.Dot, Signal.Dot, Signal.Dash, Signal.Dot],
    "g": [Signal.Dash, Signal.Dash, Signal.Dot],
    "h": [Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dot],
    "i": [Signal.Dot, Signal.Dot],
    "j": [Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dash],
    "k": [Signal.Dash, Signal.Dot, Signal.Dash],
    "l": [Signal.Dot, Signal.Dash, Signal.Dot, Signal.Dot],
    "m": [Signal.Dash, Signal.Dash],
    "n": [Signal.Dash, Signal.Dot],
    "o": [Signal.Dash, Signal.Dash, Signal.Dash],
    "p": [Signal.Dot, Signal.Dash, Signal.Dash, Signal.Dot],
    "q": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dash],
    "r": [Signal.Dot, Signal.Dash, Signal.Dot],
    "s": [Signal.Dot, Signal.Dot, Signal.Dot],
    "t": [Signal.Dash],
    "u": [Signal.Dot, Signal.Dot, Signal.Dash],
    "v": [Signal.Dot, Signal.Dot, Signal.Dot, Signal.Dash],
    "w": [Signal.Dot, Signal.Dash, Signal.Dash],
    "x": [Signal.Dash, Signal.Dot, Signal.Dot, Signal.Dash],
    "y": [Signal.Dash, Signal.Dot, Signal.Dash, Signal.Dash],
    "z": [Signal.Dash, Signal.Dash, Signal.Dot, Signal.Dot]
]


import UIKit

class KeyboardViewController: UIInputViewController, CodeTableSelectViewDelegate {
    var signalKeyboardManager: SignalKeyboardManager!
    var textDisplay: TextDisplay!
    var keyboard: RealTimeKeyboard!
    
    var startDeleteTimer: NSTimer?
    var deleteTimer: NSTimer?


    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UINib(nibName: "MorseKeyboardView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        self.inputView?.addSubview(view)
        
        self.signalKeyboardManager = SignalKeyboardManager()
        self.signalKeyboardManager.savePreInstallKeyboards()
        
        var codeBundle = self.signalKeyboardManager.getKeyboard("Morse ひらがな")
        for (letter, signals) in MorseCodeJapanese {
            let test = codeBundle!.getLetter(signals)
            if test != letter {
                abort()
            }
        }
        codeBundle = self.signalKeyboardManager.getKeyboard("Morse Alphabet")
        for (letter, signals) in MorseCodeEnglish {
            let test = codeBundle!.getLetter(signals)
            if test != letter {
                abort()
            }
        }
        
        
        self.textDisplay = TextDisplay(textDocumentProxy: self.textDocumentProxy as UITextDocumentProxy)
        self.keyboard = RealTimeKeyboard(
            signalKeyboardBundle: (self.signalKeyboardManager.getKeyboard("Morse ひらがな"))!,
            textDisplay: self.textDisplay)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            let tag: Int = (touch.view?.tag)!
            switch tag {
            case RealTimeKeyboard.KeyType.SignalKey.rawValue:
                self.keyboard.startSignal(touches.count == 2)
            case RealTimeKeyboard.KeyType.DeleteKey.rawValue:
                self.pushDeleteButton()
            default: break
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let tag: Int = (touch.view?.tag)!
            switch tag {
            case RealTimeKeyboard.KeyType.SignalKey.rawValue:
                self.keyboard.endSignal()
            case RealTimeKeyboard.KeyType.SpaceKey.rawValue:
                self.keyboard.insertSpace()
            case RealTimeKeyboard.KeyType.DeleteKey.rawValue:
                self.clearTimer()
            case RealTimeKeyboard.KeyType.TableKey.rawValue:
                self.pushCodeTableButton()
            case RealTimeKeyboard.KeyType.SelectKey.rawValue:
                self.pushCodeTableSelectButton()
            case RealTimeKeyboard.KeyType.ReturnKey.rawValue:
                break
            case RealTimeKeyboard.KeyType.NextKey.rawValue:
                self.pushNextButton()
            default: break
            }

        }
    }
    
    // MARK: CodeTableSelectViewDelegate
    func didSelectCodeTable(codeTableSelectViewController: CodeTableSelectViewController, codeTableName: String) {
        self.keyboard = RealTimeKeyboard(
            signalKeyboardBundle: (self.signalKeyboardManager.getKeyboard(codeTableName))!,
            textDisplay: self.textDisplay)
    }
    
    func pushDeleteButton() {
        self.clearTimer()
        self.keyboard.deleteBackward()
        self.startDeleteTimer = NSTimer.scheduledTimerWithTimeInterval(
            0.7,
            target: self,
            selector: Selector("startContinuousDelete"),
            userInfo: nil,
            repeats: false)
    }
    
    func startContinuousDelete() {
        self.keyboard.deleteBackward()
        self.startDeleteTimer = NSTimer.scheduledTimerWithTimeInterval(
            0.12,
            target: self,
            selector: Selector("doContinuousDelete"),
            userInfo: nil,
            repeats: true)
    }
    
    func doContinuousDelete() {
        self.keyboard.deleteBackward()
    }
    
    func pushNextButton() {
        self.advanceToNextInputMode()
    }
    
    func pushCodeTableButton() {
        let tableView = CodeTableViewController()
        tableView.signalKeyboardBundle = self.keyboard.signalKeyboardBundle
        tableView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(tableView, animated: true, completion: nil)
    }
    
    func pushCodeTableSelectButton() {
        let selectView = CodeTableSelectViewController()
        selectView.codeTableManager = self.signalKeyboardManager
        selectView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        selectView.delegate = self
        self.presentViewController(selectView, animated: true, completion: nil)
    }
    
    func clearTimer() {
        if let timer = self.startDeleteTimer {
            timer.invalidate()
            self.startDeleteTimer = nil
        }
        if let timer = self.deleteTimer {
            timer.invalidate()
            self.deleteTimer = nil
        }
    }
}

class SignalKeyLabel: UILabel
{
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setStyle()
    }
    
    func setStyle() {
        self.clipsToBounds = false
        let layerFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height + 1)
        self.layer.frame = layerFrame
        self.layer.backgroundColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = 3
        self.layer.shadowColor = UIColor.grayColor().CGColor
        self.layer.shadowRadius = 0.0
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1.0
    }
}

class MenuKeyLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setStyle()
    }
    
    func setStyle() {
        self.clipsToBounds = false
        let layerFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height + 1)
        self.layer.frame = layerFrame
        self.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        self.layer.cornerRadius = 3
        self.layer.shadowColor = UIColor.grayColor().CGColor
        self.layer.shadowRadius = 0.0
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1.0
    }
    
}
