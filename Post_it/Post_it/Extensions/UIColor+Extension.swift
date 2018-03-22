//
//  UIColor+Extension.swift
//  Post_it
//
//  Created by Rei Yamaguchi on 2018/03/22.
//  Copyright © 2018年 hideandseek.inc. All rights reserved.
//

import UIKit

extension UIColor {
    convenience public init(rgba: Int64) {
        let r = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let g = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let b = CGFloat((rgba & 0x0000FF00) >>  8) / 255.0
        let a = CGFloat( rgba & 0x000000FF)        / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    class func keyColor() -> UIColor {
        return UIColor(rgba: 0x50E3C264)
    }
    
    class func border1() -> CGColor {
        return UIColor(rgba: 0xF02B5664).cgColor
    }
    
    class func border2() -> CGColor {
        return UIColor(rgba: 0xF8E71C64).cgColor
    }
    
    class func border3() -> CGColor {
        return UIColor(rgba: 0x29D00264).cgColor
    }
    
    class func border4() -> CGColor {
        return UIColor(rgba: 0x0275D064).cgColor
    }
    
    class func border5() -> CGColor {
        return UIColor(rgba: 0xBF1CF864).cgColor
    }
    
}
