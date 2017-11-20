//
//  creatingnewpassword.swift
//  screens design
//
//  Created by chakravarthy on 18/11/17.
//  Copyright © 2017 chakravarthy. All rights reserved.
//

import Foundation
import UIKit
class creatingnewpassword: UIViewController {
    override func viewDidLoad() {
        super .viewDidLoad()
        view.addBackground()
        
        // 2- this will add it with the edited imageName and default contextMode
        view.addBackground(imageName: "background3.png")
        
        // 3- this will add it with the default imageName and edited contextMode
        view.addBackground(contextMode: .scaleAspectFit)
        
        // 4- this will add it with the default imageName and edited contextMode
        view.addBackground(imageName: "background3.png", contextMode: .scaleAspectFit)
        
        
    }
}

