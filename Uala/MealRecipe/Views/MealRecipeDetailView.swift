//
//  MealRecipeDetailView.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct MealRecipeDetailView: View {
    @ObservedObject var mealRecipeDetailViewModel:  MealRecipeDetailViewModel
   
    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: URL(string: (mealRecipeDetailViewModel.mealRecipe.imageUrl)!))
                .resizable()
                .indicator(.activity)
                .frame(width: UIScreen.main.bounds.width, height: 250)
                
            HStack {
                Spacer()
                Text(mealRecipeDetailViewModel.mealRecipe.name ?? "")
                         .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.blue)
                Spacer()
            }.padding(.leading, 16)
            
            ScrollView(.vertical, showsIndicators: false) {
                MealRecipeIngredientsView(mealRecipeDetailViewModel: self.mealRecipeDetailViewModel)
                    .padding(.horizontal, 16)
                MealRecipeInstructionsView(mealRecipeDetailViewModel: self.mealRecipeDetailViewModel)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                
                Spacer()

                if(self.mealRecipeDetailViewModel.mealRecipe.videoUrl != nil) {
                    HStack {
                        Text("Video")
                            .font(.system(size: 21, weight: .semibold))
                            .foregroundColor(.gray)
                        Spacer()
                    }.padding(.top, 10)
                     .padding(.horizontal, 16)
                       
                    WebView(videoUrlString: self.mealRecipeDetailViewModel.mealRecipe.videoUrl!)
                        .frame(height: UIScreen.main.bounds.height / 2.3)
                     .padding(.top, 5)
                }
            }.padding(.top, 10)
            .padding(.horizontal, 0)
            
        }.navigationBarTitle("Meal Recipe Details", displayMode: .inline)
        .navigationBarBackButtonHidden(false)
    }
}
