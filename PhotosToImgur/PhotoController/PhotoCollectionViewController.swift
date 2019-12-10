//
//  PhotoCollectionViewController.swift
//  PhotosToImgur
//
//  Created by KillerBe on 27.11.2019.
//  Copyright © 2019 Khymychcrew. All rights reserved.
//
import UIKit
import CoreData
import Photos

//MARK: - Constans
private let reuseIdentifier = "Cell"
// Count colums for portrait orientation
private let row = 3
// Count colums for landscape orientation
private let padinng = 5
// Spasing between Cell
private let offset:CGFloat = 5


//MARK: - PhotoCollectionViewController
class PhotoCollectionViewController: UICollectionViewController {
    
  var photoGallery: PhotoGallery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       checkAuthorization()
    }
    
// MARK: - Chek authorization stutus
    
    func checkAuthorization () {
        
        if PHPhotoLibrary.authorizationStatus() == .notDetermined{
            DispatchQueue.global().async {
                PHPhotoLibrary.requestAuthorization { (status) in
                       if status == .authorized {
                        DispatchQueue.main.async {
                            self.photoGallery = PhotoGallery()
                            self.collectionView.reloadData()
                        }
                        
                    }
                }
           }
        }else if PHPhotoLibrary.authorizationStatus() == .authorized {
            photoGallery = PhotoGallery()
        }
    }
    
    
//MARK: - Save url after upload image

private func saveUrl (url:String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Link", in: context)
    let linkObject = NSManagedObject(entity: entity!, insertInto: context) as! Link
    linkObject.url = url
    do{
        try context.save()
        print("saved")
        
    }catch{
        print(error)
        
    }
    
    
}
}

extension PhotoCollectionViewController {
    
    // MARK: - UICollectionViewDataSource
     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            guard let photoGallery = photoGallery else { return 0}
            return  photoGallery.fetchResult.count
        }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
            cell.uploadingSpiner.isHidden = true
            guard let photoGallery = photoGallery else {return cell}
            guard let image = photoGallery.getPhoto(indexPath.item, contentMode: .aspectFill, size: .init(width: 200, height: 200)) else {return cell}
            
            cell.imageView.image = image
            return cell
    }

        override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

            let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
            cell.toggleActivityIndicator(on: true)
           guard let photoGallery = photoGallery else {return true}
            // Get original size photo
            guard let fullSizeImage = photoGallery.getPhoto(indexPath.item, contentMode: .default, size: .init()) else {return true}
               
            DispatchQueue.global().async {
                PhotoNetwotkService.postPhoto(image: fullSizeImage , completion:{ [weak self] url in
                DispatchQueue.main.async {
                    if let url = url {
                        cell.toggleActivityIndicator(on: false)
                        self!.saveUrl(url: url)
                    } else {
                        SharedClass.sharedInstance.alertWindow(title: "Error", message: "Image has not uploaded", view: self!)
                        cell.toggleActivityIndicator(on: false)
                    }
                }
                })
           }
            
            return true
        }

    }
        

    
//MARK: - UICollectionViewDelegateFlowLayout
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = sizeForItem(row, offset)
        if UIDevice.current.orientation.isLandscape  {
            size = sizeForItem(padinng, offset)
        }
        return size
    }
    
    // Counting size for item
    private func sizeForItem (_ countItem: Int , _ offset:CGFloat) -> CGSize{
        let widthCell = collectionView.frame.width / CGFloat(countItem)
        let hightCell = widthCell - (offset*2)
        let spacing = CGFloat((countItem + 1)) * offset / CGFloat(countItem)
        collectionView.collectionViewLayout.invalidateLayout()
        return CGSize(width: widthCell - spacing, height: hightCell )
    }
    
}
