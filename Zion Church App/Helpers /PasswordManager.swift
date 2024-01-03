//
//  PasswordManager.swift
//  Zion Church App
//
//  Created by John-Mark Iliev on 25.12.23.
//

import Foundation


struct PasswordManager {
    
   static func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
