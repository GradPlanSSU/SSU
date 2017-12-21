//
//  Class+CoreDataProperties.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/10/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//
//

import Foundation
import CoreData


extension Class {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Class> {
        return NSFetchRequest<Class>(entityName: "Class")
    }

    @NSManaged public var catalog: String?
    @NSManaged public var class_Description: String?
    @NSManaged public var class_Name: String?
    @NSManaged public var class_Units: String?
    @NSManaged public var ge_designation: String?
    @NSManaged public var subject: String?
    @NSManaged public var has_prerequisites: Bool
    @NSManaged public var term: Term?

}
