

import UIKit
import Photos

class AlbumTabViewController: UIViewController{
    
   
    @IBOutlet weak var DisplayPhotoTableView: UITableView!
    
    let imageNames = ["dog.png","dog2.png","IMG_6671.png","IMG_6877.png"]
    let imageTitles = ["犬１","犬2","写真１", "写真2"]
    let imageDescriptions = ["犬の一枚めの画像","犬の2枚めの画像","写真1枚めです","それの2枚めです"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DisplayPhotoTableView.registerNib(UITableViewCell.self(NSObject), forCellReuseIdentifier: "Cell")
        //register(UITableViewCell.self, forCellReuseIdentifier:
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

/*
 *tableView実装------ sectionの数 --
 */
extension AlbumTabViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }
}


/*
 *tableView実装------ cellの中身--
 */
extension AlbumTabViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("albumViewCell") as! AlbumViewCell
        cell.setCell(imageNames[indexPath.row], titleText: imageTitles[indexPath.row], DescriptionText: imageDescriptions[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let text = imageTitles[indexPath.row]
        print(text)
    }
}
