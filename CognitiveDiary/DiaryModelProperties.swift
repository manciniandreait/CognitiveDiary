//
//  DiaryModel+CoreDataProperties.swift
//  CognitiveDiary
//
//  Created by Alberto Azzari on 25/09/2020.
//  Copyright © 2020 Andrea Mancini. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


extension DiaryModel {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<DiaryModel> {
        return NSFetchRequest<DiaryModel>(entityName: "Diary")
    }
    
    @nonobjc public class func createEntity(in_context: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: "Diary", in: in_context)
    }
    
    @nonobjc public class func fetchData() throws -> [DiaryModel]?  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = DiaryModel.createFetchRequest()
        
        return try managedContext.fetch(fetchRequest)
    }
        

    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var title: String?

}

extension DiaryModel : Identifiable {

}
