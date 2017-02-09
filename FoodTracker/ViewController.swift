//
//  ViewController.swift
//  FoodTracker
//
//  Created by Kevin Tran on 2/6/17.
//  Copyright © 2017 Kevin Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        //take the users input in the text field through a delegate callback
        nameTextField.delegate = self
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // if user cancels, then dimiss photo picker
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // grab the selected image to display on view, if error then display the original (info)
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // set the photoImageView's image to be the one selected
        photoImageView.image = selectedImage
        
        // update with animated: true and completed, then dimiss the photo picker
        dismiss(animated: true, completion: nil)
        
        //dont forget to update the Info.plist (privacy - photo library description) to allow the app access to the users photos
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // hide keyboard upon user click on image
        nameTextField.resignFirstResponder()
        
        // create a UIImagePickerController constant that allows the user to pick images from their photo library
        let imagePickerController = UIImagePickerController()
        
        // only photos from photolibrary
        imagePickerController.sourceType = .photoLibrary
        
        // notify and update the ViewController with the user's image
        imagePickerController.delegate = self
        
        // update and present the imagePickerController with animated: true and completed
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
    
}
