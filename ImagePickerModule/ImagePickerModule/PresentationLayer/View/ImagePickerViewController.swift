//
//  ImagePickerViewController.swift
//  ImagePickerModule
//
//  Created by Иван Lardis on 25/11/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit
import CoreLayer

class ImagePickerViewController: UIViewController,
        IImagePickerView,
        UICollectionViewDataSource,
        UICollectionViewDelegate {

    public var presenter: IImagePickerPresenter?
    private var data: ImageListModel?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    @IBAction func actionDismiss(_ sender: Any) {
        close()
    }

    func close() {
        dismiss(animated: true, completion: nil)
    }

    func showLoading(show: Bool) {
        indicatorView.isHidden = !show
        if show {
            indicatorView.stopAnimating()
        } else {

            indicatorView.stopAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = data?.hits[indexPath.row].webformatURL {
            presenter?.saveImage(url: url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ImagePickerAssembly().inject(view: self)
        presenter?.getImageList()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func show(data: ImageListModel) {
        self.data = data
        collectionView.reloadData()
    }

    func showLoadingError(text: String) {
        let alert = UIAlertController(title: "Ошибка загрузки",
                message: text,
                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Повторить загрузку", style: .default) { _ in

            self.presenter?.getImageList()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.hits.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagePickerCellIdentifier", for: indexPath)
        if let imagePickerCell = cell as? ImagePickerCell {
            imagePickerCell.image = nil

            if let url = data?.hits[indexPath.row].webformatURL {
                presenter?.getImage(cell: imagePickerCell, url: url)
            }
        }
        return cell
    }
}
