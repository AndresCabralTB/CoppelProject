//
//  StartUpTabView.swift
//  Coppel_Project
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI

struct StartUpTabView: View {
    
    @EnvironmentObject var startUpTag: StartUpTabViewModel
    @Binding var showStartUp: Bool
    
    var body: some View {
        TabView(selection: $startUpTag.startUpTag){
            CreateEmpView() //Formulario
                .tabItem {
                    Image(systemName: "1.circle.fill")
                }
                .tag(0)
            
            StartUpView(showStartUp: $showStartUp) //Eres worker ?
                .tabItem {
                    Image(systemName: "2.circle.fill")
                }
                .tag(1)
            
            FormularioTarjeta(showStartUp: $showStartUp) //Eres worker ?
                .tabItem {
                    Image(systemName: "3.circle.fill")
                }
                .tag(2)
            
            
        }
    }
}

#Preview {
    StartUpTabView(showStartUp: Binding.constant(true))
}
