//
//  ListInteractor.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/24.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import Foundation

class ListInteractor: NSObject, ListModuleInterface {
    lazy var dataManager = ListDataManager()
    
    var userInterface: ListViewInterface?
    
    func updateView() {
        
        dataManager.fetchAllEntities { audios in
            let data = audios.map{ AudioDisplayData(name: $0.name, filePath: $0.filePath, isPlaying: false)
            }
            
            self.userInterface?.showAudioDisplayData(data: data)
        }
    }
}
