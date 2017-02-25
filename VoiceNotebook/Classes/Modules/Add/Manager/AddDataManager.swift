//
//  AddDataManager.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/23.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import Foundation

class AddDataManager: NSObject {
    lazy var dataStore: CoreDataStore = CoreDataStore()
    
    func addNewAudio(_ audio: Audio) {
        dataStore.insertAudio(dict: audio.toDictionary())
    }
}
