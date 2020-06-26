//
//  StorageService.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/25/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation
import FirebaseStorage

struct StorageService {
    
    //function to take in a UIImage and upload its data to FirebaseStorage
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        //change UI image to data and reduce quality of image
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return completion(nil)
        }
        
        //upload image data to the path provided as a parameter
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                //return url reference to the completion handler
                completion(url)
            })
        })
        
    }
}




