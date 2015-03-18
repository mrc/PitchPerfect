//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Matt Curtis on 16/03/2015.
//  Copyright (c) 2015 Matt Curtis. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    init(title: String, url: NSURL!) {
        self.title = title
        self.filePathUrl = url
    }
    
    var filePathUrl: NSURL!
    var title: String!
}
