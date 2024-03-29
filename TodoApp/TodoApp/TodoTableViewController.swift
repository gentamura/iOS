//
//  TodoTableViewController.swift
//  TodoApp
//
//  Created by Gen Tamura on 2014/09/13.
//  Copyright (c) 2014年 Gen Tamura. All rights reserved.
//

import UIKit

protocol UITableViewDataSource {
  func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
  func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
}

class TodoTableViewController : UIViewController, UITableViewDataSource {
  var tableView : UITableView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let header = UIImageView(frame: CGRect(x: 0, y: 0, width: 320, height: 64))
    header.image = UIImage(named:"header")
    
    let title = UILabel(frame: CGRect(x: 10, y: 20, width: 310, height: 44))
    title.text = "Todoリスト"
    header.addSubview(title)
    
    let screenWidth = UIScreen.mainScreen().bounds.size.height
    self.tableView = UITableView(frame: CGRect(x: 0, y: 60, width: 320, height: screenWidth - 60))
    self.tableView!.dataSource = self
    
    self.view.addSubview(self.tableView!)
    self.view.addSubview(header)
  }
  
  func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
    let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
    cell.textLabel.text = "todo"
    return cell
  }
}