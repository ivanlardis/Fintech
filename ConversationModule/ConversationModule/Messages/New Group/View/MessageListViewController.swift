//
//  MessageListViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 06/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreData
import ServiceLayer
import CoreLayer

class MessageListViewController: UIViewController,
        NSFetchedResultsControllerDelegate,
        UITableViewDelegate,
        IMessageListView {

    @IBOutlet weak var tableView: UITableView!
    var data = [MessageModel]()
    var toUserID: String = ""
    @IBOutlet var buttonSend: UIButton!
    @IBOutlet var textFealdMessage: UITextField!
    var online = true

    public var presenter: IMessagePresenter?
    private lazy var tableViewDataSource: UITableViewDataSource = {

        let fetchedResultsController: NSFetchedResultsController<Message> = presenter!
                .getMessageFRC(conversationId: toUserID)
        fetchedResultsController.delegate = self

        return MessageTableViewDataSource(fetchedResultsController: fetchedResultsController)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        MessageAssembly.init().inject(view: self)

        self.tableView.dataSource = self.tableViewDataSource
        self.tableView.delegate = self

        textFealdMessage.addTarget(self, action: #selector(textFealdMessageDidChange(_:)), for: .editingChanged)

        NotificationCenter.default.addObserver(self,
                selector: #selector(self.keyboardNotification(notification:)),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil)


        initLabel()
        animateTitle(online: online)
        invalidateButtonSend(online: online)
    }

    func initLabel() {
        let label = UILabel.init()
        label.text = navigationItem.title
        self.navigationItem.titleView = label
    }

    @IBAction func actionSend(_ sender: Any) {
        let text = textFealdMessage.text

        if let message = text {
            textFealdMessage.text = nil
            invalidateButtonSend(online: false)
            presenter?.sendMessage(text: message, toUserID: toUserID)
        }
        textFealdMessage.resignFirstResponder()
    }

    @objc func textFealdMessageDidChange(_ textField: UITextField) {
        invalidateButtonSend(online: online)
    }

    func invalidateData() {
        invalidateButtonSend(online: online)
        animateTitle(online: online)
    }

    func invalidateButtonSend(online: Bool) {
        let show = online && (textFealdMessage.text?.count ?? 0 > 0)
        print("invalidateButtonSend \(show)")

        if buttonSend.isEnabled != show &&
                   show == true {
            animateSendButton()
        }
        buttonSend.isEnabled = show
    }

    func animateSendButton() {
        let scaleAnimate: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimate.fromValue = 1
        scaleAnimate.toValue = 2
        scaleAnimate.duration = 0.5
        buttonSend.layer.add(scaleAnimate, forKey: "scaleSmallAnimation")
    }

    func animateTitle(online: Bool) {
        guard  let titleView = self.navigationItem.titleView as? UILabel else {
            return
        }

        UIView.transition(with: titleView, duration: 1, options: .allowUserInteraction, animations: {
            if online {
                titleView.textColor = .green
                titleView.transform = CGAffineTransform(scaleX: 1, y: 1.1)
            } else {
                titleView.textColor = .black
                titleView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }, completion: nil)

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

    func controller(
            _ controller: NSFetchedResultsController<NSFetchRequestResult>,
            didChange anObject: Any,
            at indexPath: IndexPath?,
            for type: NSFetchedResultsChangeType,
            newIndexPath: IndexPath?) {


        if let message = anObject as? Message,
           let online = message.conversation?.online {
            self.online = online
            print("MessageListViewController \(#function) online \(online)")
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
        print("MessageListViewController \(#function)")
        self.tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("MessageListViewController \(#function)")
        self.tableView.endUpdates()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
