//
//  ViewController.swift
//  EduRide
//
//  Created by Yash Agrawal on 3/1/24.
//

import UIKit

class LoginViewController: UIViewController {

    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        view.addSubview(button)
        button.addTarget(self, action:#selector (didTapButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews () {
        super.viewDidLayoutSubviews ()
        button.center = view.center
    }
    
    @objc func didTapButton(){
        let tabBar = TabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}

