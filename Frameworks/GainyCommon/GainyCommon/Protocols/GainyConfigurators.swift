//
//  GainyConfigurators.swift
//  GainyCommon
//
//  Created by Евгений Таран on 10.11.22.
//

import UIKit

/// Конфигуратор ячейки списка
public protocol ListCellConfiguration: AnyObject {
    /// Идентификатор ячейки. Он будет использоваться в качестве id для переиспользуемой ячейки
    var cellIdentifier: String { get }
    
    /// Метод установки ячейки
    func setupCell(_ cell: UIView, isSkeletonable: Bool)
    
    /// Метод, которые вызывается при нажатии на кнопку
    func didTapCell()
    
    /// Метод подготовки данных. Реализуется только в случае использования Prefetching API
    func prepareData()
    
    /// Метод отмены подготовки данных. Реализуется только в случае использования Prefetching API
    func cancelPreparingData()
    
    /// Метод для вычисления размера ячейки
    /// - Parameter viewSize: вспомогательные размеры для вычисления размеров ячейки
    func getCellSize(viewSize: CGSize?) -> CGSize
}

extension ListCellConfiguration {
    func didTapCell() { }
    func prepareData() { }
    func cancelPreparingData() { }
    func getCellSize(viewSize: CGSize?) -> CGSize { return .zero }
}

/// Конфигуратор ячейки списка
public protocol ListCellConfigurationWithCallBacks: AnyObject {
    /// Идентификатор ячейки. Он будет использоваться в качестве id для переиспользуемой ячейки
    var cellIdentifier: String { get }
    
    /// var, которые вызывается при нажатии на кнопку
    var didTapCell: (() -> Void)? { get set }
    
    /// Метод  установки ячейки
    func setupCell(_ cell: UIView, isSkeletonable: Bool)
    
    /// Callback подготовки данных. Реализуется только в случае использования Prefetching API
    var prepareData: (() -> Void)? { get set }
    
    /// Callback отмены подготовки данных. Реализуется только в случае использования Prefetching API
    var cancelPreparingData: (() -> Void)? { get set }
    
    /// Метод для вычисления размера ячейки
    /// - Parameter viewSize: вспомогательные размеры для вычисления размеров ячейки
    var getCellSize: ((_ viewSize: CGSize?) -> CGSize)? { get set }
}

extension ListCellConfigurationWithCallBacks {
    var didTapCell: (() -> Void)? { nil }
    var prepareData: (() -> Void)? { nil }
    var cancelPreparingData: (() -> Void)? { nil }
    var getCellSize: ((_ viewSize: CGSize?) -> CGSize)? { nil }
}

