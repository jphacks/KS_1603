import UIKit


struct AlertUtility
{
    /**
     アラートを表示する
     - parameter title タイトル
     - parameter message メッセージ
     - parameter okButtonTitle OKボタンの表示タイトル
     - parameter okHandler OKボタン押下後の処理ハンドラ
     - parameter cancelButtonTitle キャンセルボタンの表示タイトル
     - parameter cancelHandler キャンセルボタン押下後の処理ハンドラ
     - parameter viewController:アラートを表示するViewController
     */
    static  func showAlert(
        title: String,
        message: String?,
        okButtonTitle: String,
        okButtonHandler: ((UIAlertAction) -> Void)?,
        cancelButtonTitle: String? = nil,
        cancelButtonHandler: ((UIAlertAction) -> Void)? = nil,
        viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okButtonAction = UIAlertAction(title: okButtonTitle, style: .Default, handler: okButtonHandler)
        alert.addAction(okButtonAction)
        if let buttonTitle = cancelButtonTitle {
            let cancelButtonAction = UIAlertAction(title: buttonTitle, style: .Cancel, handler: cancelButtonHandler)
            alert.addAction(cancelButtonAction)
        }
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    /**
     エラーアラートを表示する
     - parameter message:エラーメッセージ
     - parameter okButtonTitle:OKボタンの表示タイトル
     - parameter okHandler:OKボタン押下後の処理ハンドラ
     - parameter viewController:アラートを表示するViewController
     */
    static func showErrorAlert(
        message: String,
        okButtonTitle: String = NSLocalizedString("okButtonTitle", comment: "okButtonTitle"),
        okButtonHandler: ((UIAlertAction) -> Void)? = nil,
        viewController: UIViewController) {
        self.showAlert(
            "エラー",
            message: message,
            okButtonTitle: okButtonTitle,
            okButtonHandler: okButtonHandler,
            viewController: viewController)
    }
    
    static func showErrorAlert(error: NSError?, viewController: UIViewController){
        guard let error = error else {
            return
        }
        let title: String = error.localizedDescription
        let message: String = error.localizedRecoverySuggestion ?? "接続環境の良いところで再度お試しください"
        self.showErrorAlert(title, okButtonTitle: message, viewController: viewController)
    }
}
