//
//  PhotoModel.swift
//  United Photogram
//
//  Created by 山浦功 on 2016/11/18.
//  Copyright © 2016年 山浦功. All rights reserved.
//

import Foundation

class PhotoModel: NSObject {
    static let sharedInstacne = PhotoModel()
    var photos = [Photo]()
    
    // api connect
    static func addPhoto(filePath:String){
        let photo = Photo()
        photo.image = filePath
        sharedInstacne.photos.append(photo)
    }
    
    // db
    
    // 整形
    
}
