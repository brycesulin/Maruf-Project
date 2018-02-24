//
//  ProjectAbout.swift
//  Maruf
//
//  Created by Bryce Sulin on 10/12/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import Foundation

protocol ProjectAbout {
    
    var projectTitle: String? {get set}
    var projectDescription: String? {get set}
    var projectAbout: String? {get set}
    
    func save ()

}

