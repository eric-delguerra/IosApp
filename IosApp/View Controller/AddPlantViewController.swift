//
//  AddPlantViewController.swift
//  IosApp
//
//  Created by Clémence Beyrie on 07/12/2020.
//

import UIKit
import FirebaseAuth
import Firebase

class AddPlantViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var plantName: UITextField!
    @IBOutlet weak var sunNeed: UISegmentedControl!
    @IBOutlet weak var waterNeed: UISegmentedControl!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var waterTimeTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var validBtn: UIButton!
    @IBOutlet weak var test: UILabel!
    var userId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add a new plant"
        waterLabel.text = "Times per day :"
        waterTimeTxt.keyboardType = .numberPad
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil {
                self.userId = user?.uid
            } else {
                self.test.text = "no user is signed"
            }
            print("truc" + self.userId)
        }
    }
    


    @IBAction func onWaterNeedChange(_ sender: Any) {
        let selectedField =  waterNeed.titleForSegment(at: waterNeed.selectedSegmentIndex)!
        waterLabel.text = "Times per " + selectedField.lowercased() + " :"
    }


       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           self.dismiss(animated: true, completion: nil)
       }

       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
           plantImage.image = image
           self.dismiss(animated: true, completion: nil)
       }
    
    @IBAction func uploadImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self;
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func storeData(_ sender: Any) {
        if plantName != nil {
            let db = Firestore.firestore()
            db.collection("plants").addDocument(data: [
                "userId": userId!,
                "plantName": plantName.text!,
                "sunNeed": sunNeed.titleForSegment(at: sunNeed.selectedSegmentIndex)!,
                "waterNeed" : waterNeed.titleForSegment(at: waterNeed.selectedSegmentIndex)!,
                "waterTime" : waterTimeTxt.text!,
                "description" : descriptionTxt.text!
            ])
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
