//
//  DogAPI.swift
//  Randog
//
//  Created by Emil 👨🏻‍💻 Haroutunian on 1/6/21.
//

import Foundation
import UIKit

class DogAPI {
    
    enum Endpoint {
        
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
     
                
            }
        }
    }
    class func requestImageFile(url: URL, completionHandler: @escaping ( UIImage?,  Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil,error)
                return
            }
            
            let downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                completionHandler(downloadedImage, nil)
            }
            
            
        }
        task.resume()
    }
    
    class func requestRandomImage(breed: String,completionHandler: @escaping (DogImage?, Error?)-> Void) {
        let randomImageEndpoint =
            DogAPI.Endpoint.randomImageForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else  {
                completionHandler(nil, error)
                print("Data error line 18")
                return
            }
            //Creating the Decoder
            let decoder = JSONDecoder()
            //Decoding the data
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    
}


