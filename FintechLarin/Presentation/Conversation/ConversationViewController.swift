//
//  ConversationViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, IConversationView {

    var communicationManager: CommunicationManager?
    @IBOutlet weak var tableView: UITableView!
    var data = [ConversationCellModel]()
    var toUserID: String?
    @IBOutlet var buttonSend: UIButton!
    @IBOutlet var textFealdMessage: UITextField!
    var online = true

    override func viewDidLoad() {
        super.viewDidLoad()
        ConversationDI.inject(viewController: self)
        self.tableView.dataSource = self

        communicationManager?.toUserID = toUserID

        textFealdMessage.addTarget(self, action: #selector(textFealdMessageDidChange(_:)), for: .editingChanged)

        NotificationCenter.default.addObserver(self,
                selector: #selector(self.keyboardNotification(notification:)),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        communicationManager?.updateData()
    }

    @IBAction func actionSend(_ sender: Any) {
        let text = textFealdMessage.text

        if let message = text,
           let toUser = toUserID {

            textFealdMessage.text = nil
            buttonSend.isEnabled = false
            communicationManager?.sendMessage(text: message, toUserID: toUser)
        }
        
         textFealdMessage.resignFirstResponder()
    }

    @objc func textFealdMessageDidChange(_ textField: UITextField) {
        buttonSend.isEnabled = online
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.row]
        let idCell = model.isIncomingMessage ? "ConversationIncomingCell" : "ConversationOutgoingCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)

        if let conversationCell = cell as? ConversationCellConfiguration {
            conversationCell.textMessage = model.textMessage
            conversationCell.date = model.date
        }
        return cell
    }


    func showData(models: ConversationsCellModel) {
        online = models.online
        buttonSend.isEnabled = models.online && (textFealdMessage.text?.count ?? 0 > 0)

        let sortModels = models.message.sorted {
            $0.date.timeIntervalSinceNow < $1.date.timeIntervalSinceNow
        }
        data = sortModels
//        tableView.contentOffset =  CGPoint.init(x: 0, y: CGFloat.greatestFiniteMagnitude)
        tableView.reloadData()
    }

    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {

                self.view.frame.origin.y = 0

            } else {
                self.view.frame.origin.y = -(endFrame?.size.height ?? 0)
            }
            UIView.animate(withDuration: duration,
                    delay: TimeInterval(0),
                    options: animationCurve,
                    animations: { self.view.layoutIfNeeded() },
                    completion: nil)
        }
    }

    deinit {
        ConversationDI.reject(viewController: self)
        NotificationCenter.default.removeObserver(self)
    }
}

