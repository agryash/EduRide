//
//  LoadPlaces.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/2/24.
//
import MapKit

extension OfferTripViewController {
    func loadPlacesAround(query: String){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        searchRequest.region = offerTripScreen.mapView.region

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                return
            }
            self.mapItems = response.mapItems
        }
    }
}
