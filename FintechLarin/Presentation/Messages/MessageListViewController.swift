//
//  MessageListViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData

class MessageListViewController: UIViewController,
        NSFetchedResultsControllerDelegate,
        UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var data = [MessageModel]()
    var toUserID: String = ""
    @IBOutlet var buttonSend: UIButton!
    @IBOutlet var textFealdMessage: UITextField!
    var online = true
    var conversationService: ConversationService?

    private lazy var tableViewDataSource: UITableViewDataSource = {

        let fetchedResultsController: NSFetchedResultsController<Message> = conversationService!
                .getMessageFRC(modelId: toUserID)
        fetchedResultsController.delegate = self

        return MessageTableViewDataSource(fetchedResultsController: fetchedResultsController)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ConversationDI.inject(viewController: self)

        self.tableView.dataSource = self.tableViewDataSource
        self.tableView.delegate = self

        textFealdMessage.addTarget(self, action: #selector(textFealdMessageDidChange(_:)), for: .editingChanged)

        NotificationCenter.default.addObserver(self,
                selector: #selector(self.keyboardNotification(notification:)),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil)
        invalidateData()

    }

    @IBAction func actionSend(_ sender: Any) {
        let text = textFealdMessage.text

        if let message = text {
            textFealdMessage.text = nil
            buttonSend.isEnabled = false
            conversationService?.sendMessage(text: message, toUserID: toUserID)
        }
        textFealdMessage.resignFirstResponder()
    }

    @objc func textFealdMessageDidChange(_ textField: UITextField) {
        buttonSend.isEnabled = online
    }

    func invalidateData() {
        buttonSend.isEnabled = online && (textFealdMessage.text?.count ?? 0 > 0)
    }

    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?
                    .doubleValue ?? 0
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

    func controller(
            _ controller: NSFetchedResultsController<NSFetchRequestResult>,
            didChange anObject: Any,
            at indexPath: IndexPath?,
            for type: NSFetchedResultsChangeType,
            newIndexPath: IndexPath?) {
        print("\(#function)")

        if let message = anObject as? Message,
           let online = message.conversation?.online {
            self.online = online
            invalidateData()
        }
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        }
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("\(#function)")
        self.tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("\(#function)")
        self.tableView.endUpdates()
    }
}
