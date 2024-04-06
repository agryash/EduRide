//
//  ChatScreenView.swift
//  EduRide
//
//  Created by Yash Agrawal on 4/6/24.
//

import UIKit

class ChatScreenView: UIView {

    var tableViewChats: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewChats()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableViewChats() {
        tableViewChats = UITableView()
        tableViewChats.register(ChatTableViewCell.self, forCellReuseIdentifier: "chats")
        tableViewChats.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewChats)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewChats.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewChats.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewChats.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewChats.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}
