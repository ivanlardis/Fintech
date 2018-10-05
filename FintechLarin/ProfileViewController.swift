//
//  ProfileViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 29/09/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var editProfileButtton: UIButton!
    @IBOutlet weak var editPhotoButton: UIButton!

    /** Логика метода init  — мы либо находим .xib (.nib) файл и ассоциируем его с UIViewController'ом, либо не ассоциируем.
      На данном этапе просто запоминается название xib файла, из которого, в случае чего надо подгрузить view.
     
     На этом этапе еще нет ни самой view, ни аутлетов(Outlets).
     
     из-за этого падаем на force unwrapping
     Fatal error: Unexpectedly found nil while unwrapping an Optional value
     при вызове
     print("\(#function)  \(editButtton.frame)")*/
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /** Необходимо заметить, что на данном этапе жизненного цикла контроллера, размеры view не актуальны,
     т.е. не такие, какими они будут после вывода на экран.
      Поэтому, использовать вычисления, основанные на ширине / высоте view, в методе viewDidload не рекомендуется. */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function)  \(editProfileButtton.frame)")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initViews()
    }

    /** При вызове viewWillAppear, view уже находится в иерархии отображения (view hierarchy) и имеет актуальные размеры,
     так, что здесь можно производить расчеты, основанные на ширине / высоте view.
     так как viewDidAppear вызываеться после viewWillAppear у него уже тоже актуальные размеры */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function)  \(editProfileButtton.frame)")
    }

    @IBAction func editPhotoAction(_ sender: Any) {
        print("Выбери изображение профиля")
        showChoiceImageAlert()
    }

    func initViews() {
        let widthEditPhotoView = editPhotoButton.frame.size.width

        let rect = CGRect(x: widthEditPhotoView / 4,
                y: widthEditPhotoView / 4,
                width: widthEditPhotoView / 2,
                height: widthEditPhotoView / 2)
        let imageView = UIImageView(frame: rect)
        imageView.image = UIImage(named: "slr-camera-2-xxl")
        editPhotoButton.addSubview(imageView)

        photoView.layer.cornerRadius = widthEditPhotoView / 2
        photoView.clipsToBounds = true

        editPhotoButton.layer.cornerRadius = widthEditPhotoView / 2
        editPhotoButton.clipsToBounds = true

        editProfileButtton.layer.cornerRadius = 16
        editProfileButtton.layer.borderWidth = 1
        editProfileButtton.layer.borderColor = UIColor.black.cgColor
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
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        photoView.contentMode = .scaleToFill
        photoView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }

}
