//
//  DemoChannelVC.swift
//  SacrenaChatApp
//
//  Created by PSE on 14/09/2024.
//

import StreamChat
import StreamChatUI
import UIKit

class TypingIndicator: UILabel {
    func resetText() {
        text = "Nobody is typing"
    }
}

class DemoChannelVC: ChatChannelVC {
    var typingIndicator: TypingIndicator!

    override func setUpLayout() {
        super.setUpLayout()

        typingIndicator = TypingIndicator()
        view.addSubview(typingIndicator)

        typingIndicator.backgroundColor = .lightGray
        typingIndicator.translatesAutoresizingMaskIntoConstraints = false
        typingIndicator.resetText()

        NSLayoutConstraint.activate([
            typingIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            typingIndicator.heightAnchor.constraint(equalToConstant: 30),
            typingIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            typingIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageListVC.view.topAnchor.constraint(equalTo: typingIndicator.bottomAnchor)
        ])
    }

    override func channelController(_ channelController: ChatChannelController, didChangeTypingUsers typingUsers: Set<ChatUser>) {
        let typingUsersWithoutCurrentUser = typingUsers
            .filter { $0.id != self.channelController.client.currentUserId }

        guard let typingUser = typingUsersWithoutCurrentUser.first else {
            typingIndicator.resetText()
            return
        }
        typingIndicator.text = "\(typingUser.name ?? typingUser.id) is typing..."
    }
}
