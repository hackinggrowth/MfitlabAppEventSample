//
//  ViewController.swift
//  MfitlabAppEventSample
//
//  Created by Dohyung Park on 2022/03/29.
//

import UIKit
import Mixpanel

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let instance = Mixpanel.sharedInstance()
        instance!.track("viewViewController")
    }
}

