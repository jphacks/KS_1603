

import UIKit
import Photos


class ChooseBackgroundPhotoFromAlbumViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     「写真」へのアクセスを求める
     */
    func checkpermission() {
    
        let status = PHPhotoLibrary.authorizationStatus()
    
        switch (status) {
        case .NotDetermined:
        // ユーザーはまだ、このアプリに与える権限を選択をしていない

            break;
    
        case .Restricted:
            // PhotoLibraryへのアクセスが許可されていない
            // parental controlなどで制限されていて、ユーザーはアプリのアクセスの許可を変更できない
    
            break;
    
        case .Denied:
            // ユーザーが明示的に、アプリが写真のデータへアクセスすることを拒否した
    
            break;
        default:
            // ユーザーが、アプリが写真のデータへアクセスすることを許可している
            break;
            
        }
    }
    
    
    
    
    
    
    
}

