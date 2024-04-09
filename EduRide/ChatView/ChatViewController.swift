//
//  ChatViewController.swift
//  EduRide
//
//  Created by Yash Agrawal on 4/1/24.
//

import UIKit

class ChatViewController: UIViewController {
    
    var chats:[String] = []
    let chatScreen = ChatScreenView()
    
    override func loadView() {
        view = chatScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chats"
        // Do any additional setup after loading the view.
        fetchConverstaions()
        
        chatScreen.tableViewChats.dataSource = self
        chatScreen.tableViewChats.delegate = self
    }

    func fetchConverstaions(){
        chatScreen.tableViewChats.isHidden = false;
        chats = ["Yash", "Riya", "Gowtham", "Abhisha"]
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chats", for: indexPath) as! ChatTableViewCell
        cell.senderLabel.text = chats[indexPath.row]
        cell.messageLabel.text = "message"
        cell.timestampLabel.text = "00:00"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SingleChatViewController(with: "", id: "")
        vc.title = chats[indexPath.row]
        vc.otherUserEmail = chats[indexPath.row]
        vc.currSender = ""
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

