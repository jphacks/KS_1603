import UIKit
import Photos

class PhotosFromALbum: AnyObject {
    /*
//     アクセスが許可されている状態のときの処理
//     */
//    
//     var photoAssets = [PHAsset]()
//    
//    //------画像をすべて取得
//     private func getAllPhotosInfo() {
//        photoAssets = []
//        
//        // 画像をすべて取得
//        let assets: PHFetchResult = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
//        assets.enumerateObjectsUsingBlock { (asset, index, stop) -> Void in
//            self.photoAssets.append(asset as! PHAsset)
//        }
//        print(photoAssets)
//    
//    
//   
//    
//    
//    //------画像を表示する
//    
//    let manager: PHImageManager = PHImageManager()
//    manager.requestImageForAsset(assets,
//    targetSize: CGSizeMake(70, 70),
//    contentMode: .AspectFill,
//    options: nil) { (image, info) -> Void in
//    // 取得したimageをUIImageViewなどで表示する
//    }
//    
//    
//    //------画像の削除
////    private func deleteFirstImage() {
////        let delTargetAsset = photoAssets.first as PHAsset?
////        if delTargetAsset != nil {
////            PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
////                // 削除などの変更はこのblocks内でリクエストする
////                PHAssetChangeRequest.deleteAssets([delTargetAsset!])
////                }, completionHandler: { (success, error) -> Void in
////                    // 完了時の処理をここに記述
////            })
////        }
////        
//    }
}

