//
//  SecondChapter.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//
import UIKit
class ItemListViewController: UIViewController {
    
    @IBOutlet var dataProvider: protocol<UITableViewDataSource,
    UITableViewDelegate>!
    
   @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider

    }
}
