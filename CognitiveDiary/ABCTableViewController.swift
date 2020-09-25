//
//  ABCTableViewController.swift
//  CognitiveDiary
//
//  Created by Andrea Mancini on 24/09/2020.
//  Copyright © 2020 Andrea Mancini. All rights reserved.
//

import UIKit

class ABCTableViewController: UITableViewController {

    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var aContentText: UITextView!
    @IBOutlet weak var bContentText: UITextView!
    @IBOutlet weak var cContentText: UITextView!
    
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

        let diaryItem =  DiaryModel(entity: entity, insertInto: managedContext)
        
        // 3
        if let text = titleText.text, text.isEmpty {
            titleText.text = generateTitle()
        }

        diaryItem.title = titleText.text
        diaryItem.content = aContentText.text + bContentText.text + cContentText.text

        // 4
        do {
            try managedContext.save()
            print("saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func generateTitle() -> String
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm"
        let result = formatter.string(from: date)
        
        return "New ABC Notes - " + result
    }

}
