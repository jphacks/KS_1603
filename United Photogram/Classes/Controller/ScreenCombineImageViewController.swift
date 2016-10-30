import UIKit




class ScreenCombineImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraImgView: UIImageView!
     let stamp = UIImage(named: "IMG_6671.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPushed(sender: AnyObject) {
        
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        let backgroundImageView = UIImageView(image: stamp)
        backgroundImageView.alpha = 0.5
        picker.cameraOverlayView = backgroundImageView
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let stampViews = cameraImgView.subviews
        for stampView in stampViews {
            stampView.removeFromSuperview()                     // スタンプをリセットする
        }
        cameraImgView.image = image                             // 撮影した画像をセットする
        let haikei = UIImageView(image: stamp)
        haikei.alpha = 0.5
        cameraImgView.addSubview(haikei)
        // スタンプ画像を合成する

        // ----- 合成した画像を保存する
        UIGraphicsBeginImageContext(cameraImgView.bounds.size)
        cameraImgView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        UIImageWriteToSavedPhotosAlbum(UIGraphicsGetImageFromCurrentImageContext()!, self, nil, nil)
        UIGraphicsEndImageContext()
        
        dismissViewControllerAnimated(true, completion: nil)    // アプリ画面へ戻る
    }
    
    }
