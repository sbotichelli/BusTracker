//
//  ViewController.swift
//  BusTracker
//
//  Created by botichelli on 6/11/20.
//  Copyright © 2020 Oleksandra Sildushkina. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var viewModel = MapViewModel()
    private var mapView: MKMapView!
    
    override func loadView() {
        super.loadView()
        mapView = MKMapView()
        mapView.frame = self.view.bounds
        self.view.addSubview(mapView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
    }

    func configureMapView() {
        mapView.setRegion(viewModel.mapRegion, animated: true)
    }
    
}

