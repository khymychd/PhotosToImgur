//
//  PhotoGallary.swift
//  PhotosToImgur
//
//  Created by KillerBe on 27.11.2019.
//  Copyright © 2019 Khymychcrew. All rights reserved.
//

import UIKit
import Photos


class PhotoGallery {
    
private let imgManager = PHImageManager.default()
    var fetchResult: PHFetchResult<PHAsset>
    private func requestOptions() -> PHImageRequestOptions {
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.isNetworkAccessAllowed = true
        return requestOptions
    }
    
    init() {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
    
    }
    
    // Get photo from fetch asset
   
    public func getPhoto(_ index: Int, contentMode: PHImageContentMode, size:CGSize) -> UIImage? {
       var image: UIImage? = nil
       
            
            imgManager.requestImage(for:self.fetchResult.object(at: index),targetSize: size ,contentMode: contentMode,options: self.requestOptions(),resultHandler: {
                img, error in
                guard let img = img else { return }
                 image = img
                    })

        return image
    }
    
}
