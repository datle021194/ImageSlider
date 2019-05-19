//
//  SimpleImageSlider.swift
//  CustomViews
//
//  Created by Dat Le on 5/19/19.
//  Copyright © 2019 Dat Le. All rights reserved.
//

import UIKit

class SimpleImageSlider: UIViewController {
    
    @IBOutlet weak var pagerView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    
    lazy var images: [String] = []
    var indicatorColor: UIColor?
    var currentIndicatorColor: UIColor?
    
    private var pagerVC: UIPageViewController!
    private var pageIndicatorView: PageIndicatorView!
    
    private lazy var indexWillTranslateTo = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPagerVC()
        self.setupIndicatorView()
    }
    
    // MARK: - Setup UI
    
    private func setupPagerVC() {
        pagerVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pagerVC.dataSource = self
        pagerVC.delegate = self
        
        guard let startPageItem = self.viewController(at: 0) else { return }
        
        self.pagerVC.setViewControllers([startPageItem], direction: .forward, animated: false, completion: nil)
        self.pagerVC.view.frame = self.pagerView.bounds
        
        self.addChild(self.pagerVC)
        self.pagerView.addSubview(self.pagerVC.view)
        self.pagerVC.didMove(toParent: self)
    }
    
    private func setupIndicatorView() {
        self.pageIndicatorView = PageIndicatorView(frame: self.indicatorView.bounds, numberOfIndicator: self.images.count)
        
        if self.indicatorColor != nil {
            self.pageIndicatorView.setIndicatorColor(self.indicatorColor!)
        }
        
        if self.currentIndicatorColor != nil {
            self.pageIndicatorView.setCurrentIndicatorColor(self.currentIndicatorColor!)
        }
        
        self.indicatorView.addSubview(self.pageIndicatorView)
    }
    
    // MARK: - Private
    
    private func viewController(at index: Int) -> PageItemVC? {
        let imagesCount = images.count
        
        if imagesCount == 0 || index >= imagesCount { return nil }
        
        let pageItemVC = PageItemVC()
        pageItemVC.pageIndex = index
        pageItemVC.imageString = images[index]
        
        return pageItemVC
    }
}

extension SimpleImageSlider: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageItemVC).pageIndex
        
        if index == 0 || index == NSNotFound { return nil }
        
        index -= 1
        
        return self.viewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageItemVC).pageIndex
        
        guard index != NSNotFound else { return nil }
        
        index += 1
        
        guard index != self.images.count else { return nil }
        
        return self.viewController(at: index)
    }
}

extension SimpleImageSlider: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let pageItemVC = (pendingViewControllers.last as? PageItemVC) else { return }
        
        self.indexWillTranslateTo = pageItemVC.pageIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished && completed {
            
            guard self.indexWillTranslateTo >= 0 && self.indexWillTranslateTo < self.images.count else { return }
            
            self.pageIndicatorView.move(toIndex: self.indexWillTranslateTo)
        }
    }
}
