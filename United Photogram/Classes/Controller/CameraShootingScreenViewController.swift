import UIKit

/*
 *撮影する画面 -- ok 11/12 3:00present
 */

class CameraShootingScreenViewController: UIViewController{
    
    @IBOutlet weak var cameraImgView: UIImageView!
    let stamp = UIImage(named: "IMG_6877.JPG")
    var delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //----「撮影」ボタンが押された時の動作
    @IBAction func btnPushed(sender: AnyObject) {
        shooting()
    }
    
    @IBAction func screenPhoto(sender: AnyObject) {
        if let imageData = self.delegate.userDefaults.objectForKey("imageData") as? NSData, image = UIImage(data: imageData) {
            // UserDefaultsから画像が取得出来た場合ImageViewのimageに設定
            cameraImgView.image = image
            print("画像の表示完了")
        }
    }
    
    @IBAction func savePhoto(sender: AnyObject) {//保存ボタンを押したときの処理
        if let image = cameraImgView.image {
            let imageData = UIImageJPEGRepresentation(image, 1);
            self.delegate.userDefaults.setObject(imageData, forKey: "imageData")
            self.delegate.userDefaults.synchronize()
            print("保存完了")
        }
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



/*
 *機能拡張----- 撮影
 */
extension CameraShootingScreenViewController:UIImagePickerControllerDelegate{
    func shooting(){
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        
        //----背景画像の表示----
        let backgroundImageView = UIImageView(image: stamp)
        backgroundImageView.alpha = 0.5
        backgroundImageView.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2 - 40)
        picker.cameraOverlayView = backgroundImageView
        //-----ここまで-----
        
        picker.delegate = self        
        presentViewController(picker, animated: true, completion: nil)

    }
}



/*
 *機能拡張----- 画像の保存
 */
extension CameraShootingScreenViewController:UINavigationControllerDelegate{

    //----画像の保存の処理の処理
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let stampViews = cameraImgView.subviews
        for stampView in stampViews {
            stampView.removeFromSuperview()
        }
        cameraImgView.image = image
        let haikei = UIImageView(image: stamp)
        haikei.alpha = 0.5
        //haikei.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        cameraImgView.addSubview(haikei)
        
        // ----- 合成した画像をiPhoneに保存する
//        let imageData = UIImageJPEGRepresentation(cameraImgView.image!, 1)
//        userDefaults.setObject(imageData, forKey: "imaageDaatea")
//        userDefaults.synchronize()
//        UIGraphicsBeginImageContext(cameraImgView.bounds.size)
//        cameraImgView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
//        UIImageWriteToSavedPhotosAlbum(UIGraphicsGetImageFromCurrentImageContext()!, self, nil, nil)
//        UIGraphicsEndImageContext()
//        
        dismissViewControllerAnimated(true, completion: nil)    // アプリ画面へ戻る
    }
    
    func save(){
//        let photo = cameraImgView.image!
//        let data: NSData = UIImageJPEGRepresentation(photo, 1)!
//        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        
        
        
//        UIGraphicsBeginImageContext(cameraImgView.bounds.size)
//        UIImageWriteToSavedPhotosAlbum(UIGraphicsGetImageFromCurrentImageContext()!, self, nil, nil)
//        UIGraphicsEndImageContext()
    }
    
}
