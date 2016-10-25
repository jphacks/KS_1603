
import UIKit

class ScreenConfirmCombinedPhotoViewController: UIViewController,senderDelegate{
    
    @IBOutlet weak var imagePic: UIImageView!
    
    
    //完了ボタン
    @IBAction func ShootingCompleted(sender: AnyObject) {
        SavePicture()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----データ受け渡しのテスト：受け取る方
    func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender?.identifier == "camareSegue" {
            let senderViewController: CameraShootingScreenViewController = segue.destinationViewController as! CameraShootingScreenViewController
            senderViewController.delegate = self
        }
    }

    func receiveMessage(message: NSString) {
        print(message)
    }
    
    func optionalReceiveMessage(message: NSString) {
        print(message)
    }
    
    
    
    
//    // show alert
//    func showAlert(title: String, message: String){
//        let alertView: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
//        
//        let okButton: UIAlertAction = UIAlertAction(title: "もう一度", style: .Default){ (UIAlertAction) in self.SavePicture()}
//        
//        let cancelButton: UIAlertAction = UIAlertAction(title: "キャンセル", style: .Cancel) { (UIAlertAction) in print("Cancel")}
//        
//        alertView.addAction(okButton)
//        alertView.addAction(cancelButton)
//        
//        presentViewController(alertView, animated: true, completion: nil)
//    }
    
    //写真をアプリに保存
    //アルバムタブで表示
    func SavePicture() {
//        let image: UIImage! = imagePic.image
//        
//        if image != nil {
//            UIImageWriteToSavedPhotosAlbum(image, self, Selector("image:didFinishSavingWithError:contextInfo:"), nil)
//            //アプリのアルバムの写真の配列にイメージを加える
//            
//        } else {
//            AlertDisplay.showAlertForCompleteSavingPhoto("写真保存の失敗", message: "写真の保存が正常にできませんでした。やりなおしますか", targetVC: self)
//        }
    }
    
    func goBackViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

