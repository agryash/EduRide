//
//  SingleChatViewController.swift
//  WA8_1
//
//  Created by Yash Agrawal on 3/29/24.
//

import UIKit

class SingleChatViewController: UIViewController {
    
    private var messages = [Chat]()
    let chatScreen = SingleChatView()
    public var currSender = ""
    public var otherUserEmail: String
    

    override func loadView() {
        view = chatScreen
    }
    
    init(with email: String, id: String?) {
        self.otherUserEmail = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SingleChatViewController: " + currSender)
        fetchMessages()
        
        chatScreen.tableViewChats.dataSource = self
        chatScreen.tableViewChats.delegate = self
        
        chatScreen.buttonAdd.addTarget(self, action: #selector(onButtonAddTapped), for: .touchUpInside)
    }
    
    @objc func onButtonAddTapped(){
        if(chatScreen.textFieldAddNote.text == ""){
            showInvalidErrorAlert(message: "Message can't be empty")
        } else {
            //Send Chat
            DatabaseManager.shared.insertChat(with: otherUserEmail, sender: currSender , text: chatScreen.textFieldAddNote.text!)
            chatScreen.textFieldAddNote.text = ""
            fetchMessages()
            chatScreen.tableViewChats.reloadData()
            scrollToBottom()
        }
    }
    
    func showInvalidErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Error!", message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chatScreen.tableViewChats.frame = view.bounds
    }
    
    func fetchMessages(){
        DatabaseManager.shared.findChat(with: currSender, user: otherUserEmail, completion: { result in
            switch result {
            case .success(let conversationIDs):
                self.messages.removeAll()
                let messagesArray: [Chat] = Array(conversationIDs)
                self.messages = messagesArray
                self.chatScreen.tableViewChats.reloadData()
                
            case .failure(let error):
                print("Error: \(error)")
            }
        })
        
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async { [self] in
            let indexPath = IndexPath(row: self.messages.count-1, section: 0)
            chatScreen.tableViewChats.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension SingleChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messages", for: indexPath) as! SingleChatTableViewCell
        cell.messageLabel.text = messages[indexPath.row].text
        cell.senderLabel.text = messages[indexPath.row].from
        if(messages[indexPath.row].from == currSender){
            cell.wrapperCellView.backgroundColor = .lightGray
        }
        if(messages[indexPath.row].from != currSender){
            cell.wrapperCellView.backgroundColor = .white
        }
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "MM-dd HH:mm"
        cell.timestampLabel.text = formatter.string(for: NSDate(timeIntervalSince1970: messages[indexPath.row].timestamp))
        
        return cell
    }
}
