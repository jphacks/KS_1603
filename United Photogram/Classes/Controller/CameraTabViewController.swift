//中央のカメラタブ

import UIKit

class CameraTabViewController: UIViewController{
    
    //次へボタンを押された時の動作。背景画像の保存
    @IBAction func NextButton(sender: AnyObject) {
    }
    
    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?
//    
//    @IBAction func showComponent(sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 0 {
//            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("albumView")
//            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
//            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
//            self.currentViewController = newViewController
//        } else {
//            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapView")
//            newViewController?.view.translatesAutoresizingMaskIntoConstraints = false
//            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
//            self.currentViewController = newViewController
//        }
//    }
    
    override func viewDidLoad() {
        self.currentViewController = self.storyboard?.instantiateInitialViewController()
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
//        self.addSubView(self.currentViewController!.view, toView: self.containerView)
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      //   Dispose of any resources that can be recreated.
    }
    
    
//    func addSubView(subView: UIView, toView parentView: UIView){
//        parentView.addSubview(subView)
//        
//        var viewBindngsDict = [String: AnyObject]()
//        viewBindngsDict["subView"] = subView
//        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:I[subView]", options: [], metrics: nil, views: viewBindngsDict))
//       // parentView.addConstraint(NSLayoutConstraint.activateConstraints(<#T##constraints: [NSLayoutConstraint]##[NSLayoutConstraint]#>))
//        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:I[subView]", options: [], metrics: nil, views: viewBindngsDict))
//    }
    
    
//    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController){
//        oldViewController.willMoveToParentViewController(nil)
//        self.addChildViewController(newViewController)
//        self.addSubView(newViewController.view, toView: self.containerView!)
//        // set the starting state of your constraints here
//        newViewController.view.alpha = 0
//        newViewController.view.layoutIfNeeded()
//        //set the ending state of your constraints here
//        UIView.animateWithDuration(0.5, animations: {
//            newViewController.view.layoutIfNeeded()
//            }, completion: { finished in
//                oldViewController.view.removeFromSuperview()
//                oldViewController.removeFromParentViewController()
//                newViewController.didMoveToParentViewController(self)
//        })
//    }
}
