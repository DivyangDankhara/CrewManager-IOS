//
//  File Name: JobViewController.swift
//  Project : Assignment 1 MAD
//  Programmer: Divyangbhai Dankhara
//  First Version : 2020-09-28
//  Description : This file contains code to jobs screeen
//  Copyright © 2020 Conestoga College. All rights reserved.
//
import UIKit
import CoreData

class JobViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var jobName: UITextField!
    
    @IBOutlet weak var errorLable: UILabel!

    @IBOutlet weak var jobTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    var availableJob:[Job]?
    
    
    func fetchJobs(){
        
        // Fatcj Jobs from data base to table view
        do {
            self.availableJob =  try context.fetch(Job.fetchRequest())
            
            DispatchQueue.main.async {
                self.jobTableView.reloadData()
            }
        }
        catch {}
    }
    
    func seedDataBase(){
        
        let attilaJob = Job(context: self.context)
        attilaJob.name = "Attilas Job"
        
        let aTask1 = Task(context: self.context)
        aTask1.name = "Drywall Install"
        aTask1.taskDescription = "Install the drywall"
        aTask1.startDate = Date()
        aTask1.endDate = Date()
        aTask1.hours = 40
        aTask1.status = false
        aTask1.job = attilaJob
        
        
        let aTask2 = Task(context: self.context)
        aTask2.name = "Drywall Mud"
        aTask2.taskDescription = "Mud the drywall"
        aTask2.startDate = Date()
        aTask2.endDate = Date()
        aTask2.hours = 40
        aTask2.status = false
        aTask2.job = attilaJob
        
        let divsJob = Job(context: self.context)
        divsJob.name = "Divs Job"
        
        let dTask1 = Task(context: self.context)
        dTask1.name = "Drywall Install"
        dTask1.taskDescription = "Install the drywall"
        dTask1.startDate = Date()
        dTask1.endDate = Date()
        dTask1.hours = 40
        dTask1.status = false
        dTask1.job = divsJob
        
        
        let dTask2 = Task(context: self.context)
        dTask2.name = "Drywall Mud"
        dTask2.taskDescription = "Mud the drywall"
        dTask2.startDate = Date()
        dTask2.endDate = Date()
        dTask2.hours = 40
        dTask2.status = false
        dTask2.job = divsJob
        
        let habibsJob = Job(context: self.context)
        habibsJob.name = "Habibs Job"
        
        let hTask1 = Task(context: self.context)
        hTask1.name = "Drywall Install"
        hTask1.taskDescription = "Install the drywall"
        hTask1.startDate = Date()
        hTask1.endDate = Date()
        hTask1.hours = 40
        hTask1.status = false
        hTask1.job = habibsJob
        
        
        let hTask2 = Task(context: self.context)
        hTask2.name = "Drywall Mud"
        hTask2.taskDescription = "Mud the drywall"
        hTask2.startDate = Date()
        hTask2.endDate = Date()
        hTask2.hours = 40
        hTask2.status = false
        hTask2.job = habibsJob
        
        
        do {
            try self.context.save()
        }
        catch {}
        
        fetchJobs()         //fetching data from database
    }
    
    
    //Function Name: viewDidLoad
    //Description: This method is called after the view controller has loaded its view hierarchy into memory.
    //Parameters : None
    //Returns : Nothing
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobTableView.delegate = self
        jobTableView.dataSource = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        jobName.becomeFirstResponder()
        jobName.delegate = self
        
        fetchJobs()             // get jobs from database
        if self.availableJob?.count == 0 {
            seedDataBase()
        }
    }
    
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ jobName: UITextField) -> Bool {
        jobName.resignFirstResponder()
        return true
    }

    //Function Name: onClickCreateJobButton
    //Description: This method is called when user is trying to created new Job in app
    //Parameters : sender: Any
    //Returns : Nothing
    @IBAction func onClickCreateJobButton(_ sender: Any) {
        // checking that text box is not empty
        if jobName.text == "" {
            errorLable.isHidden = false
        }
        else {
            
            let newJob = Job(context: self.context)
            newJob.name = jobName.text!
            newJob.jobDescription = "Temp Job"
            newJob.status = false           // job has not been assigned
            
            do {
                try self.context.save()
            }
            catch {
                // catch the error
                // job saving error
            }
            
            
            fetchJobs()         // updating the table view
        
            jobName.text = ""       // clearing the textview
            errorLable.isHidden = true
        }
    }
    
    //Prepare method for table view data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.jobTableView.indexPathForSelectedRow {
            let controller = segue.destination as! TaskViewController
            controller.jobId = availableJob?[indexPath.row].name ?? "Empty"
        }
    }
}

//UI table view delegate
extension JobViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jobName = self.availableJob![indexPath.row].name
        print(jobName ?? "Empty")
    }
}

// Method to count total jobs and show them in the table view
extension JobViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.availableJob?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)
        
        let job = self.availableJob![indexPath.row]
        cell.textLabel?.text = job.name
        return cell
    }
}
