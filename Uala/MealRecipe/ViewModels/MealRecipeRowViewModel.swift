//
//  MealRecipeRowViewModel.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


class MealRecipeRowViewModel: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var networkService = NetworkService()
    var mealRecipeProvider: MealRecipeProvider
    var subscription: AnyCancellable?
    
    @Published var selectedMealRecipe : MealRecipe?
    
    @Published var mealRecipesArray : [MealRecipe] = []
    
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
    
    func setSelectedMealRecipe(mealRecipe: MealRecipe) {
        self.selectedMealRecipe = mealRecipe
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
                    if let mealsRecipeArry = value["meals"] as [MealRecipe]? {
                         self.mealRecipesArray = mealsRecipeArry
                    }
                })
        }
    }
}


