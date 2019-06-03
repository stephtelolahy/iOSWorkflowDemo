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
    
    private lazy var items: [UIViewController] = {
        let colors: [UIColor] = [.red, .green, .blue, .orange]
        return colors.map { createStepviewController(with: $0) }
    }()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        add(asChildViewController: pageViewController, in: containerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigateToStep(index: currentIndex, animated: false)
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
    
    func createStepviewController(with color: UIColor) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = color
        return viewController
    }
    
    func navigateToStep(index: Int, animated: Bool) {
        title = "Step \(index + 1)/\(items.count)"
        let direction: UIPageViewController.NavigationDirection = currentIndex > index ? .reverse : .forward
        pageViewController.setViewControllers([items[index]], direction: direction, animated: animated)
        pageControl.currentPage = index
        currentIndex = index
    }
}

extension UIViewController {
    func add(asChildViewController viewController: UIViewController, in containerView: UIView) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
}
