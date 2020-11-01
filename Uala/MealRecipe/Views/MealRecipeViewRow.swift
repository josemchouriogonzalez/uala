//
//  MealRecipeViewRow.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MealRecipeViewRow: View {
    var mealRecipe: MealRecipe
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack {
                if(self.mealRecipe.imageUrl != nil) {
                    WebImage(url: URL(string: (self.mealRecipe.imageUrl)!))
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .frame(width: 70, height: 70)
                        .cornerRadius(15)
                        .clipped()
                } else {
                    Image(Constants.imageName.uala.rawValue)
                        .resizable()
                        .frame(width: 70,height: 70)
                }
            }
            
            VStack(alignment: .leading) {
                Text(self.mealRecipe.name ?? "")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.blue)
                
                Text(self.mealRecipe.category ?? "")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
            }
            Spacer()
        }.frame(height: 80)
    }
}
