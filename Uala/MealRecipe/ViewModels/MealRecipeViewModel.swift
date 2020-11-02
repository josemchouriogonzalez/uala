//
//  MealRecipeViewModel.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


class MealRecipeViewModel: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var mealRecipe: MealRecipe
    
    init(mealRecipe: MealRecipe) {
        self.mealRecipe = mealRecipe
    }
}


