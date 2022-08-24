//
//  RoutesService.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import Foundation

class RoutesService {
    
    func setRoute(routes: ([RouteModel?]?), callBack:(Bool?) -> Void) {
        let listRout = ListRoute(listRout: routes ?? [RouteModel]())
        UserDefaults.standard.set(try? PropertyListEncoder().encode(listRout), forKey:"listRout")
        callBack(true)
    }
    
    func getRoutes(callBack:([RouteModel?]?) -> Void) {
        var arrayRout : [RouteModel?] = [RouteModel]()
        if let data = UserDefaults.standard.value(forKey:"listRout") as? Data {
            let listRoute = try? PropertyListDecoder().decode(ListRoute.self, from: data)
            for newRoute in listRoute?.listRout ?? [] {
                arrayRout.append(newRoute)
            }
        }

        callBack(arrayRout)
    }
}
