//
//  ListDataManager.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/23.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import Foundation

class ListDataManager: NSObject {
    lazy var dataStore: CoreDataStore = CoreDataStore()
    
    func fetchAllEntities(_ completionBlock: @escaping ([Audio]) -> Void){
        dataStore.fetchAllAudios { managedAudios in
            
            let audioArr = managedAudios.map {
                Audio(name: $0.name!, recordDate: $0.recordDate! as Date, filePath: $0.filePath!)
            }
            
            completionBlock(audioArr)
        }
    }
}
