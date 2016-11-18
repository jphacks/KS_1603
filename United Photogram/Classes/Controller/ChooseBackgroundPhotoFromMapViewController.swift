import UIKit
import GoogleMaps



class ChooseBackgroundPhotoFromMapViewController: UIViewController{
    
    let locationManager = CLLocationManager()
    
    override func loadView() {
        setLocation()
        showMap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


/*
 *Map
 */
extension ChooseBackgroundPhotoFromMapViewController:CLLocationManagerDelegate{
    
    func setLocation(){//現在地
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 1000
        locationManager.startUpdatingLocation()
    }
  
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("緯度：\(manager.location?.coordinate.latitude)")
        print("経度：\(manager.location?.coordinate.longitude)")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errooor")
    }
    
    func showMap(){//マップの表示
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude
        let location =  GMSCameraPosition.cameraWithLatitude(latitude!, longitude: longitude!, zoom: 12)
        let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: location)
        createPin(mapView, latitude: 33.610015196152062, longitude: 130.66880154871535)
        createMyPin(mapView, latitude: latitude!, longitude: longitude!)
        self.view = mapView
    }
}


/*
 *機能拡張 -- ピン
 */
extension ChooseBackgroundPhotoFromMapViewController{
    
    func createPin(mapView: GMSMapView, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let  position = CLLocationCoordinate2DMake(latitude, longitude)
        let marker = GMSMarker(position: position)
        marker.title = "2001/7/6"
        marker.icon = setPicture(UIImage(named: "スキャン.png"))
        marker.snippet = "飯塚市川津680-4"
        marker.map = mapView
    }
    
    func createMyPin(mapView: GMSMapView, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let  position = CLLocationCoordinate2DMake(latitude, longitude)
        let marker = GMSMarker(position: position)
        marker.title = "現在地"
        //marker.icon = setPicture()
        marker.snippet = "緯度：\(latitude),経度：\(longitude)"
        marker.map = mapView
    }
    
    func createPin2(mapView: GMSMapView, latitude: CLLocationDegrees, longitude: CLLocationDegrees){

    }

    
    func setPicture(image: UIImage!) -> UIImage{
        //iPhone自体の写真を持ってくる
        let iconPic = image
        
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

extension ChooseBackgroundPhotoFromMapViewController{
//    placesClient!.currentPlaceWithCallback({ (placeLikelihoods: GMSPlaceLikelihoodList!, error) -> Void in
//    if error != nil {
//    print("Current Place error: \(error.localizedDescription)")
//    return
//    }
//    
//    for likelihood in placeLikelihoods.likelihoods {
//    if let likelihood = likelihood as? GMSPlaceLikelihood {
//    let place = likelihood.place
//    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
//    print("Current Place address \(place.formattedAddress)")
//    print("Current Place attributions \(place.attributions)")
//    print("Current PlaceID \(place.placeID)")
//    }
//    }
//    })
}
