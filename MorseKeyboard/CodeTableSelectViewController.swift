//
//  CodeTableSelectViewController.swift
//  Morse
//
//  Created by 渡部郷太 on 8/23/15.
//  Copyright © 2015 渡部郷太. All rights reserved.
//

import UIKit


protocol CodeTableSelectViewDelegate {
    func didSelectCodeTable(codeTableSelectViewController: CodeTableSelectViewController, codeTableName: String)
}

class CodeTableSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!

    var codeTableManager: SignalKeyboardManager?
    var dataSource: CodeTableSelectDataSource!
    var delegate: CodeTableSelectViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.dataSource = CodeTableSelectDataSource(tableView: self.tableView, codeTableManager: (self.codeTableManager)!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.getNumberOfRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.dataSource.getCell(tableView, indexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.dataSource.getCell(tableView, indexPath: indexPath)
        if let delegate = self.delegate {
            if let codeTableName = cell.textLabel?.text {
                delegate.didSelectCodeTable(self, codeTableName: codeTableName)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pushBackButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
