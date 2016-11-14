//iPhone アルバム内の写真の取得をするcollectionviewの画面

import UIKit
import Photos
import AssetsLibrary

class ChooseBackgroundPhotoFromAlbumViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
      var photoAssets = [PHAsset]()
    
    override func viewDidLoad() {
        //getPermission()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/*
 *  UICollectionView 実装 -- Delegate
 */
extension ChooseBackgroundPhotoFromAlbumViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        
        let asset = photoAssets[indexPath.row]
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        let manager: PHImageManager = PHImageManager()
        manager.requestImageForAsset(asset,
                                     targetSize: imageView.frame.size,
                                     contentMode: .AspectFill,
                                     options: nil) { (image, info) -> Void in
                                        imageView.image = image
        }
        return cell
    }
}


/*
 * UICollectionView 実装 -- DateSource
 */
extension ChooseBackgroundPhotoFromAlbumViewController: UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
}


/*
 * UIImagePickerControllerDelegate
 *
extension ChooseBackgroundPhotoFromAlbumViewController: UIImagePickerControllerDelegate, UINavigationController{
    
    func accessCameraroll(){//カメラロールにアクセス
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
            let image: UIImage? = info[UIImagePickerControllerOriginalImage] as! UIImage?
            let pictURL: NSURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            var library: ALAssetsLibrary = ALAssetsLibrary()
            var data: NSData?
            
            let sema: dispatch_semaphore_t = dispatch_semaphore_create(0)
            let queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            
            var getImage: UIImage?
            
            dispatch_async(queue, {() -> Void in
                library.assetForURL(pictURL, resultBlock: {(asset: ALAsset!) -> Void in
                    let representation: ALAssetRepresentation? = asset.defaultRepresentation()
                    getImage = UIImage(CGImage: representation!.fullResolutionImage().takeUnretainedValue())!
                    data = UIImagePNGRepresentation(getImage!)
                    dispatch_semaphore_signal(sema)
                    }, failureBlock: {(error: NSError!) -> Void in
                        print(error)
                        dispatch_semaphore_signal(sema);
                })
            })
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            
            saveImage(data!)
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
        let mainViewController: MainViewController = MainViewController()
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    // 画像をローカルストレージに保存するメソッド
    func saveImage(data: NSData) {
        let dataPath = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) ).first!.URLByAppendingPathComponent("test.jpg")
        var fileManager: NSFileManager = NSFileManager()
        data.writeToFile(dataPath, atomically: true)

    }
    
}
*/

/*
 * 機能拡張 -- getPermission(),reload(),getAllInfo()
 */
extension ChooseBackgroundPhotoFromAlbumViewController{
    private func getPermission(){
        let status = PHPhotoLibrary.authorizationStatus()
        switch (status) {
        case .Authorized:
            reload()
        case .NotDetermined:
            PHPhotoLibrary.requestAuthorization({ status in
            if status == .Authorized {
                self.reload()
            }
            })
            break
        case .Denied:
            break
        case .Restricted:
            break
        }
    }
    
    
    
    private func reload() {
        getAllPhotosInfo()
        collectionView.reloadData()
    }
    
    
    
    private func getAllPhotosInfo() {
        photoAssets = [PHAsset]()
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        let assets: PHFetchResult = PHAsset.fetchAssetsWithMediaType(.Image, options: options)
        assets.enumerateObjectsUsingBlock { (asset, index, stop) -> Void in
            self.photoAssets.append(asset as! PHAsset)
        }
        print(photoAssets)
    }
}


