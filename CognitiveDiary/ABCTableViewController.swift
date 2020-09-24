//
//  ABCTableViewController.swift
//  CognitiveDiary
//
//  Created by Andrea Mancini on 24/09/2020.
//  Copyright © 2020 Andrea Mancini. All rights reserved.
//

import UIKit

class ABCTableViewController: UITableViewController {

    @IBOutlet weak var contentText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func saveButton(_ sender: UIButton) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        // 1
        let managedContext =
        appDelegate.persistentContainer.viewContext

        // 2
        let entity = DiaryModel.createEntity(in_context: managedContext)!

        let diaryitem =  DiaryModel(entity: entity, insertInto: managedContext)
        
        // 3
        diaryitem.content = contentText.text

        // 4
        do {
            try managedContext.save()
            print("Saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
