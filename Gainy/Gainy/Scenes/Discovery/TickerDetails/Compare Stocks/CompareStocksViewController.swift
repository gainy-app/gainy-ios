//
//  CompareStocksViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 03.09.2021.
//

import UIKit
import PureLayout

final class CompareStocksViewController: BaseViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var topStockFld: UITextField! {
        didSet {
            topStockFld.layer.borderWidth = 1.0
            topStockFld.layer.borderColor = UIColor(hexString: "B1BDC8")!.cgColor
            topStockFld.layer.cornerRadius = 8.0
            topStockFld.leftView = UIView(frame: .init(x: 0, y: 0, width: 12, height: 20))
            topStockFld.leftViewMode = .always
            
            let btnView = UIView(frame: .init(x: 0, y: 0, width: 20 + 12, height: 20))
            let btn = ResponsiveButton()
            btn.setImage(UIImage(named: "compare_field_eye"), for: .normal)
            btn.setImage(UIImage(named: "compare_field_eye"), for: .selected)
            btn.addTarget(self, action: #selector(stockVisabilityTapped(_:)), for: .touchUpInside)
            btn.tag = 0
            btnView.addSubview(btn)
            btn.frame = .init(x: 0, y: 0, width: 20, height: 20)
            
            topStockFld.rightView = btnView
            topStockFld.rightViewMode = .always
        }
    }
    @IBOutlet weak var bottomStockFld: UITextField! {
        didSet {
            bottomStockFld.layer.borderWidth = 1.0
            bottomStockFld.layer.borderColor = UIColor(hexString: "B1BDC8")!.cgColor
            bottomStockFld.layer.cornerRadius = 8.0
            bottomStockFld.leftView = UIView(frame: .init(x: 0, y: 0, width: 12, height: 20))
            bottomStockFld.leftViewMode = .always
            
            let btnView = UIView(frame: .init(x: 0, y: 0, width: 20 + 12, height: 20))
            let btn = ResponsiveButton()
            btn.setImage(UIImage(named: "compare_field_eye"), for: .normal)
            btn.setImage(UIImage(named: "compare_field_eye"), for: .selected)
            btn.addTarget(self, action: #selector(stockVisabilityTapped(_:)), for: .touchUpInside)
            btn.tag = 0
            btnView.addSubview(btn)
            btn.frame = .init(x: 0, y: 0, width: 20, height: 20)
            
            bottomStockFld.rightView = btnView
            bottomStockFld.rightViewMode = .always
        }
    }
    
    @IBOutlet weak var chartContainer: UIView!
    
    //MARK: - Fields
    
    var stocks: [SearchTickersQuery.Data.Ticker] = []
    
    var topStock: SearchTickersQuery.Data.Ticker? {
        didSet {
            guard let topStock = topStock else {return}
            topStockFld.text = topStock.name
        }
    }
    
    var bottomStock: SearchTickersQuery.Data.Ticker? {
        didSet {
            guard let bottomStock = bottomStock else {return}
            bottomStockFld.text = bottomStock.name
        }
    }
    
    //MARK: - Hosting controllers
    
    static let hostingTag: Int = 7
    
    /// Actual data for charts
    private let chartViewModel = CompareScatterChartViewModel(comparableStocks: [])
    private var chartView: CompareScatterChartView?
    
    private lazy var chartHosting: CustomHostingController<CompareScatterChartView> = {
        var rootView = CompareScatterChartView(viewModel: chartViewModel, delegate: chartDelegate)
        let chartHosting = CustomHostingController(shouldShowNavigationBar: false, rootView: rootView)
        chartHosting.view.tag = TickerDetailsDataSource.hostingTag
        chartView = rootView
        return chartHosting
    }()
    
    private lazy var chartDelegate: ScatterChartDelegate = {
        let delegateObject =  ScatterChartDelegate()
        delegateObject.delegate = self
        return delegateObject
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChart()
    }
    
    private func addChart() {
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        
        chartContainer.addSubview(chartHosting.view)
        chartHosting.view.frame = chartContainer.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadFirstStocks()
    }
    
    private func loadFirstStocks() {
        topStock = stocks.first!
        bottomStock = stocks.last!
        
        let statsPoints: [Double] = [18,54,23,32,42,37,7,53,63].shuffled()
        let medianPoints: [Double] = [8,54,23,32,12,37,7,23,43].shuffled()
        
        chartViewModel.comparableStocks = [ChartCompareData.init(symbol: topStock?.symbol ?? "",
                                                                  growth: topStock?.tickerFinancials.last?.priceChangeToday ?? 0.0),
                                            ChartCompareData.init(symbol: bottomStock?.symbol ?? "",
                                                                  growth: bottomStock?.tickerFinancials.last?.priceChangeToday ?? 0.0)
         ]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()        
        chartHosting.view.frame = chartContainer.bounds
    }
    
    //MARK: - Actions
    
    @objc func stockVisabilityTapped(_ sender: ResponsiveButton) {
        if sender.tag == 0 {
            
        } else {
            
        }
    }
}

extension CompareStocksViewController: ScatterChartViewDelegate {
    func chartPeriodChanged(period: ScatterChartView.ChartPeriod) {
        
    } 
}
