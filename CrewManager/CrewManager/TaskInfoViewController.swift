//
//  File Name: TaskInfoViewController.swift
//  Project : Assignment 1 MAD
//  Programmer: Attila Katona
//  First Version : 2020-09-28
//  Description : This file manipulates the view on the task info page. Edits the Table and cell that have been added to the view in the storyboard and connected with outlets
//  Copyright © 2020 Conestoga College. All rights reserved.
//
import UIKit
import CoreData

class TaskInfoViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var taskInfoTbl: UITableView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    // local variables
    var selectedTask:Task?
    var jobName = ""
    var taskName = ""
    var taskData = [Dictionary<String, Any>]()
    
    //context
    let context = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    func fetchJobsTask(){
        
        // Fatch Jobs from data base to table view
        do {
            let availabeJobs:[Job]? =  try self.context.fetch(Job.fetchRequest())
            var selectedJob:Job
            
            for job in availabeJobs! {
                if job.name == jobName {
                    selectedJob = job
                    let taskArray:[Task]? = selectedJob.tasks?.allObjects as? [Task]
                    
                     for task in taskArray! {
                        if task.name == taskName {
                            selectedTask  = task
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.taskInfoTbl.reloadData()
            }
        }
        catch { }
        
    }

    //Function Name: viewDidLoad
    //Description: This method is called after the view controller has loaded its view hierarchy into memory.
    //Parameters : None
    //Returns : Nothing
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Additional setup making sure the row height is set and set the delegate and datasource for the table
        taskInfoTbl.tableFooterView = UIView(frame: .zero)
        taskInfoTbl.register(UINib(nibName: "TaskInfoCell", bundle: nil), forCellReuseIdentifier: "TaskInfoCell")
        
        taskInfoTbl.estimatedRowHeight = 60
        //Call to set the data inton the data source
        fetchJobsTask()
        createDataSource()
        taskInfoTbl.delegate = self
        taskInfoTbl.dataSource = self
        
        taskInfoTbl.isUserInteractionEnabled = true;
        let interaction = UIContextMenuInteraction(delegate: self)
        taskInfoTbl.addInteraction(interaction);
        
        
        }
           
    }

extension TaskInfoViewController : UIContextMenuInteractionDelegate{
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(
            identifier:nil,
            previewProvider:nil) { suggestedActions in
            
            let share = UIAction(title:"Share",
                                 image:UIImage(systemName:"square.and.arrow.up")){
                action in
            }
                let save = UIAction(title:"Save",
                                     image:UIImage(systemName:"icloud.and.arrow.up.fill")){
                    action in
                }
                
            return UIMenu(title:"",children:[share,save])
        }
    }
}



//Name : TaskInfoViewController
//Purpose: Extending this class to also inherit UITabkeViewDataSource so program knows what functions to use when manipulating the table
extension TaskInfoViewController: UITableViewDataSource{
    
    //Function Name: numberOfSections
    //Description: Mandatory function to figure out the number of section in the table view
    //Parameters : tableView : UITableView - The table we are using
    //Returns : Number of sections in the datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return taskData.count
    }
    
    //Function Name: createDataSource
    //Description: This method will be used more next assignment. Will get data from somewhere and load a data structure to use for the datasource in the table
    //Parameters : None
    //Returns : Nothine
    func createDataSource(){
 
        let progress:Float? = Float.random(in: 1.00..<100.00)
        taskData.append(["title" : "Task Information", "value" : [
            "Task : \(selectedTask!.name ?? ("Empty"))" ,
            "Job Name: \(selectedTask!.job!.name ?? ("Empty"))",
            "Description : \(selectedTask!.taskDescription ?? ("empty"))",
            "Start Date : \(selectedTask?.startDate ?? Date())",
            "End Date : \(selectedTask?.endDate ?? Date())",
            "Hours : \(selectedTask!.hours)",
            "Status : \(selectedTask!.status)"]])
        
        progressView.progress = progress!
    }
    
    //Function Name: tableView
    //Description: Mandatory function to figure out the number of values to display under the header label
    //Parameters : numberOfRowsInSection section: Int _ Pulls the sections from the previous function
    //Returns : Number of tasks to display under label
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Stronger check than just if
        guard let task = taskData[section]["value"] as? [String] else {
            return 0
        }
        return task.count
    }
    
    //Function Name: tableView
    //Description: Mandatory function to figure out which row to print the data too and show the user. Sets the data to the cell
    //Parameters : tableView: UITableView, cellForRowAt indexPath: IndexPath - The table to print to and the row the print on
    //Returns : The actual Cell after it is formated
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskInfoCell") as! TaskInfoCell
        //Stronger to check than IF
        guard let task = taskData[indexPath.section]["value"] as? [String] else {
            return cell
        }
        cell.setTaskInfo(task[indexPath.row])
        return cell
    }
    
    //Function Name: tableView
    //Description: Mandatory function to maniuplate the header on each section. Basic stuff now, will add more things later to freshen up the app
    //Parameters : tableView: UITableView, viewForHeaderInSection section: Int - The table to edit and the header for the section in the table
    //Returns : The view after label is altered to look nicer and fit better.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: taskInfoTbl.frame.size.width, height: 50.0))
        let titleLabel = UILabel(frame: CGRect(x: 15.0, y: 0.0, width: view.frame.size.width, height: 50.0))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        if let title = taskData[section]["title"] as? String {
            titleLabel.text = title
        }
        view.addSubview(titleLabel)
        return view
    }
    
    //Function Name: tableView
    //Description: Mandatory function to maniuplate the header size on each scetion
    //Parameters : tableView: UITableView, heightForHeaderInSection section: Int - The table to edit and the height of the header for each section
    //Returns : 50dp right now
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}

//Name : TaskInfoViewController
//Purpose: Extending this class to also inherit UITableViewDelegate to autmatically delegate the dimensions of the tables row height
extension TaskInfoViewController: UITableViewDelegate{
    
    //Function Name: tableView
    //Description: Mandatory function to maniuplate the row height for the table
    //Parameters : tableView: UITableView, heightForRowAt indexPath: IndexPath - The table and the height of the row
    //Returns : Automatic dimension, defualt value for the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
}
