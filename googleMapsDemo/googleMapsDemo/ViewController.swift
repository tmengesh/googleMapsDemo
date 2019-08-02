//
//  ViewController.swift
//  googleMapsDemo
//
//  Created by Tewodros Mengesha on 02/08/2019.
//  Copyright © 2019 swift by Teddy. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject {
    
    let name: String
    let snippt: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, snippt: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.snippt = snippt
        self.location = location
        self.zoom = zoom
    }
}

class ViewController: UIViewController {
    
    var mapView: GMSMapView?
    var currentDestination: VacationDestination?
    let destinations = [VacationDestination(name: "Tietomaa Science Center", snippt: "Nahkatehtaankatu 6", location: CLLocationCoordinate2DMake(65.018512, 25.485325), zoom: 14), VacationDestination(name: "The Oulu Museum Of Art",snippt: "Kasarmintie 9" ,location: CLLocationCoordinate2DMake(65.023194, 25.481541), zoom: 18), VacationDestination(name: "Oulu Market Hall",snippt: "Oulun kauppahalli" ,location: CLLocationCoordinate2DMake(65.013176, 25.464389), zoom: 15), VacationDestination(name: "Nallikari Majakka",snippt: "Eden Spa" ,location: CLLocationCoordinate2DMake(65.032725, 25.406009), zoom: 15), VacationDestination(name: "Koitelinkoski",snippt:"Fishing spot" ,location: CLLocationCoordinate2DMake(65.098294, 25.814280), zoom: 13)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyA0QlNOrMY6JU7wqgBXBamQq1v9wbR11Z0")
        let camera = GMSCameraPosition.camera(withLatitude: 64.930998, longitude: 25.355859, zoom: 12)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        //lets put a marker on the map
        let currentLocation = CLLocationCoordinate2DMake(64.930998, 25.355924)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Oulu Airport"
        marker.snippet = "Oulun lentoasema"
        marker.map = mapView
        
        //Next button
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: "next")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: "next")

    }
    
    @objc func next() {
        
        if currentDestination == nil {
            currentDestination = destinations.first
        } else {
            if let index = destinations.index(of:currentDestination!), index < destinations.count - 1 {
                currentDestination = destinations[index + 1]
            }
        }
        
        setMapCamera()
    }
    
    private func setMapCamera() {
        CATransaction.begin()
        //Transition time to change location
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
        marker.snippet = currentDestination?.snippt
    }
    
}

