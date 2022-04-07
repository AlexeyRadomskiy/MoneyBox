//
//  ContentViewController.swift
//  MoneyBox
//
//  Created by mac mini on 4/7/22.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var presentText = ""
    var image: UIImage!
    var currentPage = 0
    var numberOfPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentPage + 1 == numberOfPage {
            startButton.isHidden = false
        } else {
            startButton.isHidden = true
        }
        
        startButton.layer.cornerRadius = 10

        imageView.image = image
        textLabel.text = presentText
        pageControl.numberOfPages = numberOfPage
        pageControl.currentPage = currentPage
    }

}
