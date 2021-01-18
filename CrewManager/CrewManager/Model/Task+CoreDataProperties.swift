//
//  Task+CoreDataProperties.swift
//  CrewManager
//
//  Created by JARVIS on 2020-12-12.
//  Copyright © 2020 Conestoga College. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var hours: Int64
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var taskDescription: String?
    @NSManaged public var difficulty: String?
    @NSManaged public var status: Bool
    @NSManaged public var id: Int64
    @NSManaged public var job: Job?
    @NSManaged public var crewMember: CrewMember?

}
