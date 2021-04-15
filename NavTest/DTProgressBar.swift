//
//  DTProgressBar.swift
//  NavTest
//
//  Created by Alex on 13/04/21.
//

import UIKit

typealias DTProgressNavigationBarBlock = (_ color: UIColor, _ alpha: CGFloat) -> Void

class DTProgressNavigationBar: UINavigationBar {
    
    static let height: CGFloat = 46
    
    var block: DTProgressNavigationBarBlock? = nil
        
    private var largeHeight: CGFloat = -1
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard self.largeHeight < 0 else {
            return
        }
        
        self.shadowImage = UIImage()

        for sub in self.subviews {
            if "\(type(of: sub))".contains("Large") {
                sub.tag = 1002
                sub.addObserver(self, forKeyPath: "frame", options: [.new], context: nil)
                self.largeHeight = sub.frame.height
            }
            if "\(type(of: sub))".contains("Content") {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let text = sub.subviews.first as? UILabel {
                        text.addObserver(self, forKeyPath: "alpha", options: [.new], context: nil)
                    }
                }
            }
            
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let block = self.block else {
            return
        }
        
        guard let largeView = self.viewWithTag(1002) else {
            return
        }
        
        guard keyPath == "frame" else {
            if largeView.frame.height < DTProgressNavigationBar.height/2 {
                block(UIColor(white: 0.97, alpha: 1), 1)
                self.backgroundColor = UIColor(white: 0.97, alpha: 1)
            }
            return
        }
        
        guard let change = change, let rect = change[.newKey] as? CGRect else {
            return
        }
        
        let diff = (self.largeHeight - rect.size.height) / self.largeHeight
        
        let percent = 1 - 0.03 * diff
        let color = UIColor(white: percent, alpha: 1)
        
        self.backgroundColor = color
        
        block(color, diff)

    }
    
}
