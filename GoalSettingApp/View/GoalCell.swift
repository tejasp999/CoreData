//
//  GoalCell.swift
//  GoalSettingApp
//
//  Created by Teja PV on 9/4/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var completionView: UIView!
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    func configureCell(goal : Goal){
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        if goal.goalProgress == goal.goalCompletionValue{
            completionView.isHidden = false
        }else{
            completionView.isHidden = true
        }
    }
}
