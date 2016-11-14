import UIKit
import GoogleMaps



class ChooseBackgroundPhotoFromMapViewController: UIViewController{
    
    
    override func loadView() {
        let camera = GMSCameraPosition.cameraWithLatitude(33.635911, longitude: 130.686901, zoom: 12)
        let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        createPin(mapView)
        self.view = mapView
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


/*
 *機能拡張　ー　ピン
 */
extension ChooseBackgroundPhotoFromMapViewController{
    func createPin(mapView: GMSMapView){
        let  position = CLLocationCoordinate2DMake(33.635911, 130.686901)
        let marker = GMSMarker(position: position)
        marker.title = "犬の写真"
        marker.icon = setPicture()
        marker.snippet = "画像は埋め込みです"
        marker.map = mapView
    }
}


/*
 *機能拡張　ー　写真を取得、そのサイズの固定
 */
extension ChooseBackgroundPhotoFromMapViewController{
    func setPicture() -> UIImage{
        let iconPic = UIImage(named: "dog.png")!
        
        //--サイズの変更
        let t = 60.0
        let resizedSize = CGSize(width: t, height: t)
        UIGraphicsBeginImageContext(resizedSize)
        iconPic.drawInRect(CGRectMake(0, 0, resizedSize.width, resizedSize.height))
        let resizedIconPic = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //--サイズの変更終了
        
        return resizedIconPic
    }
}
