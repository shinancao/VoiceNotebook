//
//  RecordBehavior.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/23.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import UIKit
import AVFoundation

let audioFormat = ".caf"

class RecordBehavior: UIControl, AVAudioPlayerDelegate {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var recorder: AVAudioRecorder!
    var player: AVAudioPlayer!
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter
    }()
    
    var enablePlay: Bool = false {
        didSet {
            playButton.isEnabled = enablePlay
            doneButton.isEnabled = enablePlay
        }
    }
    
    var enableRecord: Bool = true {
        didSet {
            recordButton.isEnabled = enableRecord
        }
    }
    
    var audioInfo: (String, Date, Data) {
        get {
            let url = URL(fileURLWithPath: recorder.url.absoluteString)
            let data = try?Data(contentsOf: url)
            let lastPathCmp = recorder.url.lastPathComponent
            let dateStr = lastPathCmp.components(separatedBy: ".").first
            return (lastPathCmp, formatter.date(from: dateStr!)!, data!)
        }
    }
    
    //音频编码参数
    let recordSettings = [AVSampleRateKey : NSNumber(value: Float(44100.0)),//声音采样率
        AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC)),//编码格式
        AVNumberOfChannelsKey : NSNumber(value: 1),//采集音轨
        AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue))]//音频质量
    
    override init(frame: CGRect) {
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            
        } catch {
            
        }
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        FileManager.default.clearDir(FileManager.tempDir)
    }
    
    private func audioFileURL() -> URL? {
        let currentDateTime = Date()
        let audioName = formatter.string(from: currentDateTime) + audioFormat
        
        let tmpDirectory = URL(string:FileManager.tempDir)
        let soundURL = tmpDirectory?.appendingPathComponent(audioName)
        return soundURL
    }
    
    // MARK - record
    
    @IBAction func touchDownStart(_ sender: Any) {
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(true)
            try recorder = AVAudioRecorder(url: self.audioFileURL()!, settings: recordSettings)
            recorder.prepareToRecord()
            recorder.record()
        } catch {
            
        }
        
        enablePlay = false
        
    }
    
    @IBAction func touchUpOutsideCancel(_ sender: Any) {
        
    }
    
    @IBAction func touchUpInsideFinish(_ sender: Any) {
        recorder.stop()
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false)
        } catch {
            
        }
        
        enablePlay = true
    }
    
    // MARK -
    
    @IBAction func playAudio(_ sender: Any) {
        if player != nil && player.isPlaying {
            //正在播放时点击，则停止播放
            player.stop()
            
            playButton.setTitle("播放", for: .normal)
            enableRecord = true
            
        } else {
            playButton.setTitle("暂停", for: .normal)
            do {
                try player = AVAudioPlayer(contentsOf: recorder.url)
                player.delegate = self
                player.play()
                
                enableRecord = false
                
            } catch {
                
            }
        }
    }
    
    @IBAction func saveAudio(_ sender: Any) {
        
        sendActions(for: .touchUpInside)
    }
    
    // MARK - AVAudioPlayerDelegate
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        enableRecord = true
    }
    
}
