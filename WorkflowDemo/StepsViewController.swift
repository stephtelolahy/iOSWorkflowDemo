//
//  StepsViewController.swift
//  WorkflowDemo
//
//  Created by Hugues Stéphano TELOLAHY on 6/3/19.
//  Copyright © 2019 Hugues Stéphano TELOLAHY. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    private var pageViewController: UIPageViewController!
    
    private var items: [UIViewController]!
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        add(asChildViewController: pageViewController, containerView: containerView)
        populateItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigateToStep(index: 1, animated: false)
    }
    
    @IBAction func onCloseTapped(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    
    @IBAction func onPageControlValueChanged(_ sender: Any) {
        guard let index = (sender as? UIPageControl)?.currentPage else {
            return
        }
        navigateToStep(index: index, animated: true)
    }
}

private extension StepsViewController {
    
    func populateItems() {
        let colors: [UIColor] = [.red, .green, .blue, .orange]
        items = colors.map { createStepviewController(with: $0) }
        pageControl.numberOfPages = colors.count
    }
    
    func createStepviewController(with color: UIColor) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = color
        return viewController
    }
    
    func navigateToStep(index: Int, animated: Bool) {
        title = "Step \(index + 1)/\(items.count)"
        let direction: UIPageViewController.NavigationDirection = currentIndex < index ? .backWard: .forward
        pageViewController.setViewControllers([items[index]], direction: direction, animated: animated)
        pageControl.currentPage = index
        currentIndex = index
    }
}

extension UIViewController {
    func add(asChildViewController viewController: UIViewController, containerView: UIView) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
}
