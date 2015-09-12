//
//  TextDisplay.swift
//  Morse
//
//  Created by 渡部郷太 on 8/19/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

import UIKit

class TextDisplay{
    var textDocumentProxy: UITextDocumentProxy!
    
    init(textDocumentProxy: UITextDocumentProxy){
        self.textDocumentProxy = textDocumentProxy
    }
    
    func insertText(text: String){
        self.textDocumentProxy.insertText(text)
    }
    
    func deleteBackward(){
        self.textDocumentProxy.deleteBackward()
    }
    
}