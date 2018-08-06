//
//  Pin.swift
//  mapApp
//
//  Created by Harada Yuji on 2018/08/06.
//  Copyright © 2018年 Harada Yuji. All rights reserved.
//

import UIKit
import MapKit

class Pin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String?
    init(geo:CLLocationCoordinate2D, text: String?){
        coordinate = geo
        title = text
    }
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        dict["latitude"] = coordinate.latitude
        dict["lomgitude"] = coordinate.latitude
        
        if let tit = title {
            dict["title"] = tit
        }
        return dict
    }
    
    init(dictionary: [String:Any]) {
        if let latitude = dictionary["latitude"] as? Double, let longitude = dictionary["longitude"] as? Double {
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        if let tit = dictionary["title"] as? String {
            title = tit
            
        }
        
    }
    

}
