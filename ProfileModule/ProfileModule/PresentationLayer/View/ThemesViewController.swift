//
//  ThemesViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 14/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController, IThemesView {
    
    public var themesPresenter  : IThemesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeAssembly().inject(view: self)
    }
    
    @IBAction func actionTheme1(_ sender: Any) {
        themesPresenter?.selectedTheme1()
    }
    
    @IBAction func actionTheme2(_ sender: Any) {
        themesPresenter?.selectedTheme2()
    }
    
    @IBAction func actionTheme3(_ sender: Any) {
        themesPresenter?.selectedTheme3()
    }
    
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func configureTheme(color: UIColor) {
        view.backgroundColor = color
        ApperanceUtils.configureTheme(color: color)
    }
}
