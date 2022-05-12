//
//  WebService.swift
//  ShopApp
//
//  Created by developer on 5/11/22.
//

import Foundation
import UIKit

let productStr = "https://makeup-api.herokuapp.com/api/v1/products.json"

struct WebService {
    static let shared = WebService()
    
    private init() {}
    
    let cache = NSCache<NSString, UIImage>()
    
    var imageErrorData: Data {
        UIImage(named: "imageError")!.pngData()!
    }
    
    func getProducts(complection: @escaping ([Product]) -> Void) {
        guard let url = URL(string: productStr) else {
            print("URL Error")
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Data Error")
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                    print("Response code Error")
                return
            }
            
            do {
                let model = try JSONDecoder().decode([Product].self, from: data)
                complection(model)
            } catch {
                print("Parssing Error")
                print(error)
            }

        }.resume()
    }
    
    func getImage(imageUrl: String, completion: @escaping(Data?) -> Void) {
        
        guard let url = URL(string: imageUrl) else {
            print("Invalid Link")
            return
        }
        
        if let image = cache.object(forKey: imageUrl as NSString) {
            print("image from cache")
            completion(image.pngData())
            return
        }
        
       let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Image data error")
                completion(self.imageErrorData)
                self.cache.setObject(UIImage(data: self.imageErrorData)!, forKey: imageUrl as NSString)
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                print("Image Response Error")
                return
            }
            if let image = UIImage(data: data) {
                print("fetching image from url")
                self.cache.setObject(image, forKey: imageUrl as NSString)
                completion(image.pngData())
            } else {
                completion(data)
            }
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            task.resume()
        }
        
    }
}
