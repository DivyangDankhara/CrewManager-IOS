//
//  Job+CoreDataProperties.swift
//  CrewManager
//
//  Created by JARVIS on 2020-12-12.
//  Copyright © 2020 Conestoga College. All rights reserved.
//
//

import Foundation
import CoreData


extension Job {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job")
    }

    @NSManaged public var status: Bool
    @NSManaged public var name: String?
    @NSManaged public var jobDescription: String?
    @NSManaged public var id: Int64
    @NSManaged public var crew: Crew?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension Job {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
