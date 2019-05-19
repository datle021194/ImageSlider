//
//  PageIndicatorView.swift
//  EnglishEveryday
//
//  Created by Dat on 4/7/17.
//  Copyright © 2017 Dat. All rights reserved.
//

import UIKit

class PageIndicatorView: UIView {
    
    private var size = CGSize(width: 9, height: 9)
    private var currentSize = CGSize(width: 13, height: 13)
    private var scrollView: UIScrollView!
    private var currentIndicator: UIView!
    private var currentIndex = 0
    private var padding:CGFloat = 20
    private var numberOfIndicator = 0
    
    private let color = UIColor.lightGray
    private let currentColor = UIColor.black
    
    init(frame: CGRect, numberOfIndicator: Int) {
        super.init(frame: frame)
        self.numberOfIndicator = numberOfIndicator
        if self.numberOfIndicator > 0 {
            self.setupIndicator()
            self.setupCurrentIndicator()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - SETUP
    
    private func setupIndicator() {
        self.scrollView = UIScrollView(frame: self.bounds)
        self.addSubview(self.scrollView)
        
        var x = self.size.width * CGFloat(self.numberOfIndicator) + CGFloat((self.padding * (CGFloat(self.numberOfIndicator - 1))))
        x = (self.frame.size.width - x) / 2
        
        let y = self.frame.size.height / 2 - (self.size.height / 2)
        
        for i in 1...self.numberOfIndicator {
            let indicator = UIView(frame: CGRect(x: x, y: y, width: self.size.width, height: self.size.height))
            indicator.tag = i
            indicator.backgroundColor = self.color
            indicator.layer.cornerRadius = self.size.width / 2
            self.scrollView.addSubview(indicator)
            
            x += self.size.width + self.padding
        }
    }
    
    private func setupCurrentIndicator() {
        self.currentIndicator = UIView(frame: CGRect(x: 0, y: 0, width: self.currentSize.width, height: self.currentSize.height))
        self.currentIndicator.layer.cornerRadius = self.currentSize.width / 2
        self.currentIndicator.backgroundColor = self.currentColor
        self.scrollView.addSubview(self.currentIndicator)
        
        let y = self.frame.size.height / 2 - (self.currentSize.height / 2)
        let x = self.scrollView.viewWithTag(1)!.frame.origin.x - ((self.currentSize.width - self.size.width) / 2)
        
        self.currentIndicator.frame = CGRect(x: x, y: y,
                                             width: self.currentIndicator.frame.size.width,
                                             height: self.currentIndicator.frame.size.height)
    }
    
    // MARK: - PUBLIC
    
    func setIndicatorColor(_ color: UIColor)  {
        for i in 1...self.numberOfIndicator {
            self.scrollView.viewWithTag(i)?.backgroundColor = color
        }
    }
    
    func setCurrentIndicatorColor(_ color: UIColor)  {
        self.currentIndicator.backgroundColor = color
    }
    
    func move(toIndex: Int) {
        let tag = toIndex + 1
        let x = self.scrollView.viewWithTag(tag)!.frame.origin.x - ((self.currentSize.width - self.size.width) / 2)
        UIView.animate(withDuration: 0.1, animations: {
            self.currentIndicator.frame = CGRect(x: x, y: self.currentIndicator.frame.origin.y,
                                                 width: self.currentIndicator.frame.size.width,
                                                 height: self.currentIndicator.frame.size.height)
        })
    }
    
}
