import AVFoundation
import UIKit

protocol AVCaptureDeviceAuthorizationProtocol {
    // カメラを起動する
    func launchCamere(successHandler:(Void -> Void), viewController: UIViewController)
}

extension AVCaptureDeviceAuthorizationProtocol {
    func launchCamere(successHandler:(Void -> Void), viewController: UIViewController) {
        let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        switch status {
        case .Authorized:
            successHandler()
        case .Denied:
            self.showCamereAlert(viewController)
        case .Restricted:
            break
        case .NotDetermined:
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo) { (isGranted: Bool) -> () in
                if isGranted {
                    successHandler()
                }
            }
        }
    }
    
    private func showCamereAlert(viewController: UIViewController) {
        let okButtonHandler = { (action: UIAlertAction) -> () in
            if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        // AlertUtility は独自に作成したアラート表示用の便利クラスです。クラスの内容については後述しています。
        AlertUtility.showAlert("アクセス許可設定", message: "カメラへのアクセスを許可してください", okButtonTitle: "設定する", okButtonHandler: okButtonHandler, cancelButtonTitle: "キャンセル", cancelButtonHandler: nil, viewController: viewController)
    }
}
