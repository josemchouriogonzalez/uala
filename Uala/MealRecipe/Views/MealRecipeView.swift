//
//  MealRecipeView.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct MealRecipeView: View {
    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var timerLimit : Float = 3.0
    @State var currentSeconds: Float = 0.0
    @State private var searchTerm = ""
    @Binding var isNavigationBarHidden: Bool
    @ObservedObject var mealRecipeViewModel = MealRecipeViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment:.leading) {
                SearchBar(text: $searchTerm, placeholder: "Search")
                
                if self.mealRecipeViewModel.mealRecipesArray.isEmpty == false {
                    List {
                        ForEach(mealRecipeViewModel.mealRecipesArray.filter({searchTerm.isEmpty ? true : $0.name!.localizedCaseInsensitiveContains(searchTerm)})) { mealRecipe in
                            NavigationLink(destination: MealRecipeDetailView()) {
                                MealRecipeViewRow(mealRecipe: mealRecipe)
                            }
                        }
                    }
                    
                    if self.mealRecipeViewModel.randonMeal?.imageUrl != nil {
                        WebImage(url: URL(string: (mealRecipeViewModel.randonMeal?.imageUrl)!))
                            .resizable()
                            .indicator(.activity)
                            .frame(width: UIScreen.main.bounds.width, height: 120)
                    }
                } else {
                    Spacer()
                }
            }.padding(.horizontal, 16)
            .navigationBarHidden(isNavigationBarHidden)
            .navigationBarTitle("Meal Recipes")
            .navigationBarBackButtonHidden(true)
            .gesture(DragGesture().onChanged { _ in
                UIApplication.shared.windows.forEach { $0.endEditing(false) }
            })
            .onAppear {
                UITableView.appearance().separatorStyle = .singleLine
                UITableView.appearance().tableFooterView = UIView()
                self.isNavigationBarHidden = false
                self.timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
            } .onDisappear {
                self.timer.upstream.connect().cancel()
            }
            .onReceive(timer) { _ in
                if self.currentSeconds == self.timerLimit {
                    self.currentSeconds = 0
                    self.mealRecipeViewModel.getRandonMeal()
                } else {
                    self.currentSeconds += 1.0
                }
            }
            
            if mealRecipeViewModel.isDoingSearch {
                ActivityIndicator(isAnimating: self.$mealRecipeViewModel.isDoingSearch, style: .medium)
            }
        }
    }
}
