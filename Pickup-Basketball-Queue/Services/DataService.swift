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

protocol DataServiceDelegate: class {
    func dataLoaded()
}

class DataService {
    static let instance = DataService()
    let ref = Firebase.Database.database().reference()
    var players: [Player] = []
    weak var delegate: DataServiceDelegate?
    
    func savePlayer(username: String?, imagePath: String?, queuePosition: Int?) {
        let key = ref.childByAutoId().key
        let player = ["player": username ?? "", "image": imagePath ?? "", "position": queuePosition ?? 0] as [String : Any]
        let playerUpdate = ["\(String(describing: key))": player]
        ref.updateChildValues(playerUpdate)
    }
    
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
    
    func saveImageAndCreatePath(_ image: UIImage) -> String {
        //turns image into data
        let imgData = image.pngData()
        //makes sure that each time we save an image it will have a unique path name
        let imgPath = "image\(Date.timeIntervalSinceReferenceDate).png"
        let fullPath = documentsPathForFileName(imgPath)
        //writes fullPath to disc
        try? imgData?.write(to: URL(fileURLWithPath: fullPath), options: [.atomic])
        //not sure why we are returning imgPath?
        return imgPath
    }
}
