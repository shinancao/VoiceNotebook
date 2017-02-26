//
//  ListInteractor.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/24.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import Foundation
import AVFoundation

class ListInteractor: NSObject, ListModuleInterface {
    lazy var dataManager = ListDataManager()
    
    var userInterface: ListViewInterface?
    
    var player: AVAudioPlayer?
    
    func updateView() {
        
        dataManager.fetchAllEntities { audios in
            let data = audios.map{ AudioDisplayData(name: $0.name)
            }
            
            self.userInterface?.showAudioDisplayData(data: data)
        }
    }
    
    func playAudio(at filePath: String) {
        
        stopPlaying()
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
            player?.delegate = self
            player?.play()
        } catch {
            print(error)
        }
    }
    
    func stopPlaying() {
        if let p = player, p.isPlaying {
            p.stop()
        }
    }
}

extension ListInteractor: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        userInterface?.audioPlayerDidFinishPlaying()
    }
}
