//
//  Plant.swift
//  IosApp
//
//  Created by Clémence Beyrie on 03/12/2020.
//

import UIKit

class Plant {
    var name: String!
    var descritpion: String!
    var image: UIImage!
    var waterTime: Int!
    var waterNeed: String!
    var sunNeed: String!
    
    init(name: String, description: String, image: UIImage, waterTime: Int, waterNeed: String, sunNeed: String) {
        self.name = name
        self.descritpion = description
        self.image = image
        self.waterTime = waterTime
        self.waterNeed = waterNeed
        self.sunNeed = sunNeed
    }
}
