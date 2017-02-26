//
//  AddViewController.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/23.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, AddViewInterface {

    var eventHandler: AddModuleInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let interactor = AddInteractor()
        interactor.userInterface = self
        
        eventHandler = interactor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveAudioAction(_ sender: RecordBehavior) {
   
        eventHandler.saveAddActionWith(audioName: sender.audioInfo.0, recordDate: sender.audioInfo.1, audioData: sender.audioInfo.2)
    }
    
    // MARK: - AddModuleDelegateInterface
    func addModuleDidSaveAddAction() {
        //弹窗提示已保存完成
        print("addModuleDidSaveAddAction")
    }
    
}
