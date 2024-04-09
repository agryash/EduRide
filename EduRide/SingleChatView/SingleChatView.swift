//
//  SingleChatView.swift
//  WA8_1
//
//  Created by Yash Agrawal on 3/31/24.
//

import UIKit

class SingleChatView: UIView {

    var tableViewChats: UITableView!
    var buttonAdd: UIButton!
    var bottomAddView: UIView!
    var textFieldAddNote: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = .white
        
        setupTableViewChats()
        setupBottomAddView()
        setupTextFieldAddNotes()
        setupButtonAdd()

        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBottomAddView() {
        bottomAddView = UIView()
        bottomAddView.backgroundColor = .white
        bottomAddView.layer.cornerRadius = 6
        bottomAddView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomAddView.layer.shadowOffset = .zero
        bottomAddView.layer.shadowRadius = 4.0
        bottomAddView.layer.shadowOpacity = 0.7
        bottomAddView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomAddView)
    }
    
    func setupTextFieldAddNotes() {
        textFieldAddNote = UITextField()
        textFieldAddNote.placeholder = "Message"
        textFieldAddNote.borderStyle = .roundedRect
        textFieldAddNote.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(textFieldAddNote)
    }
        
    func setupButtonAdd() {
        buttonAdd = UIButton(type: .system)
        buttonAdd.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonAdd.setTitle("Send Message", for: .normal)
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(buttonAdd)
    }
    func setupTableViewChats() {
        tableViewChats = UITableView()
        tableViewChats.register(SingleChatTableViewCell.self, forCellReuseIdentifier: "messages")
        tableViewChats.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewChats)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewChats.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewChats.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewChats.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewChats.bottomAnchor.constraint(equalTo: self.bottomAddView.topAnchor, constant: -8),
            
            bottomAddView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            bottomAddView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomAddView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            buttonAdd.bottomAnchor.constraint(equalTo: bottomAddView.bottomAnchor, constant: -8),
            buttonAdd.leadingAnchor.constraint(equalTo: bottomAddView.leadingAnchor, constant: 4),
            buttonAdd.trailingAnchor.constraint(equalTo: bottomAddView.trailingAnchor, constant: -4),
            
            textFieldAddNote.bottomAnchor.constraint(equalTo: buttonAdd.topAnchor, constant: -8),
            textFieldAddNote.leadingAnchor.constraint(equalTo: buttonAdd.leadingAnchor, constant: 4),
            textFieldAddNote.trailingAnchor.constraint(equalTo: buttonAdd.trailingAnchor, constant: -4),
            
            bottomAddView.topAnchor.constraint(equalTo: textFieldAddNote.topAnchor, constant: -8),
        ])
    }
}
