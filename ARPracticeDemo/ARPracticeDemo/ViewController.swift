//
//  ViewController.swift
//  ARPracticeDemo
//
//  Created by Joe on 2020/4/28.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
}
