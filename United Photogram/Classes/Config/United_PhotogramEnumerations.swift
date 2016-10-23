//
//  United_PhotogramEnumerations.swift
//  United Photogram
//
//  Copyright © 2016年 山浦功. All rights reserved.
//

import Foundation
import UIKit


/**
 Color -------------------------
*/
enum Color {
    case white(CGFloat)

    static func getColor(color: Color) -> UIColor {
        switch color {
        case let .white(alpha): 
            return UIColor(white: 1, alpha: alpha)
        }
    }
}


/**
 Font -------------------------
*/
enum Font {
    case system

    static func get(font: Font, size: CGFloat) -> UIFont {
        switch font {
        case .system:
            return UIFont.systemFontOfSize(size)
        }
    }
}


/**
 Notification keys ----------------------------
*/
enum NotificationKey: String {
    case Sample = "example"
}


/**
 UserDefaults keys ----------------------------
*/
enum UserDefaultsKey: String {
    case Sample = "example"
}
