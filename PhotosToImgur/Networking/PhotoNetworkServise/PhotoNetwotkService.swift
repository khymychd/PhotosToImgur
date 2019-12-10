//
//  PhotoNetwotkService.swift
//  PhotosToImgur
//
//  Created by KillerBe on 30.11.2019.
//  Copyright © 2019 Khymychcrew. All rights reserved.
//

import UIKit

// This class configure and upload photo and pass url

final class PhotoNetwotkService {
    
    static func postPhoto (image: UIImage, completion: @escaping(String?) -> () ) {
    
        let url = "https://api.imgur.com/3/image"
        guard let imageProperties = ImageProperties(withImage: image, forKey: "image") else {return}
        
        NetworkManager.shared.uploadImage(url: url, data:imageProperties.data, completion: { json , err in
      
            guard let jsonData = json as? ResponseJSONModel else {
                completion(nil)
                return}
            guard let link = jsonData.data.link else { return }
            completion(link)
        })
    }
    
    
}
