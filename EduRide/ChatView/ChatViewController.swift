//
//  ChatViewController.swift
//  EduRide
//
//  Created by Yash Agrawal on 4/1/24.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    var currUser : FirebaseAuth.User?
    var chats:[String] = []
    let chatScreen = ChatScreenView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var hashmap: [String: User] = [:]
    
    override func loadView() {
        view = chatScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chats"
        
        handleAuth = Auth.auth().addStateDidChangeListener{auth, user in
            if user != nil {
                self.currUser = user
                self.fetchConversations()
            }
        }
        // Do any additional setup after loading the view.
        
        
        chatScreen.tableViewChats.dataSource = self
        chatScreen.tableViewChats.delegate = self
    }

    func fetchConversations(){
        chatScreen.tableViewChats.isHidden = false;
        
        DatabaseManager.shared.getAllConversationsWithUser(with: (currUser?.email)!) { result in
            switch result {
            case .success(let conversationIDs):
                let myArray: [String] = Array(conversationIDs)
                
                self.chats = myArray
                self.chatScreen.tableViewChats.reloadData()
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
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
        vc.currSender = (self.currUser?.email!)!
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

