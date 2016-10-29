import UIKit
import Photos

class ChooseBackgroundPhotoFromAlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
      var photoAssets = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getpermission()

    }
    
    private func getpermission(){
    let status = PHPhotoLibrary.authorizationStatus()
    
    switch (status) {
        case .Authorized:
            reload()
            //----写真の起動を行う
        case .NotDetermined:
            // 初回起動時に許可設定を促すダイアログが表示される
            PHPhotoLibrary.requestAuthorization({ status in
                if status == .Authorized {
                    //do something
                    self.reload()
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
    

    private func reload() {
        getAllPhotosInfo()
        
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAssets.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AlbumCell", forIndexPath: indexPath) as UICollectionViewCell
        
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
    
    

    
    private func getAllPhotosInfo() {
        photoAssets = []
        
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

