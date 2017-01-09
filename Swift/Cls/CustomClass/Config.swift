//
//  MYHttp.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 07/11/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

struct WheelConfig {
    static var backWheelImage:UIImage?
}

extension MYHttpRequest {
    struct HttpConfig {
        static let base = [
            "http://www.csencinofilia.it/mobile/",
            "ap8g9L3UuxkxXpNDr7vUZbLjY8gQLv27VdCvXTeWbNq"
        ]
        static let software = [
            "http://software.csencinofilia.it/mobile/",
            "ap8g9L3UuxkxXpNDr7vUZbLjY8gQLv27VdCvXTeWbNq"
        ]
    }
    static let printJson = false
    
    class func base (_ page: String) -> MYHttpRequest {
        let config = HttpConfig.base
        return MYHttpRequest (auth: config[1], page: config[0] + page)
    }
    
    class func software (_ page: String) -> MYHttpRequest {
        let config = HttpConfig.software
        return MYHttpRequest (auth: config[1], page: config[0] + page)
    }
}
