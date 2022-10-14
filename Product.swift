//
//  ProductsApi.swift
//  SkinCare Project
//
//  Created by TDI Student on 8.10.22.
//

import Foundation
import SwiftyJSON

class Product: NSObject {
    var name: String?
    var Description: String?
    var image: String?

    static func transform(json: JSON) -> Product? {
        let product = Product()
        
        if let name = json["title"].string {
            product.name = name
        }
        
        if let Description = json["description"].string {
            product.Description = Description
        }
        
        if let imagesJson = json["images"].array {
            print("imagesJson = \(imagesJson)")

            if imagesJson.count > 0 {
                if let image1 = imagesJson[0].string {
                    product.image = image1
                }
            }
        }
        return product
    }
    
    static func transform(jsonArray: [JSON]) -> [Product]? {
        var productsArray: [Product] = []
        for jsonObject in jsonArray {
            if let product = transform(json: jsonObject) {
                productsArray.append(product)
            }
        }
        return productsArray
    }
}
