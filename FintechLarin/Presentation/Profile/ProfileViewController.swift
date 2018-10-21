//
//  ProfileViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 29/09/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,
        UIImagePickerControllerDelegate,
        UINavigationControllerDelegate,
        UITextViewDelegate,
        UITextFieldDelegate {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var editProfileButtton: UIButton!
    @IBOutlet weak var editPhotoButton: UIButton!
    @IBOutlet var operationSaveButton: UIButton!
    @IBOutlet var gcdSaveButton: UIButton!
    @IBOutlet var nameTextFeald: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!


    var gCDDataManager: MultithreadingDataManager?
    var operationDataManager: MultithreadingDataManager?
    let changeModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        DI.inject(viewController: self)

        nameTextFeald.addTarget(self, action: #selector(nameTextFealdDidChange(_:)), for: .editingChanged)
        descriptionTextView.delegate = self
        nameTextFeald.delegate = self

        NotificationCenter.default.addObserver(self,
                selector: #selector(self.keyboardNotification(notification:)),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil)

        loadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initViews()
    }

    @objc func nameTextFealdDidChange(_ textField: UITextField) {
        changeModel.name = textField.text
        saveButtonMode(isEnabled: true)
    }

    func textViewDidChange(_ textView: UITextView) {
        changeModel.description = textView.text
        saveButtonMode(isEnabled: true)
    }

    @IBAction func editPhotoAction(_ sender: Any) {
        print("Выбери изображение профиля")
        showChoiceImageAlert()
    }

    @IBAction func gcdSaveAction(_ sender: Any) {
        saveData(dataManager: gCDDataManager)
    }

    @IBAction func operationSaveAction(_ sender: Any) {
        saveData(dataManager: operationDataManager)
    }

    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func actionProfileEdit(_ sender: Any) {
        showTypeMode(isEdit: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        descriptionTextView.becomeFirstResponder()
        return false
    }

    func initViews() {
        let widthEditPhotoView = editPhotoButton.frame.size.width
        let cornerRadius = widthEditPhotoView / 2

        let rect = CGRect(x: widthEditPhotoView / 4,
                y: widthEditPhotoView / 4,
                width: widthEditPhotoView / 2,
                height: widthEditPhotoView / 2)
        let imageView = UIImageView(frame: rect)
        imageView.image = UIImage(named: "slr-camera-2-xxl")
        editPhotoButton.addSubview(imageView)
        editPhotoButton.layer.cornerRadius = cornerRadius
        editPhotoButton.clipsToBounds = true

        photoView.layer.cornerRadius = widthEditPhotoView / 2
        photoView.clipsToBounds = true

        initButtonStyle(button: editProfileButtton, cornerRadius: cornerRadius)
        initButtonStyle(button: operationSaveButton, cornerRadius: cornerRadius)
        initButtonStyle(button: gcdSaveButton, cornerRadius: cornerRadius)

        descriptionTextView.textContainer.maximumNumberOfLines = 10
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail

    }

    func loadData() {
        showLoading(show: true)
        operationDataManager?.loadData(callback: { model in
            self.showLoading(show: false)
            self.showData(model: model)
        })
    }

    func showData(model: ProfileViewModel) {
        nameTextFeald.text = model.name ?? "Незаполнено"
        descriptionTextView.text = model.description ?? "Незаполнено"

        if let image = model.avatar {
            photoView.image = image
        } else {
            photoView.image = UIImage(named: "placeholder-user.png")

        }
    }

    func saveData(dataManager: MultithreadingDataManager?) {

        showLoading(show: true)
        dataManager?.save(model: changeModel, callback: { success in
            if success {

                self.showTypeMode(isEdit: false)
                self.saveButtonMode(isEnabled: false)

                let alert = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)

            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)

                let ok = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
                    self.loadData()
                    self.saveButtonMode(isEnabled: false)
                    self.self.showTypeMode(isEdit: false)
                }
                let repeatAction = UIAlertAction(title: "Повторить", style: .default) { (action: UIAlertAction) in
                    self.saveData(dataManager: dataManager)
                }
                alert.addAction(ok)
                alert.addAction(repeatAction)
                self.present(alert, animated: true, completion: nil)
            }
            self.showLoading(show: false)
        })
    }

    func showTypeMode(isEdit: Bool) {
        editProfileButtton.isHidden = isEdit
        operationSaveButton.isHidden = !isEdit
        gcdSaveButton.isHidden = !isEdit
        editPhotoButton.isHidden = !isEdit
        nameTextFeald.isUserInteractionEnabled = isEdit
        descriptionTextView.isUserInteractionEnabled = isEdit
        let borderStyle = !isEdit ? UITextField.BorderStyle.none : UITextField.BorderStyle.roundedRect
        nameTextFeald.borderStyle = borderStyle

        if isEdit {
            descriptionTextView.layer.borderWidth = 0.5
            descriptionTextView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            descriptionTextView.layer.cornerRadius = 10
            print("if")
        } else {
            descriptionTextView.layer.borderWidth = 0
        }
    }

    func initButtonStyle(button: UIButton, cornerRadius: CGFloat) {
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }

// MARK: работа с галереей и камерой
    func showChoiceImageAlert() {
        let alertController = UIAlertController(title: "Загрузить картинку", message: nil, preferredStyle: .actionSheet)

        let actionOpenGallary = UIAlertAction(title: "Установить из галлереи", style: .default) { (action: UIAlertAction) in
            self.openGallary()
        }

        let actionOpenCamera = UIAlertAction(title: "Сделать фото", style: .default) { (action: UIAlertAction) in
            self.openCamera()
        }

        alertController.addAction(actionOpenGallary)
        alertController.addAction(actionOpenCamera)
        self.present(alertController, animated: true, completion: nil)
    }

    func openGallary() {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker, animated: true, completion: nil)
    }

    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            let picker: UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Камера не найдена", message: "На этом устройстве нет камеры", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let chosenImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        photoView.contentMode = .scaleToFill
        photoView.image = chosenImage
        saveButtonMode(isEnabled: true)
        changeModel.avatar = chosenImage
        dismiss(animated: true, completion: nil)
    }

    func showLoading(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }

    func saveButtonMode(isEnabled: Bool) {
        operationSaveButton.isEnabled = isEnabled
        gcdSaveButton.isEnabled = isEnabled
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
        NotificationCenter.default.removeObserver(self)
    }
}


