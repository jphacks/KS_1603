import UIKit
import GoogleMaps

//一応このページはひとまずおっけー

class ChooseBackgroundPhotoFromMapViewController: UIViewController {
    
    
    override func loadView() {
        let camera = GMSCameraPosition.cameraWithLatitude(1.285, longitude: 103.848, zoom: 12)
        let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
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
