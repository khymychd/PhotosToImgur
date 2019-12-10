//
//  SharedClass.swift
//  PhotosToImgur
//
//  Created by KillerBe on 01.12.2019.
//  Copyright © 2019 Khymychcrew. All rights reserved.
//

import UIKit

class SharedClass: NSObject {
   
    static let sharedInstance = SharedClass()
    
    public func alertWindow(title: String, message: String, view : UIViewController) {
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
       })
       alert.addAction(defaultAction)
    DispatchQueue.main.async{
       view.present(alert, animated: true)
    }
    
}
}
