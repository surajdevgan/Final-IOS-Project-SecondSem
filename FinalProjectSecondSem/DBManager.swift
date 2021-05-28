//
//  DBManager.swift
//  LabTest1
//
//  Created by Suraaj Devgn on 23/05/21.
//

import UIKit
import CoreData


class DBManager
{
    static let share = DBManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "FinalProjectSecondSem")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    lazy var context = persistentContainer.viewContext

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchUser() -> [User]
    {
        
        var user = [User]()
        let fetchRequest = User.fetchRequest() as NSFetchRequest<User>
    
        
        // Now filtering and sorting on the request
        /*
         This is the hardcode way
        let pred = NSPredicate(format: "name CONTAINS 'Suraj'")
         
         */
        
        /*
        let pred = NSPredicate(format: "school between %@", "Suraj") // here we can take any dynamic varibale instead of S
        
        fetchRequest.predicate = pred
 
         */let sort = NSSortDescriptor(key: "game_score", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        
        
        do
        
        {
            
            user = try context.fetch(fetchRequest)
            
            
        }
        
        catch{
            
            print("Some error occured when fetching the products")

        }
        
        
        return user
        
    }
    
   
    
    
    
}


