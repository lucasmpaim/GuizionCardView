//
//  Extensions.swift
//  Pods
//
//  Created by Lucas Paim on 09/07/16.
//
//

import Foundation


extension UIImage {
    static func loadImageFromPodBundle(_ imageName: String) -> UIImage? {
        let podBundle = Bundle(for: CardView.self)
        if let url = podBundle.url(forResource: "GuizionCardViewBundle", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIImage(named: imageName, in: bundle, compatibleWith: nil)
        }
        return nil
    }
}
