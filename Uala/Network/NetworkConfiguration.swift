//
//  NetworkConfiguration.swift
//  Ualá
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import Foundation

struct NetworkConfiguration {
    static let shared = NetworkConfiguration()
    
    private static let baseUrlKey = "API_BASE_URL"
    let baseUrl : String?
    
    private init() {
        self.baseUrl =  Bundle.main.object(forInfoDictionaryKey: NetworkConfiguration.baseUrlKey) as? String
    }
}
