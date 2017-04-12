//
//  Location.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import Foundation

import CoreLocation


struct Location:Equatable {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    
    private let nameKey = "nameKey"
    private let latitudeKey = "latitudeKey"
    private let longitudeKey = "longitudeKey"
    
    var plistDict: NSDictionary {
        var dict = [String:AnyObject]()
        dict[nameKey] = name as AnyObject?
        if let coordinate = coordinate {
            dict[latitudeKey] = coordinate.latitude as AnyObject?
            dict[longitudeKey] = coordinate.longitude as AnyObject?
        }
        return dict as NSDictionary
    }

    
    
    init(name: String,
         coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
    
    init?(dict: NSDictionary)
    {
        guard let name = dict[nameKey] as? String else {
            return nil
        }
        let coordinate: CLLocationCoordinate2D?
        if let latitude = dict[latitudeKey] as? Double, let longitude = dict[longitudeKey] as? Double {
            coordinate = CLLocationCoordinate2DMake(latitude , longitude)
        }else {
            coordinate = nil
        }
        self.name = name
        self.coordinate = coordinate
        
        
        
    }

    
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        if lhs.name != rhs.name {
            return false
        }
        if lhs.coordinate?.latitude != rhs.coordinate?.latitude {
            return false
        }
        if lhs.coordinate?.longitude != rhs.coordinate?.longitude {
            return false
        }
        return true
    }
    
}
