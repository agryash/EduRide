//
//  TripDetailsViewController.swift
//  EduRide
//
//  Created by Riya on 4/3/24.
//

import UIKit

class TripDetailsViewController: UIViewController {

    let tripDetails = TripDetailsView()
      
    override func loadView() {
        view = tripDetails
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trip Details"
    }
}
