//
//  Crew+CoreDataProperties.swift
//  CrewManager
//
//  Created by JARVIS on 2020-12-12.
//  Copyright © 2020 Conestoga College. All rights reserved.
//
//

import Foundation
import CoreData


extension Crew {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crew> {
        return NSFetchRequest<Crew>(entityName: "Crew")
    }

    @NSManaged public var assigned: Bool
    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var job: Job?
    @NSManaged public var crewMember: CrewMember?

}
