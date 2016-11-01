//基本的なアラートの設定をする
import UIKit
import Foundation

class AlertDisplay: NSObject {
    //showAlertでアラートの形
    
    
    
   static func showAlertForCompleteSavingPhoto(title: String, message: String, targetVC: UIViewController){
        let alertView: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    
        //「もう一度」
        let againButton: UIAlertAction = UIAlertAction(title: "もう一度", style: .Default){ (UIAlertAction) in targetVC}
        //「キャンセル」
        let cancelButton: UIAlertAction = UIAlertAction(title: "キャンセル", style: .Cancel) { (UIAlertAction) in print("Cancel")}
        
        alertView.addAction(againButton)
        alertView.addAction(cancelButton)
//        (alertView, animated: true, completion: nil)
    }
    
    
    
    //設定画面に移るときに表示
    //写真へのアクセスが出ていない時に使う
    static func showAlertForChangingAppToSettings(title: String, message: String, targetVC: UIViewController){
        let alertView: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //「はい」
        let okButton: UIAlertAction = UIAlertAction(title: "はい", style: .Default){ (UIAlertAction) in targetVC}
        //「キャンセル」
        let cancelButton: UIAlertAction = UIAlertAction(title: "キャンセル", style: .Cancel) { (UIAlertAction) in print("Cancel")}
        
        alertView.addAction(okButton)
        alertView.addAction(cancelButton)
        
        //        (alertView, animated: true, completion: nil)
    }
}

