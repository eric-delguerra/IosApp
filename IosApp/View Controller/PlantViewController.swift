//
//  PlantViewController.swift
//  IosApp
//
//  Created by Clémence Beyrie on 03/12/2020.
//

import UIKit

class PlantViewController: UIViewController {
    
    @IBOutlet weak var plantImage: UIImageView!
    
    var imgplant: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        plantImage.image = imgplant
        // Do any additional setup after loading the view.
    }

    

}
