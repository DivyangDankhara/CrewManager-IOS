//
//  File Name: TaskViewController.swift
//  Project : Assignment 1 MAD
//  Programmer: Habib Shakibanejad
//  First Version : 2020-09-28
//  Description : This file contains code to tasks screeen
//  Copyright © 2020 Conestoga College. All rights reserved.
//

import UIKit
import CoreData

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewTap: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var newInput: UITextField!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet weak var easyToggle: UISwitch!
    @IBOutlet weak var middleToggle: UISwitch!
    @IBOutlet weak var hardToggle: UISwitch!
    
    // local variables
    var jobId :String = ""
    var selectedJob:Job?
    var jobsTask:[Task]?
    
    let context = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    func fetchJobsTask(){
        
        // Fatch Jobs from data base to table view
        do {
            let availabeJobs:[Job]? =  try context.fetch(Job.fetchRequest())
            
            for job in availabeJobs! {
                if job.name == jobId {
                    selectedJob  = job
                }
            }
            jobsTask = selectedJob?.tasks?.allObjects as? [Task]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {}
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedJob?.tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        cell.textLabel?.text = jobsTask?[indexPath.row].name
        return cell
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
    
    //Function Name: addTaskBtn
    //Description: This method is called after when user is tryin gto create new task for the job.
    //Parameters : None
    //Returns : Nothing
    @IBAction func addTaskBtn(_ sender: UIButton) {
        
        if newInput.text == "" {
            errorLabel.isHidden = false
        }
        else {
            let value:String = newInput.text!
            
            let newTask = Task(context: self.context)
            newTask.name = value
            jobsTask?.append(newTask)
            newTask.job = selectedJob
            
            do {
                try self.context.save()
            }
            catch{}
            
            self.tableView.reloadData()
            errorLabel.isHidden = true
        }
    }
    

    //Function Name: viewDidLoad
    //Description: This method is called after the view controller has loaded its view hierarchy into memory.
    //Parameters : None
    //Returns : Nothing
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        jobLabel?.text = "Job Name : " + jobId
        fetchJobsTask()
        //view.isUserInteractionEnabled = true
        
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(jobsTask?[indexPath.row].name ?? "Empty")
    }
    
    //Function Name: easyToggleOnChange
    //Description: This method is called when user toggle task dificulty level easy.
    //Parameters : None
    //Returns : Nothing
    @IBAction func easyToggleOnChange(_ sender: Any) {
        if easyToggle.isOn == true {
            middleToggle.isOn = false
            hardToggle.isOn = false
        }
        else {
            easyToggle.isOn = true
        }
    }
    //Function Name: middleToggleOnChange
    //Description: This method is called when user toggle task dificulty level medium.
    //Parameters : None
    //Returns : Nothing
    @IBAction func middleToggleOnChange(_ sender: Any) {
        if middleToggle.isOn == true {
            easyToggle.isOn = false
            hardToggle.isOn = false
        }
        else {
            middleToggle.isOn = true
        }
    }
    
    //Function Name: hardToggleOnChange
    //Description: This method is called when user toggle task dificulty level hard.
    //Parameters : None
    //Returns : Nothing
    @IBAction func hardToggleOnChange(_ sender: Any) {
        if hardToggle.isOn == true {
            middleToggle.isOn = false
            easyToggle.isOn = false
        }
        else {
            hardToggle.isOn = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let controller = segue.destination as! TaskInfoViewController
            controller.taskName = jobsTask?[indexPath.row].name ?? "Empty"
            controller.jobName = selectedJob!.name ?? "Empty"
        }
    }
}
