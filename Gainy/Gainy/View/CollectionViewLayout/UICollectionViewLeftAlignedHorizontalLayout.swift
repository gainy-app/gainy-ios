//
//  UICollectionViewLeftAlignedHorizontalLayout.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/28/21.
//

import UIKit

public protocol UICollectionViewLeftAlignedHorizontalLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}

open class UICollectionViewLeftAlignedHorizontalLayout: UICollectionViewFlowLayout {
    
    public weak var delegate: UICollectionViewLeftAlignedHorizontalLayoutDelegate?
    
    public var maxNumberOfRows: Int = 3
        
    public var numberOfRows: Int {
        get {
            guard let collectionView = self.collectionView else {
                return 0
            }
            
            let numberOfItems = collectionView.numberOfItems(inSection: 0)
            if numberOfItems >= maxNumberOfRows {
                return maxNumberOfRows
            } else {
                return numberOfItems
            }
        }
    }
    
    private var layoutAttributes: [UICollectionViewLayoutAttributes]?
    private var contentSize: CGSize = CGSize.zero
    open override var collectionViewContentSize: CGSize {
        get {
            return self.contentSize
        }
    }
    
    open override func prepare() {
        
        guard let delegate = self.delegate, numberOfRows > 0 else {
            return
        }
        guard let collectionView = self.collectionView else {
            return
        }
        
        var sectionItemsAttributes: [UICollectionViewLayoutAttributes] = Array()
        let verticalInset = collectionView.contentInset.top + collectionView.contentInset.bottom
        
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let contentHeight = collectionView.bounds.height - verticalInset
        var contentWidth = 0.0
        let rowHeight = contentHeight / (CGFloat)(self.numberOfRows)
        
        var xOffset: [CGFloat] = Array()
        var yOffset: [CGFloat] = Array()
        
        for i in 0..<numberOfRows {
            yOffset.append(CGFloat(i) * rowHeight)
            xOffset.append(CGFloat(17.0))
        }
        
        var currentRow = 0;
        for i in 0..<numberOfItems {
            let indexPath = IndexPath(item: i, section: 0)
            let size = delegate.collectionView(collectionView, layout: self, sizeForItemAt: indexPath)
            let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let width = size.width
            let frame = CGRect(x: CGFloat(xOffset[currentRow]), y: CGFloat(yOffset[currentRow]), width: width, height: size.height)
            itemAttributes.frame = frame;
            sectionItemsAttributes.append(itemAttributes)
            contentWidth = max(contentWidth, frame.maxX);
            xOffset[currentRow] = CGFloat(xOffset[currentRow] + width + self.minimumInteritemSpacing);
            currentRow = currentRow < (self.numberOfRows - 1) ? (currentRow + 1) : 0;
        }
        
        contentWidth += 17.0;
        self.contentSize = CGSize(width: contentWidth, height: contentHeight);
        self.layoutAttributes = sectionItemsAttributes;
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let layoutAttributes = self.layoutAttributes else {
            return super.layoutAttributesForItem(at: indexPath)
        }
        
        var result: UICollectionViewLayoutAttributes? = nil
        if indexPath.item < layoutAttributes.count {
            let attributes: UICollectionViewLayoutAttributes? = (indexPath.item < layoutAttributes.count) ? layoutAttributes[indexPath.item] : nil;
            result = attributes;
        }
        if result == nil {
            return super.layoutAttributesForItem(at: indexPath)
        }
        
        return result;
        
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attributesArray: [UICollectionViewLayoutAttributes]? = nil
        guard let layoutAttributes = self.layoutAttributes else {
            return super.layoutAttributesForElements(in: rect)
        }
        
        attributesArray = layoutAttributes.filter { attributes in
            return attributes.frame.intersects(rect)
        }
        return attributesArray
    }
}
