//  PinterestLayout.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import UIKit

protocol PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
    
    var delegate: PinterestLayoutDelegate!
    
    var numberOfColumns = 1
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat = 0
    
    private var width: CGFloat {
        get {
            return CGRectGetWidth(collectionView!.bounds)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepare() {
        if cache.isEmpty {
            let columntWidth = width / CGFloat(numberOfColumns)
            
            var xOffsets = [CGFloat]()
            
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columntWidth)
            }
            
            var yOffests = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var column = 0
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = NSIndexPath(item: item, section: 0)
                
                let height = delegate.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath)
                
                let frame = CGRect(x: xOffsets[column], y: yOffests[column], width: columntWidth, height: height)
                
                //?
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                attributes.frame = frame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                
                yOffests[column] = yOffests[column] + height
                
                if column >= (numberOfColumns - 1) {
                    column = 0
                } else {
                    column += 1
                }
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }

}
