//
//  LocationHandler.swift
//  Tripple
//
//  Created by Jonah Witcig on 10/18/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

import CoreLocation

public class LocationHandler: NSObject {
    static let shared = LocationHandler()
    
    lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    var location: CLLocation?
    
    var completionHandler: ((CLLocation?, NSError?)->Void)?
    
    func start(completionHandler handler: @escaping (CLLocation?, NSError?)->Void) {
        completionHandler = handler
        
        guard let location = location else {
            manager.requestWhenInUseAuthorization()
            if #available(iOS 9.0, *) {
                manager.requestLocation()
            }
            return
        }
        completionHandler?(location, nil)
    }
}

extension LocationHandler: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        
        completionHandler?(location, nil)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionHandler?(nil, error as NSError?)
    }
}
