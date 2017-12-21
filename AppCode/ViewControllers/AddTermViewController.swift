//
//  AddTermViewController.swift
//  SSUSchedulePlanner
//
//  Created by student on 11/28/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit
import CoreData

class AddTermViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // University Light Blue
    let UniversityDarkBlue = UIColor(red: 20/255, green: 59/255, blue: 135/255, alpha: 1.0)
    let lightGray = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
    
    @IBOutlet weak var addClassButton: UIButton!
    @IBOutlet weak var classTable: UITableView!
    
    var classes = [Class]()
    var terms = [Term]()
    var termIndex = Int()
    var clickedCell = IndexPath()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func savedTerm(_ sender: Any) {
        if let navController = self.navigationController {
            let viewControllers: [UIViewController] = navController.viewControllers as [UIViewController]
            let prevController: CreateScheduleViewController = viewControllers[viewControllers.count - 2] as! CreateScheduleViewController
            prevController.terms = self.terms
            
            var units : Float = 0.00
            
            if(classes.count > 0) {
                for i in 0...classes.count-1 {
                    units = units + (classes[i].class_Units! as NSString).floatValue
                }
            }
            prevController.numberOfUnits = units
            prevController.terms[termIndex].termUnits = String(units)
            
            navController.popToViewController(prevController, animated: true)
        }
    }
    
    
    
    @IBAction func clickedAddClass(_ sender: Any) {
        print("Clicked Add Class Button")
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        classTable.alpha = 0.90
        classTable.layer.cornerRadius = 5
        addClassButton.backgroundColor = UniversityDarkBlue
        addClassButton.setTitleColor(UIColor.white, for: .normal)
        addClassButton.layer.cornerRadius = 7
        
        classTable.backgroundColor = lightGray
        print("Loading AddTermViewController")
        print("Term Index: \(termIndex)")
        classes = Array(terms[termIndex].classes!) as! [Class]
        
        classTable.delegate = self
        classTable.dataSource = self
        classTable.reloadData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        classes = Array(terms[termIndex].classes!) as! [Class]
        classTable.reloadData()
    }
    

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("Attempting to Delete")
        
        // remove an object from the class array and update the tableView
        
        if editingStyle == .delete {
            // Delete the row from the data source
            print("Removing: \(classes[indexPath.row].class_Name)")
            classes.remove(at: indexPath.row)
            terms[termIndex].classes = NSSet(array: classes)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            print("Inserting")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard segue.identifier == "saveTermSegue" else {
            // AddClassSegue button clicked was Add Class
            let searchClassDestinationVC : searchClassController = segue.destination as! searchClassController
            searchClassDestinationVC.terms = self.terms
            searchClassDestinationVC.termIndex = self.termIndex
        
            return
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "classTableViewCell", for: indexPath)
        
        if let theCell = cell as? ClassInsideTermCell {
            
            print("Add Cell")
            
            theCell.className.text = classes[indexPath.row].class_Name
            theCell.classUnits.text = classes[indexPath.row].class_Units
            
            theCell.className.textColor = UIColor.white
            theCell.classUnits.textColor = UIColor.white
            
        }
        
        cell.backgroundColor = UniversityDarkBlue
        
        return(cell)
    }

}
