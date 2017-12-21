//
//  Schedule+CoreDataProperties.swift
//  SSUSchedulePlanner
//
//  Created by student on 11/28/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//
//

import Foundation
import CoreData


extension Schedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule")
    }

    @NSManaged public var scheduleDate: String?
    @NSManaged public var scheduleName: String?

    @NSManaged public var terms: NSSet?

}

// MARK: Generated accessors for terms
extension Schedule {

    @objc(addTermsObject:)
    @NSManaged public func addToTerms(_ value: Term)

    @objc(removeTermsObject:)
    @NSManaged public func removeFromTerms(_ value: Term)

    @objc(addTerms:)
    @NSManaged public func addToTerms(_ values: NSSet)

    @objc(removeTerms:)
    @NSManaged public func removeFromTerms(_ values: NSSet)

}
