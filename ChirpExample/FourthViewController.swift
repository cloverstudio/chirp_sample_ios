//
//  FourthViewController.swift
//  ChirpExample
//
//  Created by CloverField on 12/11/2019.
//  Copyright © 2019 CloverField. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController, ChirpProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let chirpService = appDelegate.chirpService {
            chirpService.delegate = self
        }
    }

    func openUrl(_ url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
}
