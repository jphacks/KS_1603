

import UIKit
import Photos

class AlbumTabViewController: UIViewController{
    
   
    @IBOutlet weak var DisplayPhotoTableView: UITableView!
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

//テーブル
//セクションは１つでいい
extension AlbumTabViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("albumCell", forIndexPath: indexPath)
        
        return cell
    }
    
}

//Cellの中にアプリで撮影した写真をいれて表示
//extension AlbumTabViewController: UITableViewDelegate{
//    
////    @objc(tableView:cellForRowAtIndexPath:) private func tableView(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
////        //cellの内容を得る
////        return cell
//  //  }
//}
