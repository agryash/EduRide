//
//  MapAnnotationDelegate.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/3/24.
//

import Foundation
import MapKit

extension OfferTripViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation)
        -> MKAnnotationView? {
        guard let annotation = annotation as? Place else { return nil }
        
        var view:MKMarkerAnnotationView
        
        if let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: "placeIdentifier") as? MKMarkerAnnotationView{
            annotationView.annotation = annotation
            view = annotationView
        }else{
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "placeIdentifier")
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = view.annotation as? Place else { return }
        
        let ac = UIAlertController(
            title: annotation.title,
            message: "Navigate to \(annotation.title!) now?",
            preferredStyle: .alert
        )
        ac.addAction(UIAlertAction(title: "Navigate", style: .default, handler: {_ in
            let launchOptions = [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
            ]
            annotation.mapItem?.openInMaps(launchOptions: launchOptions)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}
