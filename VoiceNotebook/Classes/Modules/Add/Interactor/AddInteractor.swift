//
//  AddInteractor.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/24.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import Foundation

class AddInteractor: NSObject, AddModuleInterface {
    lazy var dataManager = AddDataManager()
    
    var userInterface: AddViewInterface?
    
    lazy var audioDirPath: String? = {
        return AddInteractor.createAudioDir()
    }()
    
    
    func saveAddActionWith(audioName: String, recordDate: Date, audioData: Data) {
        let audioPath = audioDirPath! + "/"+audioName
        do {
            try audioData.write(to: URL(fileURLWithPath: audioPath))
            let audio = Audio(name: audioName, recordDate: recordDate, filePath: audioPath)
            dataManager.addNewAudio(audio)
            print("audioPath:"+audioPath)
            userInterface?.addModuleDidSaveAddAction()
        } catch {
            print(error)
        }
    }
    
    private static func createAudioDir() -> String? {
        let fileManager = FileManager.default
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        
        let dirPath = documentsDirectory + "/audio"
        if !fileManager.fileExists(atPath: dirPath) {
            do {
                try fileManager.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
                return dirPath
            } catch {
                return nil
            }
        } else {
            return dirPath
        }
    }
}
