//
//  ViewController.swift
//  GoalSettingApp
//
//  Created by Teja PV on 9/4/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalVC: UIViewController {

    var goals : [Goal] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataObjects()
        tableView.reloadData()
    }
    
    func fetchDataObjects(){
        self.fetch { (complete) in
            if complete{
                if goals.count >= 1{
                    tableView.isHidden = false
                }
            }else{
                tableView.isHidden = true
            }
        }
    }

    @IBAction func addButtonAction(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {
            return
        }
        presentDetail(createGoalVC)
    }
    
}

extension GoalVC : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let goal = goals[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else{
            return UITableViewCell()
        }
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "Add 1") { (rowAction, indexPath) in
            self.set(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        return [deleteAction, addAction]
    }
}

extension GoalVC{
    func removeGoal(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(goals[indexPath.row])
        do{
            try managedContext.save()
        }catch{
            debugPrint("Could not remove \(error.localizedDescription)")
        }
    }
    
    func fetch(completion : (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do{
            goals = try managedContext.fetch(fetchRequest)
            print("The fetch was successful")
            completion(true)
        } catch{
            debugPrint("Could not fetch \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func set(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue{
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        }else {
            return
        }
        do{
            try managedContext.save()
        }catch{
            debugPrint("Could not set progress \(error.localizedDescription)")
        }
    }
}

