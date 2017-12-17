//
//  MapKit.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

import MapKit

public extension MKMapView {
    public func clear() {
        removeAnnotations(annotations)
    }
}
