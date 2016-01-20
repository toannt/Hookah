//
//  String.swift
//  Hookah
//
//  Created by baga on 1/20/16.
//  Copyright © 2016 Khoi Lai. All rights reserved.
//

import Foundation

extension Hookah{
    
    /**
     Return the number of characters in a String
    
     - parameter string: The String to count
     
     - returns: The number of characters in String
     */
    public class func size(string: String) -> Int{
        return string.characters.count
    }
}