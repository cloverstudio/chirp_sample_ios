//
//  SecondViewController.swift
//  ChirpExample
//
//  Created by CloverField on 06/11/2019.
//  Copyright © 2019 CloverField. All rights reserved.
//

import UIKit
import ChirpSDK

class SecondViewController: UIViewController, ChirpProtocol  {
    
    let colorArray: [UIColor] = [UIColor.systemGreen, UIColor.systemYellow, UIColor.systemBlue, UIColor.systemRed, UIColor.systemPurple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let chirpService = appDelegate.chirpService {
            chirpService.delegate = self
        }
    }
    
    func setColor(_ color: String) {
        let index = Int (color)
        let selectedColor = self.colorArray[index!]
        self.view.backgroundColor = selectedColor
    }
    
}

