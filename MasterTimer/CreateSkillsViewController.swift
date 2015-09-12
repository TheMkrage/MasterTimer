//
//  CreateSkillsViewController.swift
//  MasterTimer
//
//  Created by Matthew Krager on 9/7/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

import UIKit

class CreateSkillsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var skillsNameTextField: UITextField!
    
    override func viewDidLoad() {
        self.skillsNameTextField.delegate = self
    }
    
    @IBAction func addSkill(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let curSkills = defaults.valueForKey("Skills") as? NSArray {
            var newSkills: NSMutableArray = NSMutableArray(array: curSkills)
            var curDictionary = NSMutableDictionary()
            curDictionary.setValue(self.skillsNameTextField.text, forKey: "Name")
            curDictionary.setValue(0.0, forKey: "Time")
            // Add new team to bookmarks
            newSkills.addObject(curDictionary)
            defaults.setObject(newSkills as NSArray, forKey: "Skills")
            defaults.synchronize()
        }else {
            println("ERROR")
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
