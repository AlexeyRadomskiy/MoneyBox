//
//  PageViewController.swift
//  MoneyBox
//
//  Created by mac mini on 4/7/22.
//

import UIKit

class PageViewController: UIPageViewController {

    var slides = OnboardingSlide.getSlide()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let contentViewController = showViewControllerAtIndex(0) {
            setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> ContentViewController? {
        
        guard index >= 0 else { return nil }
        guard index < slides.count else { return nil }
        guard let contentViewController = storyboard?.instantiateViewController(
            withIdentifier: "ContentViewController") as? ContentViewController else { return nil }
        
        contentViewController.image = slides[index].image
        contentViewController.presentText = slides[index].title
        contentViewController.currentPage = index
        contentViewController.numberOfPage = slides.count
        
        return contentViewController
    }
}

//MARK: - UIPageControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber -= 1
        return showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber += 1
        return showViewControllerAtIndex(pageNumber)
    }
    
    
}
