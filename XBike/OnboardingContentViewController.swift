//
//  OnboardingContentViewController.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import UIKit

class OnboardingContentViewController: UIViewController {

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
    
    var index = 0
    var heading = ""
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTextLabel()
        contentImageView.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupTextLabel() {
        
        titleLabel.text = heading
        
    }
}


