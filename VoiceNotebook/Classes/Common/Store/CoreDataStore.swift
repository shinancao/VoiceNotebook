//
//  CoreDataStore.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/21.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStore: NSObject {
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "VoiceNotebook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - Audio Persistence

extension CoreDataStore {
   
    func insertAudio(dict: Dictionary<String, Any>) {
        insert("Audio", dict: dict)
    }
    
    func fetchAllAudios(_ completionBlock: @escaping ([ManagedAudio]) -> Void ) {
        let sortDescriptor = NSSortDescriptor(key: "recordDate", ascending: false)
        fetchAll("Audio", sortDescriptors: [sortDescriptor]) { managedObjs in
            let audios = managedObjs as! [ManagedAudio]
            completionBlock(audios)
        }
    }
}

// MARK: - Add/Delete/Query

private extension CoreDataStore {
    func insert(_ entityName: String, dict: Dictionary<String, Any>) {
        let context = persistentContainer.viewContext
        
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        
        let keys = dict.keys
        for i in keys.indices {
            let key = keys[i]
            let val = dict[key]
            object.setValue(val, forKey: key)
        }
        
        context.insert(object)
        saveContext()
    }
    
    func fetchAll(_ entityName: String, sortDescriptors: [NSSortDescriptor]?, completionBlock:(([NSManagedObject]) -> Void)!) {
        let context = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>()
        request.entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        request.sortDescriptors = sortDescriptors
        context.perform { 
            let objects = try?context.fetch(request)
            completionBlock(objects!)
        }
    }
    
    func delete(_ entityName: String, predicateStr: String) {
        let context = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>()
        request.entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let predicate = NSPredicate(format: predicateStr)
        request.predicate = predicate
        let objects = try?context.fetch(request)
        
        for case let obj in objects! {
            context.delete(obj)
        }
        
        saveContext()
    }
    
}
