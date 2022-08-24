//
//  MyProgressPresenter.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import Foundation

protocol MyProgressPresenterDelegate: NSObjectProtocol {
    func showRoutes(routes:[RouteModel?]?)
}

class MyProgressPresenter {
    private let routesService:RoutesService
    weak private var myProgressPresenterDelegate : MyProgressPresenterDelegate?
    
    init(routesService:RoutesService){
        self.routesService = routesService
    }
    
    func setViewDelegate(myProgressPresenterDelegate:MyProgressPresenterDelegate?){
        self.myProgressPresenterDelegate = myProgressPresenterDelegate
    }
    
    func getRoutes(){
        routesService.getRoutes(callBack: { [weak self] routes in
            self?.myProgressPresenterDelegate?.showRoutes(routes: routes)
        })
    }

}
