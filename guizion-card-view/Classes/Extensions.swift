//
//  Extensions.swift
//  Pods
//
//  Created by Lucas Paim on 09/07/16.
//
//

import Foundation


extension UIImage {
    static func loadImageFromPodBundle(imageName: String) -> UIImage? {
        let podBundle = NSBundle(forClass: CardView.self)
        if let url = podBundle.URLForResource("GuizionCardViewBundle", withExtension: "bundle") {
            let bundle = NSBundle(URL: url)
            return UIImage(named: imageName, inBundle: bundle, compatibleWithTraitCollection: nil)
        }
        return nil
    }
}