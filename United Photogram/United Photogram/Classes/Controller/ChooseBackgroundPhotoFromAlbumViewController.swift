import UIKit
import Photos

class ChooseBackgroundPhotoFromAlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
      var photoAssets = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getpermission()

    }
}

/*
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
 * 機能拡張 -- getPermission(),reload(),getAllInfo()
 */
 extension ChooseBackgroundPhotoFromAlbumViewController {
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
 */
