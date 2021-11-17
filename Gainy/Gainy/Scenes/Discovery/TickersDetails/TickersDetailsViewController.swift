//
//  TickersDetailsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.11.2021.
//

import UIKit

final class TickersDetailsViewController: UIPageViewController, Storyboarded {
    
    
    var stockControllers: [UIViewController] = []
    
    var initialIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewControllers([stockControllers[initialIndex]], direction: .forward, animated: false, completion: nil)
        if let tickerVC = stockControllers[initialIndex] as? TickerViewController {
            tickerVC.loadTicketInfo()
        }
    }
    
}

extension TickersDetailsViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = stockControllers.firstIndex(of: viewController) else {
                return nil
            }

            let previousIndex = viewControllerIndex - 1

            guard previousIndex >= 0 else {
                return nil
            }

            guard stockControllers.count > previousIndex else {
                return nil
            }

            return stockControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = stockControllers.firstIndex(of: viewController) else {
                return nil
            }

            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = stockControllers.count

            guard orderedViewControllersCount != nextIndex else {
                return nil
            }

            guard orderedViewControllersCount > nextIndex else {
                return nil
            }

            return stockControllers[nextIndex]
    }
}

extension TickersDetailsViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool){
        let pageContentViewController = pageViewController.viewControllers![0] as! TickerViewController
        pageContentViewController.loadTicketInfo()
    }
}
