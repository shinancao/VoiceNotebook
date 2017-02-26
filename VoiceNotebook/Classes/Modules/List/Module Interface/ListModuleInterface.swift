//
//  ListModuleInterface.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/24.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import Foundation

protocol ListModuleInterface {
    func updateView()
    func playAudio(at filePath: String)
    func stopPlaying()
}
