//
//  ViewController.swift
//  WatchCollector
//
//  Created by Jeff Pan on 10/13/16.
//  Copyright © 2016 Jeff Pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var watches: [Watch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            watches = try context.fetch(Watch.fetchRequest())
            tableView.reloadData()
        } catch {
            
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let watch = watches[indexPath.row]
        
        cell.textLabel?.text = watch.title
        cell.imageView?.image = UIImage(data: watch.image as! Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let watch = watches[indexPath.row]
        performSegue(withIdentifier: "watchSegue", sender: watch)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! WatchViewController
        
        nextVC.watch = sender as? Watch
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

