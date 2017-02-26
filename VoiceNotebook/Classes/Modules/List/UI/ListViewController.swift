//
//  ListViewController.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/24.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var eventHandler: ListModuleInterface!
    var dataArr: [AudioDisplayData]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let interactor = ListInteractor()
        interactor.userInterface = self
        
        eventHandler = interactor
        
        eventHandler.updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Help Method
    func setAudio(at index: Int, isPlaying: Bool) {
        var audio = dataArr![index]
        audio.isPlaying = isPlaying
        dataArr![index] = audio
    }

}

extension ListViewController: ListViewInterface {
    func showAudioDisplayData(data: [AudioDisplayData]) {
        dataArr = data
        tableView.reloadData()
    }
    
    func audioPlayerDidFinishPlaying() {
        if let index = dataArr!.index(where: { $0.isPlaying == true}) {
            
            setAudio(at: index, isPlaying: false)
            
            tableView.reloadData()
        }
    }
}

extension ListViewController: ListCellDelegateInterface {
    func didTapPlayAudio(_ audio: AudioDisplayData) {
        if let index = dataArr!.index(where: { $0.isPlaying == true}) {
            setAudio(at: index, isPlaying: false)
        }
        
        if let index = dataArr!.index(where: { $0 == audio}) {
            setAudio(at: index, isPlaying: true)
        }
        
        tableView.reloadData()
        eventHandler.playAudio(at: audio.filePath)

    }
}
