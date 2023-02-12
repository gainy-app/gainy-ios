//
//  TickersDetailsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.11.2021.
//

import UIKit
import GainyCommon
import SnapKit

final class TickersDetailsViewController: UIPageViewController, Storyboarded {
    
    
    var stockControllers: [UIViewController] = []
    
    var initialIndex: Int = 0
    
    //New top controls
    private var pageControl: GainyPageControl?
    private var wlBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        presentationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for vc in stockControllers {
            if let vc = vc as? TickerViewController {
                vc.delegate = self
                vc.isFromHome = true
            }
        }
        
        setViewControllers([stockControllers[initialIndex]], direction: .forward, animated: false, completion: nil)
        if let tickerVC = stockControllers[initialIndex] as? TickerViewController {
            tickerVC.loadTicketInfo(fromRefresh: false)
        }
        addControls()
    }
    
    private func addControls() {
        let count = stockControllers.count
        let pageControl = GainyPageControl.init(frame: CGRect.init(x: 24, y: 0, width: 200, height: 24), numberOfPages: count)
        pageControl.currentPage = initialIndex
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.hideForSinglePage = true
        self.view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.height.equalTo(24.0)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26.0)
        }
        
        pageControl.isHidden = count == 1
        
        self.pageControl = pageControl
        
        let closeBtn = UIButton(
            frame: CGRect(
                x: 16,
                y: 16,
                width: 32,
                height: 32
            )
        )
        closeBtn.setImage(UIImage(named: "iconClose"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeFromHomeAction), for: .touchUpInside)
        
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(32)
            make.left.equalTo(24)
            make.centerY.equalTo(pageControl.snp.centerY)
        }
        
        let addWlBtn = UIButton(
            frame: CGRect(
                x: 16,
                y: 16,
                width: 34,
                height: 34
            )
        )
        addWlBtn.setImage(UIImage(named: "add_coll_to_wl"), for: .normal)
        addWlBtn.setImage(UIImage(named: "remove_coll_from_wl"), for: .selected)
        addWlBtn.addTarget(self, action: #selector(addToWatchlistToggleAction(_:)), for: .touchUpInside)
        
        view.addSubview(addWlBtn)
        addWlBtn.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.right.equalTo(-16)
            make.centerY.equalTo(pageControl.snp.centerY)
        }
        wlBtn = addWlBtn
        updateWLBtn()
    }
    
    @objc private func closeFromHomeAction() {
        dismiss(animated: true)
    }
    
    @IBAction func addToWatchlistToggleAction(_ sender: UIButton) {
        
        guard let stockVC = (stockControllers[initialIndex] as? TickerViewController) else {
            return
        }
        
        let symbol = stockVC.symbol
        
        let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
            item == symbol
        }
        if addedToWatchlist {
            GainyAnalytics.logEvent("remove_from_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            UserProfileManager.shared.removeTickerFromWatchlist(symbol) { success in
                if success {
                    sender.isSelected = false
//                    guard let cell = self.viewModel?.dataSource.headerCell else {
//                        return
//                    }
//                    cell.updateAddToWatchlistToggle()
                    stockVC.modifyDelegate?.didModifyWatchlistTickers(isAdded: false, tickerSymbol: symbol)
                }
            }
        } else {
            GainyAnalytics.logEvent("add_to_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            UserProfileManager.shared.addTickerToWatchlist(symbol) { success in
                if success {
                    sender.isSelected = true
//                    guard let cell = self.viewModel?.dataSource.headerCell else {
//                        return
//                    }
//                    cell.updateAddToWatchlistToggle()
                    stockVC.modifyDelegate?.didModifyWatchlistTickers(isAdded: true, tickerSymbol: symbol)
                }
            }
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
        initialIndex = stockControllers.firstIndex(of: pageContentViewController) ?? 0
        pageControl?.currentPage = initialIndex
        updateWLBtn()
    }
    
    func updateWLBtn() {
        
        guard let symbol = (stockControllers[initialIndex] as? TickerViewController)?.symbol else {
                return
            }
        let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
            item == symbol
        }
        //Set top btn
        wlBtn?.isSelected = addedToWatchlist
    }
}
extension TickersDetailsViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return true
    }
}

extension TickersDetailsViewController: TickerViewControllerDelegate {
    
    func didUpdateTickerMetrics() {
        
        for vc in stockControllers {
            if let vc = vc as? TickerViewController {
                vc.viewModel?.dataSource.ticker.updateMarketData()
            }
        }
    }
}
