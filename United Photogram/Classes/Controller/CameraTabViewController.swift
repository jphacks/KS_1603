//中央のカメラタブ

import UIKit

class CameraTabViewController: UIViewController{
    
    
    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?
   
    let backgroundImage = UIImage(named: "スキャン2.png")
    
    @IBAction func nextView(sender: AnyObject) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewControllerWithIdentifier("shoot") as! CameraShootingScreenViewController
        nextView.bgimage = backgroundImage
        self.presentViewController(nextView, animated: true, completion: nil)
    }
    override func viewDidLoad() {
//        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("albumView")
//        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
//        self.addChildViewController(self.currentViewController!)
//        self.addSubView(self.currentViewController!.view, toView: self.containerView)
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




/*
 *  機能拡張
 
extension CameraTabViewController{
    func switchView(identifier: String){
        let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier)
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
    }

    
    func addSubView(subView: UIView, toView parentView: UIView){
        parentView.addSubview(subView)
        var viewBindngsDict = [String: AnyObject]()
        viewBindngsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:I[subView]", options: [], metrics: nil, views: viewBindngsDict))
       // parentView.addConstraint(NSLayoutConstraint.activateConstraints())
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:I[subView]", options: [], metrics: nil, views: viewBindngsDict))
    }

    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController){
        oldViewController.willMoveToParentViewController(nil)
        self.addChildViewController(newViewController)
        self.addSubView(newViewController.view, toView: self.containerView)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
            },
                                   completion: { finished in
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParentViewController()
            newViewController.didMoveToParentViewController(self)
        })
    }
} 
 */
