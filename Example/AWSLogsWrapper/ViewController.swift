//
//  ViewController.swift
//  AWSLogsWrapper
//
//  Created by rajasekhar.pattem@tarams.com on 04/14/2020.
//  Copyright (c) 2020 rajasekhar.pattem@tarams.com. All rights reserved.
//

import UIKit
import AWSLogsWrapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Logger.writeLogsToAWSCloudWatch(message: "ViewControllers view Loaded", event: .info)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

