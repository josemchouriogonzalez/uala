//
//  MealRecipeViewModel.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import Foundation
import Combine

class MealRecipeViewModel: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var networkService = NetworkService()
    var mealRecipeProvider: MealRecipeProvider
    var subscription: AnyCancellable?
    
    @Published var mealRecipesArray : [MealRecipe] = []
    
    @Published var randonMeal : MealRecipe?  {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var mealRecipeSearchTerm : String = "a" {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var isDoingSearch: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        mealRecipeProvider = MealRecipeProvider(networkService: networkService)
        getMealRecipes()
    }
    
    func getMealRecipes() {
        if let _ = NetworkConfiguration.shared.baseUrl {
            isDoingSearch = true
            mealRecipeProvider = MealRecipeProvider(networkService: networkService)
            subscription = mealRecipeProvider.getMealRecipes(searchTerm: self.mealRecipeSearchTerm)
                .receive(on: OperationQueue.main)
                .sink(receiveCompletion: { completion in
                    self.isDoingSearch = false
                    switch completion {
                    case .finished:
                        print("Received completion: ", completion)
                        break
                    case .failure(let error):
                        print("Received completion: ", completion, error)
                    }
                }, receiveValue: { value in // Escaping closure captures mutating 'self' parameter
                    print(".sink() received \(value)")
                    if let mealsRecipeArray = value["meals"] as [MealRecipe]? {
                        self.mealRecipeSearchTerm = ""
                        self.mealRecipesArray = mealsRecipeArray
                        self.randonMeal = mealsRecipeArray.first!
                    }
                })
        }
    }
    
    func getRandonMeal() {
        if let _ = NetworkConfiguration.shared.baseUrl {
            mealRecipeProvider = MealRecipeProvider(networkService: networkService)
            subscription = mealRecipeProvider.getRandomMeal()
                .receive(on: OperationQueue.main)
                .sink(receiveCompletion: { completion in
                    self.isDoingSearch = false
                    switch completion {
                    case .finished:
                        print("Received completion: ", completion)
                        break
                    case .failure(let error):
                        print("Received completion: ", completion, error)
                    }
                }, receiveValue: { value in // Escaping closure captures mutating 'self' parameter
                    print(".sink() received \(value)")
                    if let mealsRecipeArray = value["meals"] as [MealRecipe]? {
                        self.randonMeal = mealsRecipeArray.first!
                    }
                })
        }
    }
}
