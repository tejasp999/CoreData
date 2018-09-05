//
//  GoalCell.swift
//  GoalSettingApp
//
//  Created by Teja PV on 9/4/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    func configureCell(description : String, type : GoalType, progress : Int){
        self.goalDescriptionLbl.text = description
        self.goalTypeLbl.text = type.rawValue
        self.goalProgressLbl.text = String(describing: progress)
    }
}
