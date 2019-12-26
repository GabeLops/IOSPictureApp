//
//  ViewController.swift
//  Project1
//
//  Created by Gabriel Lops on 11/21/19.
//  Copyright © 2019 Gabriel Lops. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [Photo]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         let defaults = UserDefaults.standard
               if let savedPictures = defaults.object(forKey: "load") as? Data {
                   let jsonDecoder = JSONDecoder()
                   
                   do {
                       pictures = try jsonDecoder.decode([Photo].self, from: savedPictures)
                   } catch {
                       print("Failed to load data")
                   }
               }

        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                let picture = Photo(name: item, views: 0)
                pictures.append(picture)
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "RECOMMEND", style: .plain, target: self, action: #selector(shareTap))
        
    
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? ImageCell
        
           
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 2
        cell?.layer.cornerRadius = 3
        let picture = pictures[indexPath.item]
        cell?.name.text = (picture.name)
        return cell!
    }
        
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let picture = pictures[indexPath.item]
            vc.selectedImage = picture.name
            picture.views += 1
            imageLoaded()
            vc.selectedPictureNumber = indexPath.item + 1
            vc.totalpictures = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
  
    @objc func shareTap() {
           
        
        let share = UIActivityViewController(activityItems: ["Recommend this to friends"], applicationActivities: [])
           share.popoverPresentationController?.barButtonItem =
           navigationItem.rightBarButtonItem
           present(share, animated: true)
       }
    
    func imageLoaded() {
        let jsonEncoder = JSONEncoder()
        if let imageLoad = try? jsonEncoder.encode(pictures) {
            
            let defaults = UserDefaults.standard
            defaults.set(imageLoad, forKey: "load")
            
        }else {
            print("Failed to load image.")
        }
    }
    
}

