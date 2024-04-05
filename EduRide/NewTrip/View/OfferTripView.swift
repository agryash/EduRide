//
//  OfferTripView.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/2/24.
//

import UIKit
import MapKit

class OfferTripView: UIView {
    var searchWrapperView: UIView!
    var sourceLabel: UILabel!
    var sourceSearchBar: UISearchBar!
    var destinationLabel: UILabel!
    var destinationSearchBar: UISearchBar!
    var tableViewSearchResults: UITableView!
    var mapView:MKMapView!
    var newTripButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupSearchWrapperView()
        setupSourceLabel()
        setupDestinationLabel()
        setupSourceSearchBar()
        setupDestinationSearchBar()
        setupTableViewSearchResults()
        setupMapview()
        setupNewTripButton()
        initConstraints()
    }
    
    func setupSearchWrapperView() {
        searchWrapperView = UIView()
        searchWrapperView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchWrapperView)
    }
    
    func setupSourceLabel() {
        sourceLabel = UILabel()
        sourceLabel.text = "Source"
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        searchWrapperView.addSubview(sourceLabel)
    }
    
    func setupDestinationLabel() {
        destinationLabel = UILabel()
        destinationLabel.text = "Destination"
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        searchWrapperView.addSubview(destinationLabel)
    }
    
    func setupSourceSearchBar() {
        sourceSearchBar = UISearchBar()
        sourceSearchBar.placeholder = "Enter pickup location"
        sourceSearchBar.autocapitalizationType = .none
        sourceSearchBar.backgroundImage = UIImage()
        sourceSearchBar.translatesAutoresizingMaskIntoConstraints = false
        searchWrapperView.addSubview(sourceSearchBar)
    }
    
    func setupDestinationSearchBar() {
        destinationSearchBar = UISearchBar()
        destinationSearchBar.placeholder = "Enter destination location"
        destinationSearchBar.autocapitalizationType = .none
        destinationSearchBar.backgroundImage = UIImage()
        destinationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        searchWrapperView.addSubview(destinationSearchBar)
    }
    
    func setupTableViewSearchResults(){
        tableViewSearchResults = UITableView()
        tableViewSearchResults.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchResults")
        tableViewSearchResults.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewSearchResults)
    }

    func setupMapview() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 10
        mapView.isHidden = true
        self.addSubview(mapView)
    }
    
    func setupNewTripButton() {
        newTripButton = UIButton(type: .system)
        newTripButton.setTitle("New Trip", for: .normal)
        newTripButton.setTitleColor(.white, for: .normal)
        newTripButton.backgroundColor = .blue
        newTripButton.layer.cornerRadius = 8
        newTripButton.translatesAutoresizingMaskIntoConstraints = false
        newTripButton.isHidden = true
        addSubview(newTripButton)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            searchWrapperView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchWrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchWrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: searchWrapperView.topAnchor),
            sourceLabel.leadingAnchor.constraint(equalTo: searchWrapperView.leadingAnchor, constant: 16),
            sourceLabel.trailingAnchor.constraint(equalTo: searchWrapperView.trailingAnchor, constant: -16),
            
            sourceSearchBar.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 8),
            sourceSearchBar.leadingAnchor.constraint(equalTo: searchWrapperView.leadingAnchor, constant: 16),
            sourceSearchBar.trailingAnchor.constraint(equalTo: searchWrapperView.trailingAnchor, constant: -16),
            
            destinationLabel.topAnchor.constraint(equalTo: sourceSearchBar.bottomAnchor, constant: 16),
            destinationLabel.leadingAnchor.constraint(equalTo: searchWrapperView.leadingAnchor, constant: 16),
            destinationLabel.trailingAnchor.constraint(equalTo: searchWrapperView.trailingAnchor, constant: -16),
            
            destinationSearchBar.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor, constant: 8),
            destinationSearchBar.leadingAnchor.constraint(equalTo: searchWrapperView.leadingAnchor, constant: 16),
            destinationSearchBar.trailingAnchor.constraint(equalTo: searchWrapperView.trailingAnchor, constant: -16),
            destinationSearchBar.bottomAnchor.constraint(equalTo: searchWrapperView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableViewSearchResults.topAnchor.constraint(equalTo: searchWrapperView.bottomAnchor, constant: 8),
            tableViewSearchResults.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableViewSearchResults.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            
            mapView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            mapView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            newTripButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 32),
            newTripButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            newTripButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
