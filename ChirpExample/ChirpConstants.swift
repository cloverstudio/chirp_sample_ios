//
//  ChirpConstants.swift
//  ChirpExample
//
//  Created by CloverField on 06/11/2019.
//  Copyright © 2019 CloverField. All rights reserved.
//

import Foundation
import ChirpSDK
import UIKit

class ChirpConstants {
    public static let CHIRP_APP_KEY: String = "cBaC447afDeE953ed0Bf75A77";
    public static let CHIRP_APP_SECRET: String = "D9ee48E3e8ad16FB14FFcf075DB7AAa3eBA0C4a6DaAd27ce7B";
    public static let CHIRP_APP_CONFIG: String = "avUZgjzUaO/QGkfe3JqOmcye7wniaftywotZIaI7Pd72BEZUMtkXQx6Pr8/FCmxHVQkl+E5u7P8q7WXb1TwYIYj9fyKtGSbA2PdsdaTHlLvjJ1w8pb4Kr9VMTkZ2Zib/lw1RGkF//sbYxI+x9gqixBzAOVSDMlL5lO1eV5HCqoGs2Sv6xXRdkSZGhN6AByws2Tl7QxjK7OmFZzl+vYwgYFk0IiqWdiiZVRYKx5BR7ObThlmFIg+C8bjrcma8wHbSEmCy9TBiLvdjo1aXF8h8ezqa9h1IDI39Idk8dAtGk5kVubyfDR6v39lRVF1PqkAjKOkM1TIizYiDtQWyANZKzyXPCPXp4l5TYKrSstCF+lSU+pTvxjTuJgkOZxl8mhZL5SXmrnoa8CVYaJ6KXT5Cwn1e2+LlDY5BXvLmlh1Sw4as4Ae3FQk9sivVSa7L2xTHUp+nUT08iNNdxBxvy1p0sFNLFfqZtnExCKOjO1AZ+ixzAyd8ie2/62H71q7nVK7uMYIbG3xSP9LOD3N8bkXzi9D7xFeIQ3CmUXWesfDtke03vxA4NFYjhsqScJI67AyTiTULPtii8ZEXYRP4pT3RTU+C6EXlSHWllTLbtM782sQQm+gMvQCK1V2lhrR6WzHLSn6v9yJRlRn6Tctf6nrFFIbpdpQSnljxRNzQl89Qvx/Wki7DBgQAKiVi427CFy6Jx1Vz2cMiwaXDH2L1i1UOKIugWkuDy44cdZWpN4c6prctdwiOf8xgjfZARDh4oCspi+wDpSoOh3/xZMa/STu6kMExsMWHZy7RlrNqY0yBFufacA5z75EdD6sGZ9ZZNeHE99jE73O/DIDoAnxjNjju4dLaKFd7D2pp94ukBXjMEHhVHg87APEa801EvM3m/UhfvWpfC4bMO5dWPpWPriLCZPnzJL04GsdH1wBBkCUm7yrogjQjiQxEqbGlyTCoZLF/ejgZQCoh2VO9ot9u3t4n7TmMVkY/Ej/QElwhug/iYikalVNYJy/xkadSb23WEWVo9bRmAoydH8//8cMcnPD0cMGKwjP93iyfXgwFLvhvqzI=";
}

protocol ChirpProtocol {
    func setColor(_ color:String)
    func openUrl(_ url:String)
    func errorHandling(_ error:String)
}

extension ChirpProtocol{
    
    func setColor(_ color:String){
        
    }
    
    func openUrl(_ url:String){
        
    }
    
    func errorHandling(_ error:String){
        
    }
}

class ChirpManager{
    
    var chirp: ChirpSDK?
    var delegate: ChirpProtocol?
    
    init() {
        chirp = ChirpSDK(appKey: ChirpConstants.CHIRP_APP_KEY, andSecret: ChirpConstants.CHIRP_APP_SECRET)!
        
        if chirp!.setConfig(ChirpConstants.CHIRP_APP_CONFIG) != nil {
            chirp = nil
        } else {
            if chirp!.start() != nil {
                chirp = nil
            }
        }
        
        chirp!.receivedBlock = {
            (data : Data?, channel: UInt?) -> () in
            if data != nil {
                let identifier = String(data: data!, encoding: .ascii)
                print("Received \(identifier!)")
                if self.verifyUrl(urlString: identifier!){
                    self.delegate?.openUrl(identifier!)
                }
                else{
                    self.delegate?.setColor(identifier!)
                }
    
                return
            } else {
                print("ChirpError: Decode failed!")
                return
            }
        }
    }
    
    func send(_ string:String) -> Void {
        
        let payload: Data = string.data(using: .utf8)!
        if let err = chirp!.send(payload) {
            self.delegate?.errorHandling(err.localizedDescription)
            print("ChirpError (%@)", err.localizedDescription)
        } else {
            print("Sent (identifier)")
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
    
}
