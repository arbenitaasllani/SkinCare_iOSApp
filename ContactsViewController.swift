//
//  ContactsViewController.swift
//  SkinCare Project
//
//  Created by TDI Student on 28.9.22.
//

import UIKit

class ContactsViewController: UIViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
    }
    
    
    func addChildViewControllers() {
        //add child 1
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        //identifiko CHild View Controller
        let childVC = storyboard.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
        self.addChild(childVC)
        childVC.view.frame = CGRect(x: 40, y: 40, width: self.view.frame.width - 80, height: self.view.frame.height - 80)
        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }


}
