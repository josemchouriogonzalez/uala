//
//  MealRecipeSearchView.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct MealRecipeSearchView: View {
    @State private var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var timerLimit : Float = 30.0
    @State private var currentSeconds: Float = 0.0
    @State private var searchTerm = ""
    
    @Binding var isNavigationBarHidden: Bool
    @ObservedObject var mealRecipeSearchViewModel = MealRecipeSearchViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment:.leading) {
                SearchBar(text: $searchTerm, placeholder: "Search")
                
                if self.mealRecipeSearchViewModel.mealRecipesArray.isEmpty == false {
                    if self.searchTerm.isEmpty == false {
                        if self.mealRecipeSearchViewModel.mealRecipesArray.filter({($0.name != nil && $0.name!.localizedCaseInsensitiveContains(self.searchTerm))}).count == 0 {
                            HStack {
                                Spacer()
                                Image(Constants.imageName.resultsNotFound.rawValue)
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .padding(.top, 60)
                                Spacer()
                            }
                          
                            HStack {
                                Spacer()
                                Text("No meal recipes found for the term you entered")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.customOrange)
                                    .padding(.top, 20)
                                Spacer()
                            }
                        }
                    }
                    
                    List {
                        ForEach(mealRecipeSearchViewModel.mealRecipesArray.filter({searchTerm.isEmpty ? true : $0.name!.localizedCaseInsensitiveContains(searchTerm)})) { mealRecipe in
                            NavigationLink(destination: MealRecipeDetailView(mealRecipeDetailViewModel: MealRecipeDetailViewModel(mealRecipe: mealRecipe))) {
                                MealRecipeViewRow(mealRecipeViewModel: MealRecipeViewModel(mealRecipe: mealRecipe))
                            }
                        }
                    }
                    
                    if self.mealRecipeSearchViewModel.randonMeal?.imageUrl != nil {
                        WebImage(url: URL(string: (mealRecipeSearchViewModel.randonMeal?.imageUrl)!))
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
                .alert(isPresented: self.$mealRecipeSearchViewModel.shouldPresentAlert) {
                    Alert(title: Text("Error"), message: Text(self.mealRecipeSearchViewModel.errorMessage), primaryButton: .default(Text("Retry")) {
                        self.mealRecipeSearchViewModel.getMealRecipes()
                    }, secondaryButton: .cancel())
            }
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
                    self.mealRecipeSearchViewModel.getRandonMeal()
                } else {
                    self.currentSeconds += 1.0
                }
            }
            
            if mealRecipeSearchViewModel.isDoingSearch {
                ActivityIndicator(isAnimating: self.$mealRecipeSearchViewModel.isDoingSearch, style: .medium)
            }
        }
    }
}
