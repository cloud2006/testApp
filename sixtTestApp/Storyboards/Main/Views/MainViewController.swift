//
//  ViewController.swift
//  sixtTestApp
//
//  Created by Pavel Antonyuk on 03.09.2020.
//  Copyright © 2020 Pavel Antonyuk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class MainViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Public properties
    
    lazy var viewModel: MainViewModeling = {
        let viewModel = MainViewModel()
        viewModel.output = self
        return viewModel
    }()
    
    // MARK: - Private properties
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    func addAnnotations() {
        viewModel.annotations.forEach {
            mapView.addAnnotation($0)
        }
    }
}

extension MainViewController: MainViewModelOutput {
    func registerCells() {
        tableView.registerCell(CarCell.self)
    }
    
    func reload() {
        addAnnotations()
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(with: CarCell.self, for: indexPath)
            .configure(with: viewModel.item(at: indexPath.row))
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mapView.centerToLocation(viewModel.carLocation(at: indexPath.row))
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) && CLLocationManager.isRangingAvailable() {
                guard let currentLocation = manager.location else { return }
                mapView.centerToLocation(currentLocation)
            }
        default: print("Location restricted")
        }
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        
        setRegion(coordinateRegion, animated: true)
    }
}
