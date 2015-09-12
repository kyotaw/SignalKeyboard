//
//  UnicodeClasifier.swift
//  Morse
//
//  Created by 渡部郷太 on 8/30/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

import Foundation

let UnicodeRange = [
    (UnicodeScalar(0x0000), UnicodeScalar(0x0FFF)),
    (UnicodeScalar(0x1000), UnicodeScalar(0x1FFF)),
    (UnicodeScalar(0x2000), UnicodeScalar(0x2FFF)),
    (UnicodeScalar(0x3000), UnicodeScalar(0x3FFF)),
    (UnicodeScalar(0x4000), UnicodeScalar(0x4FFF)),
    (UnicodeScalar(0x5000), UnicodeScalar(0x5FFF)),
    (UnicodeScalar(0x6000), UnicodeScalar(0x6FFF)),
    (UnicodeScalar(0x7000), UnicodeScalar(0x7FFF)),
    (UnicodeScalar(0x8000), UnicodeScalar(0x8FFF)),
    (UnicodeScalar(0x9000), UnicodeScalar(0x9FFF)),
    (UnicodeScalar(0xA000), UnicodeScalar(0xAFFF)),
    (UnicodeScalar(0xB000), UnicodeScalar(0xBFFF)),
    (UnicodeScalar(0xC000), UnicodeScalar(0xCFFF)),
    (UnicodeScalar(0xD000), UnicodeScalar(0xDFFF)),
    (UnicodeScalar(0xE000), UnicodeScalar(0xEFFF)),
    (UnicodeScalar(0xF000), UnicodeScalar(0xFFFF)),
    (UnicodeScalar(0x10000), UnicodeScalar(0x10FFF)),
    (UnicodeScalar(0x12000), UnicodeScalar(0x12FFF)),
    (UnicodeScalar(0x1D000), UnicodeScalar(0x1DFFF)),
    (UnicodeScalar(0x20000), UnicodeScalar(0x20FFF)),
    (UnicodeScalar(0x21000), UnicodeScalar(0x21FFF)),
    (UnicodeScalar(0x22000), UnicodeScalar(0x22FFF)),
    (UnicodeScalar(0x23000), UnicodeScalar(0x23FFF)),
    (UnicodeScalar(0x24000), UnicodeScalar(0x24FFF)),
    (UnicodeScalar(0x25000), UnicodeScalar(0x25FFF)),
    (UnicodeScalar(0x26000), UnicodeScalar(0x26FFF)),
    (UnicodeScalar(0x27000), UnicodeScalar(0x27FFF)),
    (UnicodeScalar(0x28000), UnicodeScalar(0x28FFF)),
    (UnicodeScalar(0x29000), UnicodeScalar(0x29FFF)),
    (UnicodeScalar(0x2A000), UnicodeScalar(0x2AFFF)),
    (UnicodeScalar(0x2F000), UnicodeScalar(0x2FFFF)),
    (UnicodeScalar(0xE0000), UnicodeScalar(0xE0FFF))
]

class UnicodeClasifier {
    
    static func IsAscii(c: UnicodeScalar) -> Bool {
        return UnicodeScalar(0x0000) <= c && c <= UnicodeScalar(0x007F) ? true : false
    }
    
    static func IsAsciiZenkaku(c: UnicodeScalar) -> Bool {
        return UnicodeScalar(0xFF01) <= c && c <= UnicodeScalar(0xFF5D) ? true : false
    }

    static func IsHiragana(c: UnicodeScalar) -> Bool {
        return UnicodeScalar(0x3040) <= c && c <= UnicodeScalar(0x309F) ? true : false
    }

    static func IsKatakanaZenkaku(c: UnicodeScalar) -> Bool {
        return UnicodeScalar(0x30A0) <= c && c <= UnicodeScalar(0x30FF) ? true : false
    }

    static func IsKatakanaHankaku(c: UnicodeScalar) -> Bool {
        return UnicodeScalar(0xFF61) <= c && c <= UnicodeScalar(0xFF9F) ? true : false
    }

    static func IsKanji(c: UnicodeScalar) -> Bool {
        return UnicodeScalar(0x4E00) <= c && c <= UnicodeScalar(0x9FCF) ? true : false
    }
}