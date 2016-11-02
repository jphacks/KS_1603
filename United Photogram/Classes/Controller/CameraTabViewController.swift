//中央のカメラタブ

import UIKit

class CameraTabViewController: UIViewController{
    
    
    @IBOutlet weak var containerView: UIView!
    
    weak var currentViewController: UIViewController?
   
    @IBAction func showComponent(sender: UISegmentedControl) {
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
    }
    
    
    
    override func viewDidLoad() {
//        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("albumView")
//        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
//        self.addChildViewController(self.currentViewController!)
//        self.addSubView(self.currentViewController!.view, toView: self.containerView)
        super.viewDidLoad()
    }
    
    //-----メモリが足りなくなるたびに呼ばれる
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    
    
    
    //----
//    func addSubView(subView: UIView, toView parentView: UIView){
//        parentView.addSubview(subView)
//        
//        var viewBindngsDict = [String: AnyObject]()
//        viewBindngsDict["subView"] = subView
//        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:I[subView]", options: [], metrics: nil, views: viewBindngsDict))
//       // parentView.addConstraint(NSLayoutConstraint.activateConstraints())
//        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:I[subView]", options: [], metrics: nil, views: viewBindngsDict))
//    }
    
    
    
    
    //----
//    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController){
//        oldViewController.willMoveToParentViewController(nil)
//        self.addChildViewController(newViewController)
//        self.addSubView(newViewController.view, toView: self.containerView)
//        newViewController.view.alpha = 0
//        newViewController.view.layoutIfNeeded()
//        UIView.animateWithDuration(0.5, animations: {
//            newViewController.view.alpha = 1
//            oldViewController.view.alpha = 0
//            },
//                                   completion: { finished in
//            oldViewController.view.removeFromSuperview()
//            oldViewController.removeFromParentViewController()
//            newViewController.didMoveToParentViewController(self)
//        })
//    }
    
    
}
