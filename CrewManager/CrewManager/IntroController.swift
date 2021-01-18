//
//  File Name: IntroController.swift
//  Project : Assignment 2 MAD
//  Programmer: Habib Shakibanejad
//  First Version : 2020-09-28
//  Description : This file contains code to tasks screeen
//  Copyright © 2020 Conestoga College. All rights reserved.
//

import UIKit

class IntroController: UIViewController {

   
    @IBOutlet weak var motto: UILabel!
    @IBOutlet weak var localToggle: UISwitch!
    
    //Function Name: viewDidLoad
    //Description: This method is called after the view controller has loaded its view hierarchy into memory.
    //Parameters : None
    //Returns : Nothing
    override func viewDidLoad() {
        super.viewDidLoad()

        motto.text = NSLocalizedString("motto_en", comment: "Translation")
        // Do any additional setup after loading the view.
    }
    
    //Function Name: switchHandle
    //Description: This method is called when user chnages the language with toggle control
    //Parameters : UISwitch
    //Returns : Nothing
    @IBAction func switchHandle(_ sender: UISwitch) {
        if(sender.isOn){
            motto.text = NSLocalizedString("motto_rus", comment: "Translation")
        }else{
            motto.text = NSLocalizedString("motto_en", comment: "Translation")
        }
    }
    
}

