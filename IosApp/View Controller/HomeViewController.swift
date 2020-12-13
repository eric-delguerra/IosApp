//
//  HomeViewController.swift
//  IosApp
//
//  Created by Clémence Beyrie on 25/11/2020.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addBtn: UIButton!
    var plants = [Plant]()
    let plantsName = ["Plante grasse", "tulipe", "coquelicot"]
    let images = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3")]
    let plantsDescription = ["Arrosée y'a longtemps", "Bientôt à arroser", "N'arrose pas"]
    var userId: String!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        plants.append(Plant(name: "Plante grasse", description: "Arrosée y'a longtemps", image: UIImage(named: "1")!))
//        plants.append(Plant(name: "Tulipe", description: "Arrosée y'a longtemps", image: UIImage(named: "2")!))
//        plants.append(Plant(name: "Coquelicot", description: "Arrosée y'a longtemps", image: UIImage(named: "3")!))
        
        collectionView.delegate = self
        collectionView.dataSource = self
      
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil {
                self.userId = user?.uid
                
                let db = Firestore.firestore()

                db.collection("plants").whereField("userId", isEqualTo: self.userId!)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            self.plants.removeAll()
                            for document in querySnapshot!.documents {
//                                print("\(document.documentID) => \(document.data())")
                                let infos = document.data()
                                
                                let plantName = infos["plantName"] as! String

                                let description = infos["description"] as! String

                                let image = self.images[0]! as! UIImage

                                let waterTime = infos["waterTime"] as! String

                                let waterNeed = infos["waterNeed"] as! String

                                let sunNeed = infos["sunNeed"] as! String

                                let plant = Plant(name: plantName, description: description, image: image, waterTime: waterTime, waterNeed : waterNeed, sunNeed: sunNeed)

                                self.plants.append(plant)
                            }
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                }
            } else {
                self.userId = "no user"
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCell", for: indexPath) as! CollectionViewCell
        
        cell.plantLabel.text = plants[indexPath.row].name
        cell.plantImage.image = plants[indexPath.row].image
        cell.plantDescription.text = plants[indexPath.row].descritpion
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let plantName = plantsName[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let plantVC = storyboard.instantiateViewController(identifier: "plant") as! PlantViewController
        plantVC.imgplant = plants[indexPath.row].image
        plantVC.rap = plants[indexPath.row].waterTime
        plantVC.lastArrosage = plants[indexPath.row].waterTime
        plantVC.sunneed = plants[indexPath.row].sunNeed
        // set les variables ici
        self.navigationController?.pushViewController(plantVC, animated: true)
    }

}
