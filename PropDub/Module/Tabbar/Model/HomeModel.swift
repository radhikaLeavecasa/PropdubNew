//
//  HomeModel.swift
//  PropDub
//
//  Created by acme on 22/05/24.
//

import UIKit
import ObjectMapper

struct HomeModel: Mappable {
    var status: Int?
    var data: [DataItemModel]?
    var dataDeveloper: [DeveloperModel]?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
        dataDeveloper <- map["data"]
    }
}

struct DataItemModel: Mappable {
    var agent: AgentModel?
    var amenities: String?
    var appDescription: String?
    var approved: Int?
    var area: String?
    var brochure: String?
    var cat: String?
    var createdAt: String?
    var createdBy: Int?
    var description: String?
    var developer: DeveloperModel?
    var floorPlan: String?
    var gallery: String?
    var handover: String?
    var id: Int?
    var image: String?
    var latitude: String?
    var location: String?
    var logitude: String?
    var logo: String?
    var maps: String?
    var masterPlan: String?
    var name: String?
    var nearByLocation: String?
    var qrCode: String?
    var startingPrice: String?
    var status: String?
    var subCat: String?
    var type: String?
    var unit: String?
    var unitPlan: String?
    var updatedAt: String?
    var viedo: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        agent <- map["agent"]
        amenities <- map["amenities"]
        appDescription <- map["app_description"]
        approved <- map["approved"]
        area <- map["area"]
        brochure <- map["brochure"]
        cat <- map["cat"]
        createdAt <- map["created_at"]
        createdBy <- map["created_by"]
        description <- map["description"]
        developer <- map["developer"]
        floorPlan <- map["floor_plan"]
        gallery <- map["gallery"]
        handover <- map["handover"]
        id <- map["id"]
        image <- map["image"]
        latitude <- map["latitude"]
        location <- map["location"]
        logitude <- map["logitude"]
        logo <- map["logo"]
        maps <- map["map"]
        masterPlan <- map["master_plan"]
        name <- map["name"]
        nearByLocation <- map["near_by_location"]
        qrCode <- map["qr_code"]
        startingPrice <- map["starting_price"]
        status <- map["status"]
        subCat <- map["sub_cat"]
        type <- map["type"]
        unit <- map["unit"]
        unitPlan <- map["unit_plan"]
        updatedAt <- map["updated_at"]
        viedo <- map["viedo"]
    }
}

struct AgentModel: Mappable {
    var agentBrn: String?
    var brokerBrn: String?
    var card: String?
    var createdAt: String?
    var createdBy: String?
    var description: String?
    var designation: String?
    var dldPermitNumber: String?
    var email: String?
    var heading: String?
    var id: Int?
    var images: String?
    var language: String?
    var linkedin: String?
    var listed: String?
    var name: String?
    var phone: String?
    var pointers: String?
    var qrCode: String?
    var reference: String?
    var subHeading: String?
    var updatedAt: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        agentBrn <- map["agent_brn"]
        brokerBrn <- map["broker_brn"]
        card <- map["card"]
        createdAt <- map["created_at"]
        createdBy <- map["created_by"]
        description <- map["description"]
        designation <- map["designation"]
        dldPermitNumber <- map["dld_permit_number"]
        email <- map["email"]
        heading <- map["heading"]
        id <- map["id"]
        images <- map["images"]
        language <- map["language"]
        linkedin <- map["linkedin"]
        listed <- map["listed"]
        name <- map["name"]
        phone <- map["phone"]
        pointers <- map["pointers"]
        qrCode <- map["qr_code"]
        reference <- map["reference"]
        subHeading <- map["sub_heading"]
        updatedAt <- map["updated_at"]
    }
}

struct DeveloperModel: Mappable {
    var buildings: String?
    var content: String?
    var createdAt: String?
    var emp: String?
    var estb: String?
    var exp: String?
    var fHeading: String?
    var fImg: String?
    var fSubHeading: String?
    var heading: String?
    var hq: String?
    var id: Int?
    var images: String?
    var latitude: String?
    var location: String?
    var logitude: String?
    var logo: String?
    var maps: String?
    var pointers: String?
    var subHeading: String?
    var updatedAt: String?
    var vHeading: String?
    var vSubHeading: String?
    var video: String?
    var name: String?
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        buildings <- map["buildings"]
        content <- map["content"]
        createdAt <- map["created_at"]
        emp <- map["emp"]
        estb <- map["estb"]
        exp <- map["exp"]
        fHeading <- map["f_heading"]
        fImg <- map["f_img"]
        fSubHeading <- map["f_sub_heading"]
        heading <- map["heading"]
        hq <- map["hq"]
        id <- map["id"]
        images <- map["images"]
        latitude <- map["latitude"]
        location <- map["location"]
        logitude <- map["logitude"]
        logo <- map["logo"]
        maps <- map["map"]
        pointers <- map["pointers"]
        subHeading <- map["sub_heading"]
        updatedAt <- map["updated_at"]
        vHeading <- map["v_heading"]
        vSubHeading <- map["v_sub_heading"]
        video <- map["video"]
        name <- map["name"]
    }
}

extension DataItemModel: Hashable {
    static func == (lhs: DataItemModel, rhs: DataItemModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
