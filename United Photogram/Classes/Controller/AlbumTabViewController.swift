//----画像の情報として位置情報を持ってくる

import UIKit


class AlbumTabViewController: UIViewController{
    
    @IBOutlet weak var DisplayPhotoTableView: UITableView!
    
    let photoModel = PhotoModel.sharedInstacne
    
    var imageNames = ["dog.png","dog2.png","IMG_6671.png","IMG_6877.png"]
    var imageTitles = ["2016/11/8","2016/11/1","2016/10/20", "2016/10/10"]
    var imageDescriptions = ["飯塚市川津680-4","福岡県福岡市博多区下臼井778-1","福岡県福岡市中央区城内2-5","福岡県福岡市中央区地行浜2丁目2番2号"]
   // var delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var refreshControl:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "データ更新")
        self.refreshControl.addTarget(self, action: #selector(AlbumTabViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        self.DisplayPhotoTableView.addSubview(refreshControl)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

/*
 *tableView実装----- cellの更新
 */

extension AlbumTabViewController{
    func refresh(){
            // UserDefaultsから画像が取得出来た場合ImageViewのimageに設定
            imageNames.insert("IMG_6877.JPG", atIndex: 0)
            imageTitles.insert(getDate(), atIndex: 0)
            imageDescriptions.insert("データの読み込みテスト", atIndex: 0)
            print("更新をしました。")
         self.DisplayPhotoTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func getDate() ->String{
        let now = NSDate() // 現在日時の取得
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") // ロケールの設定
        dateFormatter.dateFormat = "yyyy/MM/dd" // 日付フォーマットの設定
        
        print(dateFormatter.stringFromDate(now)) // -> 2014/06/25 02:13:18
        return dateFormatter.stringFromDate(now)
    }
}

/*
 *tableView実装------ sectionの数 --
 */
extension AlbumTabViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoModel.photos.count
//        return imageNames.count
    }
}


/*
 *tableView実装------ cellの中身--
 */
extension AlbumTabViewController: UITableViewDelegate{
    //セルの中身の設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("albumViewCell") as! AlbumViewCell
        
        cell.setCell(photoModel.photos[indexPath.row].image, titleText: "a", DescriptionText: "fejp")
        cell.photoDescription.text = "unko"
//        cell.photoImage = UIImage(named: PhotoModel.sharedInstacne.photos[indexPath.row].image)
//        let data = self.delegate.
//        let image = UIImage(data: )
//        cell.photoImage.image = image
//        cell.setCell(imageNames[indexPath.row], titleText: imageTitles[indexPath.row], DescriptionText: imageDescriptions[indexPath.row])
        return cell
    }
    
    
    //セルが選択されたときの動作
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let text = imageTitles[indexPath.row]
        print("\(indexPath.row)   " + text)
    }
}
