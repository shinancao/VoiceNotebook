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

}

extension ListViewController: ListViewInterface {
    func showAudioDisplayData(data: [AudioDisplayData]) {
        dataArr = data
        tableView.reloadData()
    }
    
    func audioPlayerDidFinishPlaying() {
        if let index = dataArr!.index(where: { $0.isPlaying == true}) {
            var audio = dataArr![index]
            audio.isPlaying = false
            dataArr![index] = audio
            
            tableView.reloadData()
        }
    }
}

extension ListViewController: ListCellDelegateInterface {
    func didTapPlayAudio(_ audio: AudioDisplayData) {
        if let index = dataArr!.index(where: { $0.isPlaying == true}) {
            var temp = dataArr![index]
            temp.isPlaying = false
            dataArr![index] = temp
        }
        
        if let index = dataArr!.index(where: { $0 == audio}) {
            var temp = dataArr![index]
            temp.isPlaying = true
            dataArr![index] = temp
        }
        
        tableView.reloadData()
        eventHandler.playAudio(at: audio.filePath)

    }
}
