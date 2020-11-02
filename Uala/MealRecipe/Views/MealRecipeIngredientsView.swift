//
//  MealRecipeIngredientsView.swift
//  Uala
//
//  Created by Jose Chourio on 11/2/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import SwiftUI

struct MealRecipeIngredientsView: View {
    @ObservedObject var mealRecipeDetailViewModel:  MealRecipeDetailViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Ingredients")
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundColor(.gray)
                Spacer()
            }.padding(.bottom, 5)
            
            if(self.mealRecipeDetailViewModel.mealRecipeIngredientsArray.isEmpty == false) {
                ForEach(self.mealRecipeDetailViewModel.mealRecipeIngredientsArray, id: \.self) { ingredient in
                    HStack {
                        Text(ingredient)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }.padding(.bottom, 5)
                }
            }
        }
    }
}
