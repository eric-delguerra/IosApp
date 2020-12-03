//
//  HomeViewController.swift
//  IosApp
//
//  Created by Clémence Beyrie on 25/11/2020.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!

    let plantsName = ["Plante grasse", "tulipe", "coquelicot"]
    
    let images = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3")]
    
    let plantsDescription = ["Arrosée y'a longtemps", "Bientôt à arroser", "N'arrose pas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plantsName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCell", for: indexPath) as! CollectionViewCell
        
        cell.plantLabel.text = plantsName[indexPath.row]
        cell.plantImage.image = images[indexPath.row]
        cell.plantDescription.text = plantsDescription[indexPath.row]
        
        return cell
    }

}
