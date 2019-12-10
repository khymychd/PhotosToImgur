//
//  ResponseJSONModel.swift
//  PhotosToImgur
//
//  Created by KillerBe on 29.11.2019.
//  Copyright © 2019 Khymychcrew. All rights reserved.
//

import Foundation
// JSON response model
struct ResponseJSONModel: Codable {
    var data : ResponseData
}
struct ResponseData: Codable {
    
    var link:String?

}
