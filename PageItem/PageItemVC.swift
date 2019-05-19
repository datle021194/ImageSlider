//
//  PageItemVC.swift
//  CustomViews
//
//  Created by Dat Le on 5/19/19.
//  Copyright © 2019 Dat Le. All rights reserved.
//

import UIKit

class PageItemVC: UIViewController {

    @IBOutlet weak var itemImageView: UIImageView!
    
    lazy var pageIndex = 0
    lazy var imageString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showImage()
    }
    
    // MARK: - Private
    
    private func showImage() {
        self.itemImageView.image = UIImage(named: imageString)
    }
    
//    // MARK: - Public
//
//    func showImage(_ image: String) {
//        self.itemImageView.image = UIImage(named: image)
//    }
}
