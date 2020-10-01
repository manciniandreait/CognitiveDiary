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
    
    let screenHeigth = UIScreen.main.bounds.height
    var sentData : DiaryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (sentData != nil)
        {
            titleText.text = sentData?.title
            let contentList = sentData?.content?.components(separatedBy: "^")
            aContentText.text = contentList?[0]
            bContentText.text = contentList?[1]
            cContentText.text = contentList? [2]
            
        }
        else
        {
            titleText.placeholder = generateTitle()
            aContentText.placeholder = "Type your thoughts"
            bContentText.placeholder = "Type your thoughts"
            cContentText.placeholder = "Type your thoughts"
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row == 0 ||  indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7)
        {
            return screenHeigth*0.05
        }
        else
        {
            return screenHeigth*0.20
        }
            
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
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
        if let text = titleText.text, text.isEmpty
        {
            titleText.text = titleText.placeholder
        }
        diaryItem.title = titleText.text
        
        //sistemare sta porcata
        diaryItem.content = aContentText.text
        diaryItem.content?.append("^" + bContentText.text)
        diaryItem.content?.append("^" + cContentText.text)

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
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let result = formatter.string(from: date)
        
        return "New ABC Notes - " + result
    }

}
