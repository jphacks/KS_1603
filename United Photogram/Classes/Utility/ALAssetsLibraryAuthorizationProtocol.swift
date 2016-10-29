import AssetsLibrary
import UIKit
import Photos


protocol ALAssetsLibraryAuthorizationProtocol {
    // フォトライブラリーを起動する
    func launchPhotoLibrary(successHandler:(Void -> Void), viewController: UIViewController)
}

extension ALAssetsLibraryAuthorizationProtocol {
    func launchPhotoLibrary(successHandler:(Void -> Void), viewController: UIViewController) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .Authorized:
            successHandler()
        case .Denied:
            self.showPhotoLibraryAlert(viewController)
        case .Restricted:
            break
        case .NotDetermined:
            ALAssetsLibrary().enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock: { (_, _) -> () in
                successHandler()
                }, failureBlock: { (error: NSError?) -> () in
                    // ※1
                    AlertUtility.showErrorAlert(error, viewController: viewController)
            })
        }
    }
    
    private func showPhotoLibraryAlert(viewController: UIViewController) {
        let okButtonHandler = { (action: UIAlertAction) -> () in
            if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        AlertUtility.showAlert("アクセス許可設定", message: "写真へのアクセスを許可してください", okButtonTitle: "設定する", okButtonHandler: okButtonHandler, cancelButtonTitle: "キャンセル", cancelButtonHandler: nil, viewController: viewController)
    }
}
