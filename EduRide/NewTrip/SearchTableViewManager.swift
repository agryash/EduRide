//
//  SearchTableViewManager.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/2/24.
//

import Foundation
import UIKit
import MapKit

extension OfferTripViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResults", for: indexPath) as! SearchTableViewCell
        if let name = mapItems[indexPath.row].name{
                cell.labelTitle.text = name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = mapItems[indexPath.row]
        
        // update the source and destination fields accordingly
        if self.activeSearchBar == self.offerTripScreen.sourceSearchBar {
            self.offerTripScreen.sourceSearchBar.text = place.name
            self.source = place
        } else {
            self.offerTripScreen.destinationSearchBar.text = place.name
            self.destination = place
        }
        self.mapItems.removeAll()
        self.offerTripScreen.tableViewSearchResults.reloadData()
        
        // when both locations are chosen
        if self.source != nil && self.destination != nil {
            // Hide search table and search bar
            // Show Mapview
            self.offerTripScreen.tableViewSearchResults.isHidden = true
            self.offerTripScreen.mapView.isHidden = false
            self.offerTripScreen.newTripButton.isHidden = false
            self.offerTripScreen.searchWrapperView.isHidden = true

            
            
            // Mark source and destination on the map
            if let src = self.source, let dest = self.destination {
                offerTripScreen.mapView.spanBetweenLocations(
                    sourceLatitude: src.placemark.coordinate.latitude,
                    destinationLatitude: dest.placemark.coordinate.latitude,
                    sourceLongitude: src.placemark.coordinate.longitude,
                    destinationLongitude: dest.placemark.coordinate.longitude)
                let source = Place(
                    title: "Source",
                    coordinate: CLLocationCoordinate2D(latitude: src.placemark.coordinate.latitude, longitude: src.placemark.coordinate.longitude),
                    info: "Start"
                )
                let destination = Place(
                    title: "Destination",
                    coordinate: CLLocationCoordinate2D(latitude: dest.placemark.coordinate.latitude, longitude: dest.placemark.coordinate.longitude),
                    info: "End"
                )
                offerTripScreen.mapView.addAnnotation(source)
                offerTripScreen.mapView.addAnnotation(destination)
            }
            
            let tripConfirmationController  = TripConfirmationViewController()
            tripConfirmationController.source = self.source
            tripConfirmationController.destination = self.destination
            
            let navForSearch = UINavigationController(rootViewController: tripConfirmationController)
            navForSearch.modalPresentationStyle = .pageSheet
            
            if let searchBottomSheet = navForSearch.sheetPresentationController{
                searchBottomSheet.detents = [.medium(), .large()]
                searchBottomSheet.prefersGrabberVisible = true
            }
            
            present(navForSearch, animated: true)
        }
    }
}
