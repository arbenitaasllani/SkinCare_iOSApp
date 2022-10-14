//
//  ChildViewController.swift
//  SkinCare Project
//
//  Created by TDI Student on 1.10.22.
//

import UIKit

class ChildViewController: UIViewController {

    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtn.layer.borderColor = UIColor.white.cgColor
        sendBtn.layer.borderWidth = 3
        // Do any additional setup after loading the view.
    }
    @IBAction func sendBtn(_ sender: Any) {
        send()
    }
    func send() {
           let alert = UIAlertController(title: "Send Message", message: "Do you want to send this message?", preferredStyle: .alert)
           
           
           alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
           }))
           
           alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
           }))
           
           present(alert, animated: true)
       }
}
