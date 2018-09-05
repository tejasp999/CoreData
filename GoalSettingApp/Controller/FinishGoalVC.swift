//
//  FinishGoalVC.swift
//  GoalSettingApp
//
//  Created by Teja PV on 9/4/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    
    var goalDesc : String!
    var goalType : GoalType!
    
    func initData(description: String, type : GoalType){
        self.goalDesc = description
        self.goalType = type
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyBoard()
        pointsTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func createGoalBtnPressed(_ sender: Any) {
        //Pass data into core data model
        if pointsTextField.text != ""{
            self.save { (complete) in
                if complete{
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion : (_ finished : Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDesc
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        do{
            try managedContext.save()
            completion(true)
        } catch{
            debugPrint("Could not save \(error.localizedDescription)")
            completion(false)
        }
        
        
    }
    

}
