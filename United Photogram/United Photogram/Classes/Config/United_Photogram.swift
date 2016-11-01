//
//  United_Photogram.swift
//  United Photogram
//
//  Copyright © 2016年 山浦功. All rights reserved.
//

import Foundation
import UIKit

struct United_Photogram {
}


/**
UserDefaults ------------------------
*/
extension United_Photogram {
    static func getUserDefaultsValue(key: UserDefaultsKey) -> AnyObject? {
        return NSUserDefaults.standardUserDefaults().objectIsForcedForKey(key.rawValue) as AnyObject?
    }

    static func setUserDefaultsValue(key: UserDefaultsKey, value: AnyObject) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(value, forKey: key.rawValue)
        ud.synchronize()
    }

    static func removeUserDefaultsValue(key: UserDefaultsKey) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.removeObjectForKey(key.rawValue)
        ud.synchronize()
    }

    static func initializeUserDefaults() {
        guard let domain = NSBundle.mainBundle().bundleIdentifier else { return }
        let ud = NSUserDefaults.standardUserDefaults()
        ud.removePersistentDomainForName(domain)
        ud.synchronize()
    }
}


/**
NSNotififcation -----------------------
*/
extension United_Photogram {
    static func postNotification(type: NotificationKey, object: AnyObject?=nil, userInfo: [NSObject: AnyObject]?=nil) {
        NSNotificationCenter.defaultCenter().postNotificationName(type.rawValue, object: object, userInfo: userInfo)
    }

    static func addNotificationObserver(observer: AnyObject, selector: Selector, type: NotificationKey, object: AnyObject?=nil) {
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: type.rawValue, object: object)
    }

    static func removeNotificationObserver(observer: AnyObject, type: NotificationKey, object: AnyObject?=nil) {
        NSNotificationCenter.defaultCenter().removeObserver(observer, name: type.rawValue, object: object)
    }
}


/**
 *  UIStoryboard extension -----------------
 */
extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(type: T.Type) -> T? {
        let identifire: String
        switch type {
//        case _ where type == ViewController.self: identifire = "viewController"
        default: identifire = ""
        }

        return self.instantiateViewControllerWithIdentifier(identifire) as? T
    }
}
