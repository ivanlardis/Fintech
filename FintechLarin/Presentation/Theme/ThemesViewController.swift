//
//  ThemesViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 14/10/2018.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {

    var themeClosure: ((_ controller: ThemesViewController, _ color: UIColor?) -> Void)?
    var model: Themes?

    override func viewDidLoad() {
        super.viewDidLoad()

        model = Themes.init(color1: UIColor.blue,
                color2: UIColor.green,
                color3: UIColor.red)
    }

    @IBAction func actionTheme1(_ sender: Any) {
        themeClosure?(self, model?.theme1)
    }

    @IBAction func actionTheme2(_ sender: Any) {
        themeClosure?(self, model?.theme2)
    }

    @IBAction func actionTheme3(_ sender: Any) {
        themeClosure?(self, model?.theme3)
    }

    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
