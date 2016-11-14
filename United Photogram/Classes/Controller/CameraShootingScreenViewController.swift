import UIKit

/*
 *撮影する画面 -- ok 11/12 3:00present
 */

class CameraShootingScreenViewController: UIViewController,UIImagePickerControllerDelegate{
    
    @IBOutlet weak var cameraImgView: UIImageView!
    let stamp = UIImage(named: "IMG_6877.JPG")
    
    
    //----「撮影」ボタンが押された時の動作
    @IBAction func btnPushed(sender: AnyObject) {
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
        haikei.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        cameraImgView.addSubview(haikei)
        
        // ----- 合成した画像を保存する
        UIGraphicsBeginImageContext(cameraImgView.bounds.size)
        cameraImgView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        UIImageWriteToSavedPhotosAlbum(UIGraphicsGetImageFromCurrentImageContext()!, self, nil, nil)
        UIGraphicsEndImageContext()
        
        dismissViewControllerAnimated(true, completion: nil)    // アプリ画面へ戻る
    }
    
}
