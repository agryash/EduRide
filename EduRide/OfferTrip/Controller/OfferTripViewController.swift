//
//  OfferTripViewController.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/2/24.
//

import UIKit
import MapKit

class OfferTripViewController: UIViewController {
    
    let offerTripScreen = OfferTripView()
    let locationManager = CLLocationManager()
    var mapItems = [MKMapItem]()
    var activeSearchBar: UISearchBar?
    var source: MKMapItem?
    var destination: MKMapItem?
    
    override func loadView() {
        view = offerTripScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Trip"
        offerTripScreen.tableViewSearchResults.dataSource = self
        offerTripScreen.tableViewSearchResults.delegate = self
        offerTripScreen.sourceSearchBar.delegate = self
        offerTripScreen.destinationSearchBar.delegate = self
        offerTripScreen.tableViewSearchResults.separatorStyle = .none
        
        setupLocationManager()
        offerTripScreen.mapView.delegate = self
        
        offerTripScreen.newTripButton.addTarget(self, action: #selector(onNewTripButtonTapped), for: .touchUpInside)
    }
    
    @objc func onNewTripButtonTapped() {
        offerTripScreen.searchWrapperView.isHidden = false
        offerTripScreen.mapView.isHidden = true
        offerTripScreen.newTripButton.isHidden = true
        
        source = nil
        destination = nil
        offerTripScreen.destinationSearchBar.text = ""
        offerTripScreen.sourceSearchBar.text = ""
    }
    
    @objc func onButtonCurrentLocationTapped(){
        if let uwLocation = locationManager.location{
            offerTripScreen.mapView.centerToLocation(location: uwLocation)
            let currentLocation = Place(
                title: "Source",
                coordinate: CLLocationCoordinate2D(latitude: uwLocation.coordinate.latitude, longitude: uwLocation.coordinate.longitude),
                info: "Start"
            )
            
            offerTripScreen.mapView.addAnnotation(currentLocation)
        }
    }
    
}

extension OfferTripViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        activeSearchBar = searchBar
        self.offerTripScreen.mapView.isHidden = true
        self.offerTripScreen.tableViewSearchResults.isHidden = false
        self.loadPlacesAround(query: searchText)
        self.offerTripScreen.tableViewSearchResults.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
}


extension MKMapView {
    func centerToLocation(location: CLLocation, radius: CLLocationDistance = 1000){
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
        setRegion(coordinateRegion, animated: true)
    }
    
    func spanBetweenLocations(source: MKMapItem?, destination: MKMapItem?) {
        if let location1 = source?.placemark.coordinate, let location2 = destination?.placemark.coordinate {
            let midLatitude = (location1.latitude + location2.latitude) / 2
            let midLongitude = (location1.longitude + location2.longitude) / 2
            let center = CLLocationCoordinate2D(latitude: midLatitude, longitude: midLongitude)

            let span = MKCoordinateSpan(latitudeDelta: abs(location1.latitude  - location2.latitude) * 2,
                                         longitudeDelta: abs(location1.longitude - location2.longitude) * 2)
            let region = MKCoordinateRegion(center: center, span: span)

            setRegion(region, animated: true)
        }
    }
}
