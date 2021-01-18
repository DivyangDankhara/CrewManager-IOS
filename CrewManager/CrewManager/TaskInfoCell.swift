//
//  File Name: TaskInfoCell.swift
//  Project : Assignment 1 MAD
//  Programmer: Attila Katona
//  First Version : 2020-09-28
//  Description: This class manipulates the cell added to the table
//  Copyright © 2020 Conestoga College. All rights reserved.
//

import UIKit

class TaskInfoCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //Function Name: setTaskInfo
    //Description: This sets the string passed in as the text displayed on the label in the table
    //Parameters : name : String - Name user would like to be changed to
    //Returns : Nothing
    func setTaskInfo (_ name: String){
        self.labelName.text = name
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
