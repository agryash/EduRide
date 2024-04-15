//
//  FindTripView.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/3/24.
//

import UIKit

class FindTripView: UIView {
    var tripDateLabel: UILabel!
    var datePicker: UIDatePicker!

    var tripsLabel: UILabel!
    var coPassCardViews: [TripCardView] = []
//    var tableViewTrips: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTripDateLabel()
        setupDatePicker()
        setupTripsLabel()
        initConstraints()
    }
    
    func setupTripDateLabel() {
        tripDateLabel = UILabel()
        tripDateLabel.text = "Select Trip Date"
        tripDateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tripDateLabel)
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        addSubview(datePicker)
    }
    
    func setupTripsLabel() {
        tripsLabel = UILabel()
        tripsLabel.text = "Available Trips"
        tripsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        tripsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tripsLabel)
    }
    
    func setupTripsCardView(trips: [Trip]) {
        for cardView in coPassCardViews {
            cardView.removeFromSuperview()
        }
        coPassCardViews.removeAll()
        for (index, trip) in trips.enumerated() {
            let coPassCardView = TripCardView()
            coPassCardView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(coPassCardView)
            
            coPassCardView.nameLabel.text = trip.userEmail
            coPassCardView.priceLabel.text = "$\(String(format: "%.2f", trip.pricePerSeat))"
            coPassCardView.acceptButton.tag = index
            coPassCardView.rejectButton.tag = index
                    
            coPassCardViews.append(coPassCardView)
        }
        layoutCardViews()
    }
    
    func layoutCardViews() {
        var previousCardView: UIView?
        for cardView in coPassCardViews {
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: previousCardView?.bottomAnchor ?? tripsLabel.bottomAnchor, constant: 16),
                cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
            
            previousCardView = cardView
        }
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            tripDateLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tripDateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            datePicker.topAnchor.constraint(equalTo: tripDateLabel.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            tripsLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            tripsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
