//
//  ListTableViewDelegate.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/24.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import UIKit

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var audio = dataArr![indexPath.row]
        audio.isPlaying = false
        dataArr![indexPath.row] = audio
        tableView.reloadData()
        eventHandler.stopPlaying()
    }
}
