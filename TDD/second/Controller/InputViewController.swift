//
//  InputViewController.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/11.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import UIKit
import CoreLocation
class InputViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    
     @IBOutlet weak var dateTextField: UITextField!
     @IBOutlet weak var locationTextField: UITextField!
     @IBOutlet weak var addressTextField: UITextField!
     @IBOutlet weak var descriptionTextField: UITextField!

    
    
    
    
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func save() {
        
        
        guard let titleString = titleTextField.text, titleString.characters.count > 0 else { return }
        
        
        let date: NSDate?
        if let dateText = self.dateTextField.text, dateText.characters.count > 0 {
            date = dateFormatter.date(from: dateText) as NSDate?
        } else {
            date = nil
        }
        
        let descriptionString: String?
        if (descriptionTextField.text?.characters.count)! > 0 {
            descriptionString = descriptionTextField.text
        } else {
            descriptionString = nil
        }
        
        if let locationName = locationTextField.text, locationName.characters.count > 0
        {
            if let address = addressTextField.text, address.characters.count > 0
            {
                geocoder.geocodeAddressString(address)
                {
                    [unowned self] (placeMarks, error) -> Void in
                    let placeMark = placeMarks?.first
                    let item = ToDoItem(title: titleString,
                                        itemDescription: descriptionString,
                                        timestamp: date?.timeIntervalSince1970,
                                        location: Location(name: locationName,
                                                           coordinate: placeMark?.location?.coordinate))
                
                    self.itemManager?.addItem(item)
                }
            }
        }
        
    }

    
    


}
