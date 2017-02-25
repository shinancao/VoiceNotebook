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
    var dataProperty: [AudioDisplayData]?
    
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
        dataProperty = data
        tableView.reloadData()
    }
}
