//
//  ProductDetailsViewController.swift
//  SkinCare Project
//
//  Created by TDI Student on 30.9.22.
//

import UIKit
import SDWebImage

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var containerview: UIView!
    
    @IBOutlet weak var addBtn: UIButton!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.sd_setImage(with: URL(string: product?.image ?? ""))
        productLabel.text = product?.name
        productDescription.text = product?.Description
        productImage.layer.borderWidth = 5
        productImage.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func setupScroll() {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: containerview.frame.height)
    }

    
}
