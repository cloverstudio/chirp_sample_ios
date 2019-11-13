//
//  ThirdViewController.swift
//  ChirpExample
//
//  Created by CloverField on 12/11/2019.
//  Copyright © 2019 CloverField. All rights reserved.
//

import UIKit
import Toast_Swift

class ThirdViewController: UIViewController,ChirpProtocol {
    
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBAction func onSend(_ sender: Any) {
        
        if verifyUrl(urlString: self.urlTextField.text){
            
            let identifier: String = urlTextField.text!
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if let chirpService = appDelegate.chirpService {
                chirpService.send(identifier)
            }
        }
        else{
            urlTextField.placeholder = "not valid url"
        }
        urlTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let chirpService = appDelegate.chirpService {
            chirpService.delegate = self
        }
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    func errorHandling(_ error: String) {
        self.view.makeToast(error, duration: 3.0, position: .top)
    }
}
