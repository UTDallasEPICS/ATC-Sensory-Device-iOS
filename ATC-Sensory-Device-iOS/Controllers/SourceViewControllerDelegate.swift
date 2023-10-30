//
//  SourceViewControllerDelegate.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/30/23.
//

import Foundation

protocol SourceViewControllerDelegate: AnyObject {
    func dataToPass(_ data: Float)
}
