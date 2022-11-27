//
//  UICollectionViewCenterAlignedLayout.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/31/21.
//

import UIKit

/**
 *  Simple UICollectionViewFlowLayout that centers the cells rather than justify them
 *
 *  Based on https://github.com/Coeur/UICollectionViewLeftAlignedLayout
 */
open class UICollectionViewCenterAlignedLayout: UICollectionViewFlowLayout {
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributesForElements = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        guard let collectionView = collectionView else {
            return layoutAttributesForElements
        }
        // we group copies of the elements from the same row/column
        var representedElements: [UICollectionViewLayoutAttributes] = []
        var cells: [[UICollectionViewLayoutAttributes]] = [[]]
        var previousFrame: CGRect?
        if scrollDirection == .vertical {
            for layoutAttributes in layoutAttributesForElements {
                guard layoutAttributes.representedElementKind == nil else {
                    representedElements.append(layoutAttributes)
                    continue
                }
                // copying is required to avoid "UICollectionViewFlowLayout cache mismatched frame"
                let currentItemAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
                // if the current frame, once stretched to the full row doesn't intersect the previous frame then they are on different rows
                if previousFrame != nil && !currentItemAttributes.frame.intersects(CGRect(x: -.greatestFiniteMagnitude, y: previousFrame!.origin.y, width: .infinity, height: previousFrame!.size.height)) {
                    cells.append([])
                }
                cells[cells.endIndex - 1].append(currentItemAttributes)
                previousFrame = currentItemAttributes.frame
            }
            let additionalElements: [UICollectionViewLayoutAttributes] = cells.flatMap { group -> [UICollectionViewLayoutAttributes] in
                guard let section = group.first?.indexPath.section as? Int else {
                    return group
                }
                let evaluatedSectionInset = evaluatedSectionInsetForSection(at: section)
                let evaluatedMinimumInteritemSpacing = evaluatedMinimumInteritemSpacingForSection(at: section)
                let firstPart = collectionView.bounds.width + evaluatedSectionInset.left - evaluatedSectionInset.right
                let secondPart = group.reduce(0, { $0 + $1.frame.size.width })
                let lastPart = CGFloat(group.count - 1) * evaluatedMinimumInteritemSpacing
                var origin = (firstPart - secondPart - lastPart) / 2
                // we reposition each element of a group
                return group.map {
                    $0.frame.origin.x = origin
                    origin += $0.frame.size.width + evaluatedMinimumInteritemSpacing
                    return $0
                }
            }
            // we reposition all elements
            return representedElements + additionalElements
        } else {
            for layoutAttributes in layoutAttributesForElements {
                guard layoutAttributes.representedElementKind == nil else {
                    representedElements.append(layoutAttributes)
                    continue
                }
                // copying is required to avoid "UICollectionViewFlowLayout cache mismatched frame"
                let currentItemAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
                // if the current frame, once stretched to the full column doesn't intersect the previous frame then they are on different columns
                if previousFrame != nil && !currentItemAttributes.frame.intersects(CGRect(x: previousFrame!.origin.x, y: -.greatestFiniteMagnitude, width: previousFrame!.size.width, height: .infinity)) {
                    cells.append([])
                }
                cells[cells.endIndex - 1].append(currentItemAttributes)
                previousFrame = currentItemAttributes.frame
            }
            let additionalElements: [UICollectionViewLayoutAttributes] = cells.flatMap { group -> [UICollectionViewLayoutAttributes] in
                guard let section = group.first?.indexPath.section as? Int else {
                    return group
                }
                let evaluatedSectionInset = evaluatedSectionInsetForSection(at: section)
                let evaluatedMinimumInteritemSpacing = evaluatedMinimumInteritemSpacingForSection(at: section)
                let firstPart = collectionView.bounds.height + evaluatedSectionInset.top - evaluatedSectionInset.bottom
                let secondPart = group.reduce(0, { $0 + $1.frame.size.height })
                let lastPart = CGFloat(group.count - 1) * evaluatedMinimumInteritemSpacing
                var origin = (firstPart - secondPart - lastPart) / 2
                // we reposition each element of a group
                return group.map {
                    $0.frame.origin.y = origin
                    origin += $0.frame.size.height + evaluatedMinimumInteritemSpacing
                    return $0
                }
            }
            // we reposition all elements
            return representedElements + additionalElements
        }
    }
}

extension UICollectionViewFlowLayout {
    internal func evaluatedSectionInsetForSection(at section: Int) -> UIEdgeInsets {
        return (collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView!, layout: self, insetForSectionAt: section) ?? sectionInset
    }
    internal func evaluatedMinimumInteritemSpacingForSection(at section: Int) -> CGFloat {
        return (collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView!, layout: self, minimumInteritemSpacingForSectionAt: section) ?? minimumInteritemSpacing
    }
}

