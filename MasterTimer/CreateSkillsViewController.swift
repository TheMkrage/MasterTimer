//
//  CreateSkillsViewController.swift
//  MasterTimer
//
//  Created by Matthew Krager on 9/7/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

import UIKit

class CreateSkillsViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var skillsNameTextField: UITextField!
    
    override func viewDidLoad() {
        self.skillsNameTextField.delegate = self
    }
    
    @IBAction func addSkill(sender: AnyObject) {
        var s: Skill = Skill(skillName: self.skillsNameTextField.text)
        (self.navigationController?.viewControllers[0] as! MainMenuViewController).skills.addObject(s)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
