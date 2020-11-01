//
//  MealRecipeEndPoint.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import Foundation
import Combine

protocol MealRecipeProviding {
    var networkService: NetworkServiceProviding { get }
    func getMealRecipes(searchTerm: String) -> AnyPublisher<[String: [MealRecipe]], Error>
    func getRandomMeal() -> AnyPublisher<[String: [MealRecipe]], Error>
}


enum MealRecipeEndpoint: RequestProviding {
    case getMealRecipes(searchTerm: String)
    case getRandomMeal
    
    var urlRequest: URLRequest {
        get {
            switch self {
            case .getMealRecipes(let searchTerm):
                var url =  URLRequest(url:  URL(string:NetworkConfiguration.shared.baseUrl! + "search.php?s=\(searchTerm)")!)
                url.httpMethod = HTTPMethod.get.rawValue
                url.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HTTPHeaderField.contentType.rawValue)
                return url
            case .getRandomMeal:
                var url =  URLRequest(url:  URL(string:NetworkConfiguration.shared.baseUrl! + "random.php")!)
                url.httpMethod = HTTPMethod.get.rawValue
                url.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HTTPHeaderField.contentType.rawValue)
                return url
            }
        } set {
            
        }
    }
}

struct MealRecipeProvider: MealRecipeProviding {
    let networkService: NetworkServiceProviding
    
    func getMealRecipes(searchTerm: String) -> AnyPublisher<[String: [MealRecipe]], Error> {
        return networkService.execute(MealRecipeEndpoint.getMealRecipes(searchTerm: searchTerm))
    }
    
    func getRandomMeal() -> AnyPublisher<[String: [MealRecipe]], Error> {
        return networkService.execute(MealRecipeEndpoint.getRandomMeal)
    }
}
