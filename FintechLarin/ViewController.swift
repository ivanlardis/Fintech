//
//  ViewController.swift
//  FintechLarin
//
//  Created by Иван Lardis on 23.09.18.
//  Copyright © 2018 ivan larin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        printMethod(functionName: #function)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        printMethod(functionName: #function)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        printMethod(functionName: #function)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printMethod(functionName: #function)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        printMethod(functionName: #function)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        printMethod(functionName: #function)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        printMethod(functionName: #function)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        printMethod(functionName: #function)
    }

    func printMethod(functionName :String){
        Logger.d(message: "ViewController: \(functionName).")
    }
    
}

