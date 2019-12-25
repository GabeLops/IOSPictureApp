//
//  ViewController.swift
//  Project1
//
//  Created by Gabriel Lops on 11/21/19.
//  Copyright © 2019 Gabriel Lops. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                //this is a picture to load
                pictures.append(item)
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
        
        cell?.name.text = pictures[indexPath.row]
        return cell!
    }
        
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
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
    
}

