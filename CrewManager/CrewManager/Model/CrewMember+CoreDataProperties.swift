//
//  CrewMember+CoreDataProperties.swift
//  CrewManager
//
//  Created by JARVIS on 2020-12-12.
//  Copyright © 2020 Conestoga College. All rights reserved.
//
//

import Foundation
import CoreData


extension CrewMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrewMember> {
        return NSFetchRequest<CrewMember>(entityName: "CrewMember")
    }

    @NSManaged public var assigned: Bool
    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var crew: Crew?
    @NSManaged public var task: Task?

}
