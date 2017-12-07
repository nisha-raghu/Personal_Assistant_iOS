//
//  Assistance.swift
//  PersonalAssistant
//
//  Created by Mohamad Khan on 11/25/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import Foundation

struct Assistance {
    private(set) public var title: String
    private(set) public var imageName: String
    
    init (title: String, imageName: String){
        self.title = title
        self.imageName = imageName
    }
}
