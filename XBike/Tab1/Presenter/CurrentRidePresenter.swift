//
//  CurrentRidePresenter.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import Foundation

protocol CurrentRidePresenterDelegate: NSObjectProtocol {
    func showSaveInfoSuccess()
}

class CurrentRidePresenter {
    private let routesService:RoutesService
    weak private var currentRidePresenterDelegate : CurrentRidePresenterDelegate?
    
    init(routesService:RoutesService){
        self.routesService = routesService
    }
    
    func setViewDelegate(currentRidePresenterDelegate:CurrentRidePresenterDelegate?){
        self.currentRidePresenterDelegate = currentRidePresenterDelegate
    }
    
    func saveRoute(route:RouteModel){
        routesService.getRoutes(callBack: { routes in
            var arrayRout : [RouteModel?] = [RouteModel]()
            arrayRout = routes ?? [RouteModel]()
            arrayRout.append(route)
            
            let listRout = ListRoute(listRout: arrayRout)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(listRout), forKey:"listRout")
            
            self.currentRidePresenterDelegate?.showSaveInfoSuccess()
        })
    }

}
