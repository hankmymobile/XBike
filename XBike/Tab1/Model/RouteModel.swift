//
//  RouteModel.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import Foundation

struct ListRoute:Codable {
    let listRout: [RouteModel?]
}

struct RouteModel:Codable {
    let time: String
    let addressA: String
    let addressB: String
    let distance: String
}
