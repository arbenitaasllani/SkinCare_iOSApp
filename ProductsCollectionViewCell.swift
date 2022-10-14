//
//  ProductsCollectionViewCell.swift
//  SkinCare Project
//
//  Created by TDI Student on 29.9.22.
//

import UIKit
import SDWebImage

protocol ProductDelegate {
    func seeMore(product: Product)
}

class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    var delegate: ProductDelegate?
    var product = Product()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //  code
    }
    func setDetails(products : Product){
        self.product = products
        productImg.sd_setImage(with: URL(string: products.image ?? ""))
        nameLabel.text = products.name ?? ""
        productImg.layer.cornerRadius = 15
    }

    @IBAction func seeMoreButton(_ sender: Any) {
        delegate?.seeMore(product: product)
    }
    
}
