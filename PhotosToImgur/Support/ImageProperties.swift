//
//  ImageProperties.swift
//  PhotosToImgur
//
//  Created by KillerBe on 29.11.2019.
//  Copyright © 2019 Khymychcrew. All rights reserved.
//

import UIKit

 struct ImageProperties {
    
    let key: String
    let data: Data
    
    init?(withImage image: UIImage, forKey key:String) {
        self.key = key
        guard let data = image.jpegData(compressionQuality: 1)?.base64EncodedData() else {return nil}
        self.data = data
    }
}
