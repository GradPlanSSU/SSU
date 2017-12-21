//
//  Term+CoreDataProperties.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/4/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//
//

import Foundation
import CoreData


extension Term {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Term> {
        return NSFetchRequest<Term>(entityName: "Term")
    }

    @NSManaged public var termName: String?
    @NSManaged public var termUnits: String?
    @NSManaged public var classes: NSSet?
    @NSManaged public var schedule: Schedule?

}

// MARK: Generated accessors for classes
extension Term {

    @objc(addClassesObject:)
    @NSManaged public func addToClasses(_ value: Class)

    @objc(removeClassesObject:)
    @NSManaged public func removeFromClasses(_ value: Class)

    @objc(addClasses:)
    @NSManaged public func addToClasses(_ values: NSSet)

    @objc(removeClasses:)
    @NSManaged public func removeFromClasses(_ values: NSSet)

}
