//
//  image.swift
//  Project1
//
//  Created by Gabriel Lops on 12/24/19.
//  Copyright © 2019 Gabriel Lops. All rights reserved.
//

import UIKit

class Photo: NSObject, Codable {
    var name = String()
    var views = Int()
    
    init(name: String, views: Int) {
        self.views = views
        self.name = name
    }

}
