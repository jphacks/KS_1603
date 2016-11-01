import UIKit
import AVFoundation
import AssetsLibrary
import Photos
//カメラで撮影をする画面


//データの受け渡しのテスト:渡す方
//@objc protocol senderDelegate{
//    func receiveMessage(message: NSString)
//    optional func optionalReceiveMessage(message: NSString)
//}

class CameraShootingScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var CameraScreenImageView: UIImageView!
    
    @IBOutlet weak var CameraStart: UIButton!
    @IBOutlet weak var SavePic: UIButton!
    @IBOutlet weak var Album: UIButton!
    
    let BackgroundPhoto = UIImage(named: "dog.jpg")
    
    @IBAction func bootCamera(sender: AnyObject) {
        //-1-- カメラが利用可能かチェック
        let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        
        switch (status) {
        case .Authorized:
            // カメラへのアクセスが許可されている状態
            //カメラ起動
            openCamera()
            break
        case .NotDetermined:
            // 初回起動時に許可設定を促すダイアログが表示される
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (granded) in
                if granded == true{
                    //カメラ起動
                    self.openCamera()
                }
            })
            break
        case .Denied:
            // プライバシーで許可されていない状態
            //---urlで設定画面に飛べるかask
            
            break
        case .Restricted:
            // 機能制限されている場合
            break
        }
    }
    
    @IBAction func cameraaaStart(sender: AnyObject) {
        //-1-- カメラが利用可能かチェック
        let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
    
        switch (status) {
        case .Authorized:
            // カメラへのアクセスが許可されている状態
            //カメラ起動
            openCamera()
            break
        case .NotDetermined:
            // 初回起動時に許可設定を促すダイアログが表示される
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (granded) in
                if granded == true{
                    //カメラ起動
                    self.openCamera()
                }
            })
                break
        case .Denied:
            // プライバシーで許可されていない状態
            //---urlで設定画面に飛べるかask
            
            break
        case .Restricted:
            // 機能制限されている場合
            break
        }
        
        
         func showCamereAlert(viewController: UIViewController) {
            let okButtonHandler = { (action: UIAlertAction) -> () in
                if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            // AlertUtility は独自に作成したアラート表示用の便利クラスです。クラスの内容については後述しています。
            AlertUtility.showAlert("アクセス許可設定", message: "カメラへのアクセスを許可してください", okButtonTitle: "設定する", okButtonHandler: okButtonHandler, cancelButtonTitle: "キャンセル", cancelButtonHandler: nil, viewController: viewController)
        }
    }
    
    
    private func openCamera(){
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
    imagePicker.allowsEditing = false
    self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    }
    //保存
    @IBAction func savePic(sender: AnyObject) {
        let timage:UIImage! = CameraScreenImageView.image
        
        if timage != nil {
            UIImageWriteToSavedPhotosAlbum(timage, self, #selector(self.imagePickerControllerDidCancel(_:)), nil)
        }
        else{
           
        }
    }
    
    @IBAction func showAlbum(sender: AnyObject) {
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.presentViewController(cameraPicker, animated: true, completion: nil)
            //present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickerImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        let BackgroundPhotoViews = CameraScreenImageView.subviews
//        for BackgroundPhotoView in BackgroundPhotoViews {
//            BackgroundPhotoView.removeFromSuperview()
//        }
//    
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            CameraScreenImageView.contentMode = .ScaleAspectFit
            CameraScreenImageView.image = pickedImage
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
//    CameraScreenImageView.image = image
//    CameraScreenImageView.addSubview(UIImageView(image: BackgroundPhoto))
        
        func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
            print("1")
            
            if error != nil {
                print(error.code)
            }
            else{
            }
        }
        
        //dismissViewControllerAnimated(true, completion: nil)

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //---データの受け渡しにテスト
//    weak var delegate: senderDelegate?
//    let Message: NSString = "you got a message"
//    let optMessage: NSString = "you got a optional message"
//
//    func senderMessage(sender: AnyObject){
//        delegate?.receiveMessage(Message)
//        delegate?.optionalReceiveMessage!(optMessage)
//    }
    
    //次の画面に送る
//    func goNextViewController() {
//        let next: AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("ScreenConfirmCombinedPhoto")
//        self.presentViewController(next as! UIViewController, animated: true, completion: nil)
//    }

}
