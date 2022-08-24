//
//  CurrentRideViewController.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import UIKit
import GoogleMaps
import PTTimer
import CoreLocation

class CurrentRideViewController: UIViewController {
    private let currentRidePresenter = CurrentRidePresenter(routesService: RoutesService())
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var viewRide1: UIView!
    @IBOutlet var viewRide2: UIView!
    @IBOutlet var viewRide3: UIView!
    
    @IBOutlet var btnStart: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var btnStore: UIButton!
    @IBOutlet var btnDelete: UIButton!
    
    @IBOutlet var lblTimerView1: UILabel!
    @IBOutlet var lblTimerView2: UILabel!
    @IBOutlet var lblDistanceView2: UILabel!
    let timer = PTTimer.Up()
    
    var isRouteStarted = false
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var startDate: Date!
    var traveledDistance: Double = 0
    var address1 = ""
    var address2 = ""
    var hasAddress1 = false
    var hasAddress2 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewRide1.layer.cornerRadius = 10.0
        self.viewRide2.layer.cornerRadius = 10.0
        self.viewRide3.layer.cornerRadius = 10.0
        
        self.viewRide1.isHidden = true
        self.viewRide2.isHidden = true
        self.viewRide3.isHidden = true
        self.timer.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.distanceFilter = 1
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        if !hasLocationPermission() {
            let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func addRide(_ sender: Any) {
        self.viewRide1.isHidden = false
        self.viewRide2.isHidden = true
        self.viewRide3.isHidden = true
    }
    
    @IBAction func startRide(_ sender: Any) {
        //Start  timer
        hasAddress1 = false
        hasAddress2 = false
        isRouteStarted = true
        timer.start()
    }
    
    @IBAction func stopRide(_ sender: Any) {
        self.viewRide1.isHidden = true
        self.viewRide2.isHidden = !isRouteStarted ? true : false
        self.viewRide3.isHidden = true
        if isRouteStarted {
            self.lblTimerView2.text = self.lblTimerView1.text
            timer.pause()
        }else{
            timer.reset()
            clearInfo()
        }
    }
    
    @IBAction func storeRide(_ sender: Any) {
        self.viewRide1.isHidden = true
        self.viewRide2.isHidden = true
        self.viewRide3.isHidden = false
        
        let route1 = RouteModel(time: lblTimerView2.text ?? "", addressA: address1, addressB: address2, distance: "22 Km")
        
        self.currentRidePresenter.setViewDelegate(currentRidePresenterDelegate: self)
        self.currentRidePresenter.saveRoute(route: route1)
    }
    
    @IBAction func deleteRide(_ sender: Any) {
        self.viewRide1.isHidden = true
        self.viewRide2.isHidden = true
        self.viewRide3.isHidden = true
        timer.reset()
        clearInfo()
    }
    
    @IBAction func closeModal(_ sender: Any) {
        self.viewRide1.isHidden = true
        self.viewRide2.isHidden = true
        self.viewRide3.isHidden = true
        
        clearInfo()
    }
    
    func clearInfo(){
        hasAddress1 = false
        hasAddress2 = false
        isRouteStarted = false
        lblTimerView1.text = "00:00:00"
        lblTimerView2.text = "00:00:00"
        lblDistanceView2.text = "0 Km"
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
            }
        } else {
            hasPermission = false
        }
        
        return hasPermission
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D, labelShow: Int) {
        
      // 1
      let geocoder = GMSGeocoder()
        
      // 2
      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        guard let address = response?.firstResult(), let lines = address.lines else {
          return
        }
          
        // 3
          if labelShow == 1 {
              self.address1 = lines.joined(separator: "\n")
          }else {
              self.address2 = lines.joined(separator: "\n")
          }
          
        // 4
        UIView.animate(withDuration: 0.25) {
          self.view.layoutIfNeeded()
        }
      }
    }
}

extension CurrentRideViewController: CurrentRidePresenterDelegate {
    func showSaveInfoSuccess() {
        print("Info guardada")
        clearInfo()
    }
}

extension CurrentRideViewController: PTTimerDelegate {
    func timerTimeDidChange(seconds: Int) {
        let (h, m, s) = secondsToHoursMinutesSeconds(seconds)
        var hora = ""
        var minuto = ""
        var segundos = ""
        
        if h < 10 {
            hora = "0\(h)"
        }else{
            hora = "\(h)"
        }
        
        if m < 10 {
            minuto = "0\(m)"
        }else{
            minuto = "\(m)"
        }
        
        if s < 10 {
            segundos = "0\(s)"
        }else{
            segundos = "\(s)"
        }
        
        self.lblTimerView1.text = "\(hora):\(minuto):\(segundos)"
    }
    
    func timerDidPause() {
        // update label colors, buttons for a paused timer
    }
    
    func timerDidStart() {
        // update label colors, buttons for a started timer
    }
    
    func timerDidReset() {
        // update label colors, buttons now that the timer has been reset
    }
}

extension CurrentRideViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()
        
        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 7
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        if !hasAddress1 && timer.state == .running {
            hasAddress1 = true
            reverseGeocodeCoordinate(GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0).target, labelShow: 1)
        }else {
            if timer.state == .paused && !hasAddress2 {
                hasAddress2 = true
                reverseGeocodeCoordinate(GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0).target, labelShow: 2)
            }
        }
        
    }
}
