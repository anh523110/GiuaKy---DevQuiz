//
//  TopicTableViewCell.swift
//  PersonalQuiz
//
//  Created by admin on 7/24/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewTopic: UIImageView!
    @IBOutlet weak var lblTopicName: UILabel!
    @IBOutlet weak var lblPoint: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
