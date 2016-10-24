//
//  WatchViewController.swift
//  WatchCollector
//
//  Created by Jeff Pan on 10/13/16.
//  Copyright © 2016 Jeff Pan. All rights reserved.
//

import UIKit

class WatchViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var watchImageView: UIImageView!
    @IBOutlet weak var watchText: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    
    @IBAction func addTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let watch = Watch(context: context)
        watch.title = watchText.text
        watch.image = UIImagePNGRepresentation(watchImageView.image!)! as NSData?
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
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
