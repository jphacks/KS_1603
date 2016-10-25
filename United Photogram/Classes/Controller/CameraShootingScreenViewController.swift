import UIKit


//カメラで撮影をする画面


//データの受け渡しのテスト:渡す方
@objc protocol senderDelegate{
    func receiveMessage(message: NSString)
    optional func optionalReceiveMessage(message: NSString)
}

class CameraShootingScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var CameraScreenImageView: UIImageView!
    
    
    let BackgroundPhoto = UIImage(named: "dog.jpg")
    
    @IBAction func ShootingPhotoButton(sender: AnyObject) {
//        let picker = UIImagePickerController()
//        picker.sourceType = UIImagePickerControllerSourceType.Camera
//        picker.delegate = self
//        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickerImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let BackgroundPhotoViews = CameraScreenImageView.subviews
        for BackgroundPhotoView in BackgroundPhotoViews {
            BackgroundPhotoView.removeFromSuperview()
        }
    
        
    CameraScreenImageView.image = image
    CameraScreenImageView.addSubview(UIImageView(image: BackgroundPhoto))
        
    //----合成した画像を保存
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //---データの受け渡しにテスト
    weak var delegate: senderDelegate?
    let Message: NSString = "you got a message"
    let optMessage: NSString = "you got a optional message"
    
    func senderMessage(sender: AnyObject){
        delegate?.receiveMessage(Message)
        delegate?.optionalReceiveMessage!(optMessage)
    }
    
    //次の画面に送る
    func goNextViewController() {
        let next: AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("ScreenConfirmCombinedPhoto")
        self.presentViewController(next as! UIViewController, animated: true, completion: nil)
    }

}

