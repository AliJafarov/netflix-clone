//
//  Extensions.swift
//  NetflixCloneApp
//
//  Created by Ali Jafarov on 07.04.22.
//

import Foundation


extension String {
    
    func capitalizedLetters() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
