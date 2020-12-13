//
//  PlantViewController.swift
//  IosApp
//
//  Created by Clémence Beyrie on 03/12/2020.
//

import UIKit

class PlantViewController: UIViewController {
    
    @IBOutlet weak var plantImage: UIImageView!
    
    @IBOutlet weak var lastWatered: UILabel!
    
    @IBOutlet weak var rappel: UILabel!
    @IBOutlet weak var sunNeed: UILabel!
    
    var imgplant: UIImage!
    var lastArrosage: String!
    var rap: String!
    var sunneed: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        plantImage.image = imgplant
        lastWatered.text = lastArrosage
        rappel.text = rap
        sunNeed.text = sunneed
        // Do any additional setup after loading the view.
    }

    

}
