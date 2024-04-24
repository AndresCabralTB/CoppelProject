//
//  HomeView.swift
//  Coppel_Project
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var tagViewModel: TagViewModel
    @Binding var showSignInView: Bool

    var body: some View {
        TabView{
            HomeScreenView()
                .tabItem {
                    Text("Home")
                    Image(systemName: "house")
                }
                .tag(0)
            
            SettingsView(showSignInView: $showSignInView)
                .tabItem {
                    Text("Settings")
                    Image(systemName: "gear")
                }
                .tag(1)
        }
        
    }
}

//#Preview {
//    HomeView(showSignInView: $showSignInView)
//}
