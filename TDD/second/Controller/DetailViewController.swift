//
//  DetailViewController.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/11.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    var itemInfo: (ItemManager, Int)?
    
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let itemInfo = itemInfo else { return }
        let item = itemInfo.0.itemAtIndex(itemInfo.1)
        titleLabel.text = item.title
        locationLabel.text = item.location?.name
        descriptionLabel.text = item.itemDescription
        if let timestamp = item.timestamp {
            let date = NSDate(timeIntervalSince1970: timestamp)
            dateLabel.text = dateFormatter.string(from: date as Date)
        }
        if let coordinate = item.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate,
                                                            100, 100)
            mapView.region = region
        } }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }
    
    func checkItem() {
        if let itemInfo = itemInfo {
            itemInfo.0.checkItemAtIndex(itemInfo.1)
        }
    }

}
