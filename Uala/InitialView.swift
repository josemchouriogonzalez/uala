//
//  InitialView.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import SwiftUI

struct InitialView: View {
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var timerLimit : Float = 0.0
    @State private var currentSeconds: Float = 0.0
    @State private var shouldNavigateToNextView = false
    @State private var isNavigationBarHidden = true
    
    var body: some View {
        NavigationView {
            VStack {
                Image(Constants.imageName.uala.rawValue)
                    .resizable()
                    .frame(width: 160, height: 160)
                
                NavigationLink(destination: MealRecipeSearchView(isNavigationBarHidden: self.$isNavigationBarHidden), isActive: self.$shouldNavigateToNextView) {
                    Text("")
                }.hidden()
            }.navigationBarTitle("")
                .navigationBarHidden(self.isNavigationBarHidden)
                .onReceive(timer) { _ in
                    if self.currentSeconds == self.timerLimit {
                        self.timer.upstream.connect().cancel()
                        self.shouldNavigateToNextView = true
                    } else {
                        self.currentSeconds += 1.0
                    }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
