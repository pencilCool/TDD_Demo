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
    UITableViewDelegate,ItemManagerSettable>!
    
   @IBOutlet var tableView: UITableView!
    
    
    let itemManager = ItemManager()
    
    
    @IBAction func addItem(_ sender: Any) {
        
     
        
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController")
        as? InputViewController {
            
            nextViewController.itemManager = self.itemManager
            present(nextViewController, animated: true,
                                  completion: nil)
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        dataProvider.itemManager = itemManager

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
