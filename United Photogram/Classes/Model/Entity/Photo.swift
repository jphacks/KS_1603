//
//  Photo.swift
//  United Photogram
//
//  Created by 山浦功 on 2016/11/18.
//  Copyright © 2016年 山浦功. All rights reserved.
//

import Foundation
import CoreLocation

class Photo:NSObject{
    
    var location:CLLocationDegrees
    var date:NSDate
    var image:String
    
    override init() {
        location = CLLocationDegrees()
        date = NSDate()
        image = ""
    }
    
    init(location:CLLocationDegrees,date:NSDate,image:String) {
        self.location = location
        self.date = date
        self.image = image
    }
}
