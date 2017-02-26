//
//  AudioDisplayData.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/24.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import Foundation

struct AudioDisplayData: Equatable {
    let filePath: String
    let name: String
    var isPlaying: Bool
    
    init(name: String) {
        self.name = name
        filePath = FileManager.audioDir + name
        isPlaying = false
    }
}

func == (lhs: AudioDisplayData, rhs: AudioDisplayData) -> Bool {
    return lhs.name == rhs.name
}

