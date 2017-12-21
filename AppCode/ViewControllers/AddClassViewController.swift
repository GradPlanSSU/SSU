//
//  AddClassViewController.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/1/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit

class AddClassViewController: UITableViewController {

    let UniversityDarkBlue = UIColor(red: 20/255, green: 59/255, blue: 135/255, alpha: 1.0)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var classes = [Class]()
    var filteredCourses = [Course]()
    var allCourses = [Course]()
    var prereqs = [String]()
    
    var selectedCourse = Course()
    var has_prereq = Bool()
    
    var enrollmentPreReqs: [EnrollmentRequirements] = [EnrollmentRequirements]()
    var terms = [Term]()
    var termIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.has_prereq = false
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // filters through all courses creating an array of all classes that fit
        // the given parameters that the student can take
        filteredCourses = filteredCourses.sorted { $0.catalog < $1.catalog }
        
        if self.allCourses.count > 0 {
            for i in 0...self.allCourses.count - 1 {
                let course = Class(context:context)
                course.class_Name = allCourses[i].course_title
                course.catalog = allCourses[i].catalog
                course.subject = allCourses[i].subject
                course.class_Units = allCourses[i].units
                classes.append(course)
            }
        }
     
        self.tableView.reloadData()
    
    }

    override func viewDidAppear(_ animated: Bool) {
        has_prereq = false
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // -BELOW- Override tableview functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return classes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsViewCell", for: indexPath as IndexPath)
        
        if classes.count > 0 {
            
            if let theCell = cell as? SearchResultsTableViewCell {
                
                theCell.courseName.text = classes[indexPath.row].subject! + " " + classes[indexPath.row].catalog! + " " + classes[indexPath.row].class_Name!
                
                theCell.courseUnits.text = classes[indexPath.row].class_Units
                
                theCell.courseName.textColor = UIColor.white
                theCell.courseUnits.textColor = UIColor.white
                
            }
        }
        
        cell.backgroundColor = UniversityDarkBlue
        return(cell)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "courseToDescriptionSegue" else { return }
        
        if let indexPath = tableView.indexPathForSelectedRow {
            print("Inside didSelectRowAt")
            
            selectedCourse = allCourses[indexPath.row]
            selectedCourse.course_title = allCourses[indexPath.row].course_title
            selectedCourse.catalog = allCourses[indexPath.row].catalog
            selectedCourse.units = allCourses[indexPath.row].units
            
            var tempReqs = enrollmentPreReqs.filter { $0.course == allCourses[indexPath.row].subject + " " + allCourses[indexPath.row].catalog}
            
            // stores and passes an array of strings that represent prerequisites into the next view controller
            if tempReqs.count > 0 {
                if tempReqs[0].prerequisites.count > 0 && tempReqs[0].prerequisites[0] != nil{
                    print("Adding prerequisites")
                    prereqs = tempReqs[0].prerequisites as! [String]
                    print(tempReqs[0].prerequisites)
                }
            }
            
            if !filteredCourses.contains(allCourses[indexPath.row]) {
                self.has_prereq = true
            }
            
            print("Ending didSelectRowAt")
        }

        let destinationVC : ClassDescriptionViewController = segue.destination as! ClassDescriptionViewController

            destinationVC.prerequisites = self.prereqs
            print("Preparing for Segue")
            print(self.prereqs)
            destinationVC.has_prerequisite = self.has_prereq
            destinationVC.title = self.selectedCourse.subject + " " + self.selectedCourse.catalog
            destinationVC.className = self.selectedCourse
            destinationVC.terms = self.terms
            destinationVC.termIndex = self.termIndex
            prereqs.removeAll()

        
   }
    

}
