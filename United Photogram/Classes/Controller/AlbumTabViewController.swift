//----画像の情報として位置情報を持ってくる

import UIKit


class AlbumTabViewController: UIViewController{
    
    @IBOutlet weak var DisplayPhotoTableView: UITableView!
    
    let imageNames = ["dog.png","dog2.png","IMG_6671.png","IMG_6877.png"]
    let imageTitles = ["2016/11/8","2016/11/1","2016/10/20", "2016/10/10"]
    let imageDescriptions = ["飯塚市川津680-4","福岡県福岡市博多区下臼井778-1","福岡県福岡市中央区城内2-5","福岡県福岡市中央区地行浜2丁目2番2号"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
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
