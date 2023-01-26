//
//  UIImage + CircledImage.swift
//  FirebaseChat
//
//  Created by TolBA on 21/01/23.
//  Copyright © 2023 TolBA. All rights reserved.
//

import UIKit

extension UIImage {
    private var isPortrait:  Bool    { return size.height > size.width }
    private var isLandscape: Bool    { return size.width > size.height }
    private var breadth:     CGFloat { return min(size.width, size.height) }
    private var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    private var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
