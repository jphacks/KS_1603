

import UIKit
import Photos

//albumを作る　collectionview



class ChooseBackgroundPhotoFromAlbumViewController: UIViewController {
     var photoAssets = [PHAsset]()
    
//    @IBOutlet weak var PhotocellImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//        getAllPhotoInfo()
//        showPhotos()
        
        // Dispose of any resources that can be recreated.
    }
    
    // get all photos
    func getAllPhotoInfo(){
        photoAssets = []
        
//        let options = PHFetchOptions()
//        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//        let assets: PHFetchResult = PHAsset.fetch(wsse: .iage, options: nil)
//        assets.enumerateObjecs, index, stop)-> Void  in
//            self.photoAssets.append(asset as! PHAsset)}
//        print(photoAssets)
    }
    
    enum PHAssetMediaType: Int {
        case unknoun
        case imagei
        case videov
        case audioa
    }
    
//    // show photos
//    func showPhotos(){
//        let mamageer: PHImageManager = PHImageManager()
////      mamageer.requestImageForAsset(asset, targetSize: CGSizeMake(120,150), contentMode: .AspectFill, options: nil) { (image, info) in
////            //どこのUIImageViewに表示するのかを指定
////            PhotocellImageView! = UIImage(named: photoAssets)
////        }
//    }
//    
//    
//    
//    //写真にアクセスする許可がおりていない時に設定画面へ移動する
//    func checkAccessToPhotos() {//設定画面に飛ぶ
//        let url = NSURL(string: UIApplicationOpenSettingsURLString)
////        UIApplication.sharedApplication().openURL(url)
//        
//    }

} 

