import UIKit
//カメラで撮影をする画面

class CameraShootingScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var cameraImgView: UIImageView!
    let stamp = UIImage(named: "IMG_6877.JPG")
    
    
    //----「撮影」ボタンが押された時の動作
    @IBAction func btnPushed(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        
        //----背景画像の表示----
        let backgroundImageView = UIImageView(image: stamp)
        backgroundImageView.alpha = 0.5
        picker.cameraOverlayView = backgroundImageView
        //-----ここまで-----
        
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //----画像の保存の処理の処理
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let stampViews = cameraImgView.subviews
        for stampView in stampViews {
            stampView.removeFromSuperview()
        }
        cameraImgView.image = image
        let haikei = UIImageView(image: stamp)
        haikei.alpha = 0.5
        cameraImgView.addSubview(haikei)
        
        // ----- 合成した画像を保存する
        UIGraphicsBeginImageContext(cameraImgView.bounds.size)
        cameraImgView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        UIImageWriteToSavedPhotosAlbum(UIGraphicsGetImageFromCurrentImageContext()!, self, nil, nil)
        UIGraphicsEndImageContext()
        
        dismissViewControllerAnimated(true, completion: nil)    // アプリ画面へ戻る
    }
    
}


