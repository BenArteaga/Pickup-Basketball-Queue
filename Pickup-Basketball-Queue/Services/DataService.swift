//
//  DataService.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/22/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DataService {
    static let instance = DataService()
    
    
    func imageForPath(_ path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func documentsPathForFileName(_ name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.appendingPathComponent(name)
    }
}
