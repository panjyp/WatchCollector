//
//  WatchViewController.swift
//  WatchCollector
//
//  Created by Jeff Pan on 10/13/16.
//  Copyright © 2016 Jeff Pan. All rights reserved.
//

import UIKit

class WatchViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var watchImageView: UIImageView!
    @IBOutlet weak var watchText: UITextField!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var watch : Watch? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        // Do any additional setup after loading the view.
        
        if watch != nil {
            watchText.text = watch!.title
            watchImageView.image = UIImage(data: watch!.image as! Data)
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }

    
    @IBAction func addTapped(_ sender: AnyObject) {
        
        if watch != nil {
            watch!.title = watchText.text
            watch!.image = UIImagePNGRepresentation(watchImageView.image!)! as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let watch = Watch(context: context)
            watch.title = watchText.text
            watch.image = UIImagePNGRepresentation(watchImageView.image!)! as NSData?
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(watch!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
   }
    
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func photosTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        watchImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
