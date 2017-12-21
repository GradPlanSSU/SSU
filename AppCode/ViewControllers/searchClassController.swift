//
//  searchClassController.swift
//  SSUSchedulePlanner
//
//  Created by student on 11/25/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit

class searchClassController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

 let UniversityDarkBlue = UIColor(red: 20/255, green: 59/255, blue: 135/255, alpha: 1.0)
    
    @IBOutlet weak var subjectText: UITextField!
    @IBOutlet weak var courseNumberText: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var generalEducationAttributeText: UITextField!
    
    var terms = [Term]()
    var termIndex = Int()
    var prevClasses = [Class]()
    var subject = [String]()
    
    var courseNumber = ["None", "Less Than", "Exactly", "Greater Than"]
    var courseAttribute = ["None", "(A1) Written and Oral Analysis", "(A2) Fundamentals of Comm",
                           "(A3) Critical Thinking", "(B1) Physical Sciences",
                           "(B2) Biological Sciences", "(B3) Specific Emphasis",
                           "(B4) Mathematical Concepts", "(C1) Arts, Thrt, Dnc, Mus, Flm",
                           "(C2) Lit, Philosophies, Values", "(C3) Comp Persp/Foreign Language",
                           "(D1) Individual and Society", "(D2) World History & Civ",
                           "(D3) United States History", "(D4) U.S. Const & CA Gov't",
                           "(D5) ContempInterntl Persp", "(E) Integrated Person",
                           "(GE) Ethnic Studies", "(GE) Lab Course"]
    
    var picker = 0
    
    override func viewDidLoad() {
        searchButton.backgroundColor = UniversityDarkBlue
        searchButton.setTitleColor(UIColor.white, for: .normal)
        searchButton.layer.cornerRadius = 7
        searchButton.alpha = 0.70
        subjectText.alpha = 0.70
        courseNumberText.alpha = 0.70
        number.alpha = 0.70
        generalEducationAttributeText.alpha = 0.70
        
        var set: Set = Set<String>()
        for c in CourseList.courses!.courses {
            set.insert(c.subject)
        }
        
        subject = set.sorted()
        subject.insert("None", at: 0)
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if picker == 0 {
            return subject.count
        }
        if picker == 1 {
            return courseNumber.count
        }
        if picker == 2 {
            return courseAttribute.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if picker == 0 {
            subjectText.text = subject[row]
        }
        if picker == 1 {
            courseNumberText.text = courseNumber[row]
        }
        if picker == 2 {
            generalEducationAttributeText.text = courseAttribute[row]
        }
    
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 200)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        
      

        if (textField == self.subjectText){
            picker = 0
            let editRadiusAlert = UIAlertController(title: "Select Subject", message: "", preferredStyle: UIAlertControllerStyle.alert)
            editRadiusAlert.setValue(vc, forKey: "contentViewController")
             editRadiusAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {(alert: UIAlertAction!) in self.changeSubject()}))
            
            self.present(editRadiusAlert, animated: true)
            
        }
        
        if (textField == self.courseNumberText){
            
            picker = 1
            let editRadiusAlert = UIAlertController(title: "Select Course Number Attribute", message: "", preferredStyle: UIAlertControllerStyle.alert)
            editRadiusAlert.setValue(vc, forKey: "contentViewController")
            editRadiusAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {(alert: UIAlertAction!) in self.changeCourse()}))
            
            self.present(editRadiusAlert, animated: true)
            
        }
        
        if (textField == self.generalEducationAttributeText) {
        
            print("Selected GenEd Thing")
            picker = 2
            let editRadiusAlert = UIAlertController(title: "Select Course Attribute", message: "", preferredStyle: UIAlertControllerStyle.alert)
            editRadiusAlert.setValue(vc, forKey: "contentViewController")
            editRadiusAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {(alert: UIAlertAction!) in self.changeCourseAttribute()}))
            
            self.present(editRadiusAlert, animated: true)
        }
        
    }
    
    func changeSubject() {
        print("change Subject Called")
    }
    
    func changeCourse() {
        print("change Course Called")
    }
    
    func changeCourseAttribute() {
        print("change Course Attribute Called")
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var titleData = subject[row]
        
        if picker == 1 {
            titleData = courseNumber[row]
        }
        
        if picker == 2 {
            titleData = courseAttribute[row]
        }
      
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedStringKey.foregroundColor:UIColor.black])
 
        
       return myTitle
    }

    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SearchClassSegue" else { return }
        let destinationVC : AddClassViewController = segue.destination as! AddClassViewController
        
        var newcourses = CourseList.courses!.courses.filter {$0.subject == subjectText.text}
        if courseNumberText.text == "Less Than" {
            newcourses = newcourses.filter {$0.catalog < number.text!}
        } else if courseNumberText.text == "Exactly" {
            newcourses = newcourses.filter {$0.catalog == number.text!}
        } else if courseNumberText.text == "Greater Than" {
            newcourses = newcourses.filter {$0.catalog > number.text!}
        }
        prevClasses.removeAll(keepingCapacity: false)
        
        newcourses = newcourses.sorted { $0.catalog < $1.catalog }
        destinationVC.allCourses = newcourses
        
        for term in terms {
            if terms.index(of: term)! < termIndex {
                let prevCourseTmp = Array(term.classes!) as! [Class]
                for course in prevCourseTmp {
                    print(course.catalog)
                    prevClasses.append(course)
                }
            }
        }
        
        var classesTakenAsStrings: [String] = [String]()
        for classTaken in prevClasses {
            print(classTaken.catalog)
            classesTakenAsStrings.append(classTaken.subject! + " " + classTaken.catalog!)
        }
        
        let netHandler = NetRequestHandler(withURLString: "http://blue.cs.sonoma.edu:8000/courses/prerequisite").useParams().useToken()
        if let prereqs: Prerequisites? = netHandler.download_request() {
            destinationVC.enrollmentPreReqs = (prereqs?.courses)!
            for (i, _) in newcourses.enumerated().reversed() {
                let inspect = prereqs?.courses.index(where: {$0.course == newcourses[i].subject + " " + newcourses[i].catalog})
                if inspect != nil {
                    let testvar = prereqs?.courses[inspect!].prerequisites.flatMap{$0}
                    let preReqSet = Set(testvar!)
                    if !preReqSet.isSubset(of: Set(classesTakenAsStrings)) {
                        newcourses.remove(at: i)
                    }
                }
            }
        }
        
        destinationVC.filteredCourses = newcourses
        destinationVC.terms = self.terms
        destinationVC.termIndex = self.termIndex
        return
    }

}
