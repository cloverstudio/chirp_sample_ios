//
//  FirstViewController.swift
//  ChirpExample
//
//  Created by CloverField on 06/11/2019.
//  Copyright © 2019 CloverField. All rights reserved.
//

import UIKit
import Toast_Swift

class FirstViewController: UIViewController, ChirpProtocol {
    
    
    @IBAction func buttonTouch(_ sender: Any) {
        
        let button: UIButton = sender as! UIButton
        let identifier: String = String(button.tag)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let chirpService = appDelegate.chirpService {
            chirpService.send(identifier)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let chirpService = appDelegate.chirpService {
            chirpService.delegate = self
        }
    }
    
    func errorHandling(_ error: String) {
        self.view.makeToast(error, duration: 3.0, position: .top)
    }
    
}

