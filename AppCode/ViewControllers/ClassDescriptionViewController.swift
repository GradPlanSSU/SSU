//
//  ClassDescriptionViewController.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/1/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit
import CoreData

class ClassDescriptionViewController: UIViewController {

    //@IBOutlet weak var saveClass: UIBarButtonItem!
    let lightGray = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
    
    var className = Course()
    var has_prerequisite = Bool()
    var prerequisites = [String]()
    var clickedCell = IndexPath()
    var terms = [Term]()
    var termIndex = Int()
    
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseUnitsLabel: UILabel!
    @IBOutlet weak var courseGELabel: UILabel!
    @IBOutlet weak var coursePrerequisiteLabel: UILabel!
    @IBOutlet weak var courseDescriptionLabel: UILabel!
    
    
    // saves the class in the designated term. if prereq is not met, gives the user an alert for
    // confirmation
    @IBAction func didClickSave(_ sender: Any) {
        if has_prerequisite == true {
            
                let alertController = UIAlertController(title: "Missing Prerequisite", message: "You may have not met the prerequisites for this class. Add anyways?", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                    if let navController = self.navigationController {
                        let viewControllers: [UIViewController] = navController.viewControllers as [UIViewController]
                        let prevController: AddTermViewController = viewControllers[viewControllers.count - 4] as! AddTermViewController
                        self.saveClass()
                        prevController.terms = self.terms
                        prevController.termIndex = self.termIndex
                        navController.popToViewController(prevController, animated: true)
                    }
                }
            
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
                alertController.addAction(confirmAction)
                alertController.addAction(cancelAction)
            
                self.present(alertController, animated: true, completion: nil)
        }
        else {
            if let navController = self.navigationController {
            let viewControllers: [UIViewController] = navController.viewControllers as [UIViewController]
            let prevController: AddTermViewController = viewControllers[viewControllers.count - 4] as! AddTermViewController
            self.saveClass()
            prevController.terms = self.terms
            prevController.termIndex = self.termIndex
            navController.popToViewController(prevController, animated: true)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        print("Subject to be printed: \(self.className.subject)")
       self.courseNameLabel.text = self.className.subject + " " + self.className.catalog + " " + self.className.course_title
       self.courseUnitsLabel.text = self.className.units
        if self.className.ge_designation?.count == 0 {
            self.courseGELabel.text = "No GE Attribute"
        } else {
             self.courseGELabel.text = self.className.ge_designation
        }
        self.courseDescriptionLabel.text = "N/A"
        
        var prereqString = String()
        
        print(prerequisites)
        
        if prerequisites.count > 0 {
            for i in 0...prerequisites.count - 1 {
                prereqString = prereqString + " " + prerequisites[i] + " "
            }
        }

        self.coursePrerequisiteLabel.text = prereqString
        print("Prerequisite String: \(prereqString)")
        print(self.className.catalog)
    
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.courseNameLabel.text = self.className.subject + " " + self.className.catalog + " " + self.className.course_title
        self.courseUnitsLabel.text = self.className.units
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        has_prerequisite = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coursePrerequisiteLabel.text = ""
        prerequisites.removeAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveClassSegue" else { return }
        let destinationVC : AddTermViewController = segue.destination as! AddTermViewController
        destinationVC.terms = self.terms
        destinationVC.termIndex = self.termIndex
    }

    func saveClass() {
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let chosenClass = Class(context: context)
            chosenClass.class_Name = courseNameLabel.text
            chosenClass.class_Units = courseUnitsLabel.text
            chosenClass.catalog = self.className.catalog
            chosenClass.subject = self.className.subject
            terms[termIndex].addToClasses(chosenClass)
        
        print("terms count: \(terms.count)")
    
    }

}
