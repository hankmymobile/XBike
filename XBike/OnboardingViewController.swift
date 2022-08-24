//
//  ViewController.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    weak var onBoardingPageViewController: OnboardingPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func skipButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.loadInit()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if (pageControl.currentPage + 1) == 3 {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.loadInit()
            return
        }
            
        onBoardingPageViewController?.turnPage(to: pageControl.currentPage + 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let onBoardingViewController = segue.destination as? OnboardingPageViewController {
            onBoardingViewController.pageViewControllerDelagate = self
            onBoardingPageViewController = onBoardingViewController
        }
    }
}

extension OnboardingViewController: onboardingPageViewControllerDelegate {

    func setupPageController(numberOfPage: Int) {
        pageControl.numberOfPages = numberOfPage
    }

    func turnPageController(to index: Int) {
        pageControl.currentPage = index
    }
}

