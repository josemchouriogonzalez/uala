//
//  MealRecipeInstructionsView.swift
//  Uala
//
//  Created by Jose Chourio on 11/2/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import SwiftUI

struct MealRecipeInstructionsView: View {
    @ObservedObject var mealRecipeDetailViewModel:  MealRecipeDetailViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Instructions")
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundColor(.gray)
                Spacer()
            }.padding(.bottom, 5)
            
            if(self.mealRecipeDetailViewModel.mealRecipeInstructionsArray.isEmpty == false) {
                ForEach(self.mealRecipeDetailViewModel.mealRecipeInstructionsArray, id: \.self) { instruction in
                    HStack(alignment:.top) {
                        Text(instruction)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.bottom, 6)
                }
            }
        }
    }
}


