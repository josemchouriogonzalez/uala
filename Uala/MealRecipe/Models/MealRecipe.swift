//
//  MealRecipe.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import Foundation

struct MealRecipe: Identifiable, Codable {
    let id: String?
    let name: String?
    let category: String?
    let imageUrl: String?
    let ingredients: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case imageUrl = "strMealThumb"
        case ingredients = "strIngredientN"
    }
}
