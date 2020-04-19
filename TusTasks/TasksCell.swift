//
//  TasksCell.swift
//  TusTasks
//
//  Created by 石川　太洋 on 2020/04/11.
//  Copyright © 2020 石川　太洋. All rights reserved.
//

import UIKit

class TasksCell: UITableViewCell {
    
    var dt = Date()
    var dateFormatter = DateFormatter()
    
    @IBOutlet weak var d: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd", options: 0, locale: Locale(identifier: "ja_JP"))
        
        d.text = dateFormatter.string(from: dt)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
