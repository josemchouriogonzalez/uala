//
//  MealRecipeDetailViewModel.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import Foundation
import Combine

class MealRecipeDetailViewModel: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var mealRecipe: MealRecipe
    @Published var mealRecipeIngredientsArray: [String] = []
    @Published var mealRecipeInstructionsArray: [String] = []
    
    init(mealRecipe: MealRecipe) {
        self.mealRecipe = mealRecipe
        setIngredientsArray()
        setInstructionsArray()
    }
    
    func setIngredientsArray() {
        do {
            let ingredientsDictionary = try mealRecipe.allProperties()
            if ingredientsDictionary.keys.isEmpty == false {
                for (key, value) in ingredientsDictionary {
                    if key.localizedCaseInsensitiveContains("ingredient") {
                        if let value = value, value.isEmpty == false {
                            mealRecipeIngredientsArray.append(value)
                        }
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func setInstructionsArray() {
        guard let mealInstructions = mealRecipe.instructions, mealInstructions.isEmpty == false else {
            return
        }
        mealRecipeInstructionsArray = mealInstructions.components(separatedBy: "\r\n")
    }
}

