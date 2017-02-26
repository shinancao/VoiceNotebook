//
//  ListCell.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/24.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import UIKit

protocol ListCellDelegateInterface {
    func didTapPlayAudio(_ audio: AudioDisplayData)
}

class ListCell: UITableViewCell {
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var audioNameLabel: UILabel!
    
    var audioDisplayData: AudioDisplayData?
    
    var delegate: ListCellDelegateInterface?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        audioNameLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ audio: AudioDisplayData) {
        audioDisplayData = audio
        
        playButton.isEnabled = !audio.isPlaying
        audioNameLabel.text = audio.name
        
        if audio.isPlaying {
            audioNameLabel.textColor = UIColor.gray
        } else {
            audioNameLabel.textColor = UIColor.black
        }
    }

    @IBAction func playAudio(_ sender: Any) {
        if let audio = audioDisplayData {
            delegate?.didTapPlayAudio(audio)
        }
    }
 
}
