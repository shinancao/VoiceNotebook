//
//  ListTableViewDataSource.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/24.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import UIKit

extension ListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = dataArr {
            return data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        let audio = dataArr![indexPath.row]
        cell.delegate = self
        cell.setup(audio)
        return cell
    }
    
}
