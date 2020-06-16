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
        mapView.delegate = self
        self.view.addSubview(mapView)
        configureViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
    }

    func configureMapView() {
        mapView.setRegion(viewModel.mapRegion, animated: true)
    }
    
    func configureViewModel() {
        viewModel.onUpdateCompletion = {
            [weak self] updates, annotations, toRemove in
            guard let mapView = self?.mapView else { return }
            DispatchQueue.main.async {
                self?.updateAnnotations(updates: updates)
                mapView.addAnnotations(annotations)
                self?.removeAnnotations(ids: toRemove)
            }
        }
    }
    
    func demoMap() {
        let vehicle = VehiclePosition(id: 1, type: "bus", direction: 100, line: "1", lat: 52.22977, lon: 21.01178)
        let annotation = VehicleAnnotation(from: vehicle)
        mapView.addAnnotation(annotation)
        UIView.animate(withDuration: 10.0, animations: {
            annotation.coordinate = CLLocationCoordinate2D(latitude: 52.220, longitude: 21.010)
        })
    }
    
    func updateAnnotations(updates: [VehicleUpdate]) {
        let annotations = mapView.annotations.map{ $0 as! VehicleAnnotation}
        UIView.animate(withDuration: 3.0, animations: {
            for update in updates {
                let annotation = annotations.filter{ $0.id == update.id }.first
                if let annotation = annotation {
                    annotation.coordinate = update.coordinate()
                    annotation.direction = update.direction
                }
            }
        })
    }
    
    func removeAnnotations(ids: [Int]) {
        guard let mapView = mapView else {
            return
        }
        let annotations = mapView.annotations.map{ $0 as! VehicleAnnotation}
        let toRemoveAnnotations = annotations.filter{ ids.contains($0.id) }
        mapView.removeAnnotations(toRemoveAnnotations)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        viewModel.mapRegion = mapView.region
    }
}
