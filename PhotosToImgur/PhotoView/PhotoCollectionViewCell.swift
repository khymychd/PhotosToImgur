//
//  PhotoCollectionViewCell.swift
//  PhotosToImgur
//
//  Created by KillerBe on 27.11.2019.
//  Copyright © 2019 Khymychcrew. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
       
    @IBOutlet weak var uploadingSpiner: UIActivityIndicatorView!
    
    
    func toggleActivityIndicator (on: Bool) {
        if on {
            uploadingSpiner.startAnimating()
            uploadingSpiner.isHidden = false
        }else {
            uploadingSpiner.stopAnimating()
            uploadingSpiner.isHidden = true
        }
    }
    
    
}
