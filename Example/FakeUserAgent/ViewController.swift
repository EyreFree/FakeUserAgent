//
//  ViewController.swift
//  FakeUserAgent.swift
//
//  Created by EyreFree on 05/12/2023.
//  Copyright (c) 2023 EyreFree. All rights reserved.
//

import UIKit
import FakeUserAgent

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FakeUserAgent.shared.pickALot(count: 5, browser: .chrome, filter: { userAgent in
            return userAgent.contains("Macintosh; Intel Mac OS X 10_")
        }, completion: { result in
            print(result.joined(separator: "\n"))
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

