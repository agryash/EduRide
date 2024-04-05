//
//  TripConfirmationView.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/3/24.
//

import UIKit

class TripConfirmationView: UIView {
    var startTimeLabel: UILabel!
    var startTime: UIDatePicker!
    var seatsInputLabel: UILabel!
    var seatsInput: UITextField!
    var priceInputLabel: UILabel!
    var pricePerSeat: UITextField!
    var confirmButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupStartTimeLabel()
        setupStartTimePicker()
        setupSeatsInputLabel()
        setupSeatsInput()
        setupPriceInputLabel()
        setupPricePerSeat()
        setupConfirmButton()
        initConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStartTimeLabel() {
        startTimeLabel = UILabel()
        startTimeLabel.text = "Start Time"
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startTimeLabel)
    }
    
    private func setupSeatsInputLabel() {
        seatsInputLabel = UILabel()
        seatsInputLabel.text = "Available Seats"
        seatsInputLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(seatsInputLabel)
    }
    
    private func setupPriceInputLabel() {
        priceInputLabel = UILabel()
        priceInputLabel.text = "Price per Seat($)"
        priceInputLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(priceInputLabel)
    }
    
    private func setupStartTimePicker() {
        startTime = UIDatePicker()
        startTime.datePickerMode = .dateAndTime
        startTime.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startTime)
    }

    private func setupSeatsInput() {
        seatsInput = UITextField()
        seatsInput.placeholder = "Number of seats"
        seatsInput.borderStyle = .roundedRect
        seatsInput.keyboardType = .numberPad
        seatsInput.translatesAutoresizingMaskIntoConstraints = false
        addSubview(seatsInput)
    }

    private func setupPricePerSeat() {
        pricePerSeat = UITextField()
        pricePerSeat.placeholder = "Price per seat"
        pricePerSeat.borderStyle = .roundedRect
        pricePerSeat.keyboardType = .decimalPad
        pricePerSeat.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pricePerSeat)
    }

    private func setupConfirmButton() {
        confirmButton = UIButton(type: .system)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .blue
        confirmButton.layer.cornerRadius = 8
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(confirmButton)
    }

    private func initConstraints() {
        NSLayoutConstraint.activate([
            startTimeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            startTimeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startTimeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            startTime.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 12),
            startTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
   
            seatsInputLabel.topAnchor.constraint(equalTo: startTime.bottomAnchor, constant: 20),
            seatsInputLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            seatsInputLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            seatsInput.topAnchor.constraint(equalTo: seatsInputLabel.bottomAnchor, constant: 12),
            seatsInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            seatsInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            priceInputLabel.topAnchor.constraint(equalTo: seatsInput.bottomAnchor, constant: 20),
            priceInputLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            priceInputLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            pricePerSeat.topAnchor.constraint(equalTo: priceInputLabel.bottomAnchor, constant: 12),
            pricePerSeat.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            pricePerSeat.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            confirmButton.topAnchor.constraint(equalTo: pricePerSeat.bottomAnchor, constant: 32),
            confirmButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            confirmButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60)
        ])
    }
}
