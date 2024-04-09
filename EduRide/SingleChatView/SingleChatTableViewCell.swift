//
//  MessageTableViewCell.swift
//  WA8_1
//
//  Created by Yash Agrawal on 3/31/24.
//

import UIKit

class SingleChatTableViewCell: UITableViewCell {
    
    var senderLabel: UILabel!
    var messageLabel: UILabel!
    var timestampLabel: UILabel!
    var wrapperCellView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupSenderLabel()
        setupMessageLabel()
        setupTimestampLabel()
        
        initConstraints()
    }

    func setupWrapperCellView() {
        wrapperCellView = UITableViewCell()
        
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 2.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(wrapperCellView)
    }
    
    func setupSenderLabel() {
        senderLabel = UILabel()
        senderLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        senderLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(senderLabel)
    }
    
    func setupMessageLabel() {
        messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(messageLabel)
    }
    
    func setupTimestampLabel() {
        timestampLabel = UILabel()
        timestampLabel.textColor = .gray
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(timestampLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            
            senderLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 4),
            senderLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 4),
            senderLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -4),
            
            messageLabel.topAnchor.constraint(equalTo: senderLabel.bottomAnchor, constant: 4),
            messageLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 4),
            messageLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -4),
            
            timestampLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 4),
            timestampLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -4),
            timestampLabel.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -4),
            
            //wrapperCellView.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

