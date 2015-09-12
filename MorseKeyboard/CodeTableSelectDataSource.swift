
//
//  CodeTableSelectDataSource.swift
//  Morse
//
//  Created by 渡部郷太 on 8/23/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

import UIKit

class CodeTableSelectViewDataSource {
    var codeTableManager: SignalKeyboardManager!
    
    init(tableView: UITableView, codeTableManager: SignalKeyboardManager) {
        self.codeTableManager = codeTableManager
        
        let nib = UINib(nibName: "CodeTableSelectCellView", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "CodeSelectCellID")
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        let count = self.codeTableManager.getAllKeyboards().count
        return count
    }
    
    func getCell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CodeSelectCellID", forIndexPath: indexPath) as UITableViewCell
        
        if let codeTable = self.codeTableManager.getKeyboardByIndex(indexPath) {
            cell.textLabel?.text = codeTable.keyboardName
            cell.detailTextLabel?.text = codeTable.language
        }
        
        return cell
    }

}

