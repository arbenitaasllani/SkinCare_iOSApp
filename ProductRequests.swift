//
//  ProductRequests.swift
//  SkinCare Project
//
//  Created by TDI Student on 8.10.22.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProductRequests: NSObject {
    static func getProducts(completionHandler: @escaping(_ products: [Product]?, _ error: Error?) -> Void) {
        let endpoint = "https://api.escuelajs.co/api/v1/products"
        
        AF.request(endpoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let data):
                print("getProducts data = \(data)")

                let jsonData = JSON(data)
                if let products = Product.transform(jsonArray: jsonData.array ?? []) {
                    completionHandler(products, nil)
                }
            case .failure(let error):
                print("getProducts error = \(error)")
                completionHandler(nil, error)
            }
        }
    }
}
