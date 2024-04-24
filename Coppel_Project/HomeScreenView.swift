//
//  HomeScreenView.swift
//  Coppel_Project
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI

struct HomeScreenView: View {
    
    @State var showStartUp: Bool = false
    @EnvironmentObject var userInfo: UserInfo
    @State var addInfo = AddInfoViewModel()
    @State var authenticationManager = AuthenticationManager()
    
    
    var body: some View {
        
        VStack{
            Text("THIS IS THE HOME SCREEN")
        }
        .onAppear{
            
            Task{
                do{
                    
                    userInfo.user = try await addInfo.getUserInfo(user: authenticationManager.getAuthenticatedUser().uid)
                    
                    if userInfo.user.nombre == ""{
                        showStartUp = true
                    }
                }
            }
            
            
        }
        .fullScreenCover(isPresented: $showStartUp) { //En caso de que sea nuevo usuario
            StartUpTabView(showStartUp: $showStartUp)
        }
        
    }
}

//#Preview {
//    HomeScreenView()
//}
