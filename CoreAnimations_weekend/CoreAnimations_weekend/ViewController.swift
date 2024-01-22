//
//  ViewController.swift
//  CoreAnimations_weekend
//
//  Created by Hisop on 2024/01/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = CustomView()
        guard let customView = self.view as? CustomView else {
            return
        }
        customView.backgroundColor = UIColor.systemBackground
        customView.layerInit()
    }


}

