//
//  OnboardingPageViewController.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import UIKit

protocol onboardingPageViewControllerDelegate: AnyObject {
    func setupPageController(numberOfPage: Int)
    func turnPageController(to index: Int)
}

class OnboardingPageViewController: UIPageViewController {
 
    weak var pageViewControllerDelagate: onboardingPageViewControllerDelegate?

    var pageTitle = ["Extremely simple to use", "Track your time and distance", "See your progress and challenge yourself!"]
    var pageImages : [UIImage?] = [UIImage(named: "onboard1"), UIImage(named: "onboard2"), UIImage(named: "onboard3")]
    var currentIndex = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        dataSource = self
        delegate = self
        if let firstViewController = contentViewController(at: 0) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func turnPage(to index: Int) {
        currentIndex = index
        if let currentController = contentViewController(at: index) {
            setViewControllers([currentController], direction: .forward, animated: true)
            self.pageViewControllerDelagate?.turnPageController(to: currentIndex)
        }
    }

}

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if var index = (viewController as? OnboardingContentViewController)?.index {
            index -= 1
            return contentViewController(at: index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if var index = (viewController as? OnboardingContentViewController)?.index {
            index += 1
            return contentViewController(at: index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if let pageContentViewController = pageViewController.viewControllers?.first as? OnboardingContentViewController {
            currentIndex = pageContentViewController.index
            self.pageViewControllerDelagate?.turnPageController(to: currentIndex)
        }
    }
    
    func contentViewController(at index: Int) -> OnboardingContentViewController? {
        if index < 0 || index >= pageTitle.count {
            return nil
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let pageContentViewController = storyBoard.instantiateViewController(withIdentifier: "onboardingContentVC") as? OnboardingContentViewController {
            pageContentViewController.image = pageImages[index] ?? UIImage()
            pageContentViewController.heading = pageTitle[index]
            pageContentViewController.index = index
            self.pageViewControllerDelagate?.setupPageController(numberOfPage: 3)
            return pageContentViewController
        }
        return nil
    }
}

