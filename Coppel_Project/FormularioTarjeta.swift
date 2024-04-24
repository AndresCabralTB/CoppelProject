//
//  FormularioTarjeta.swift
//  Coppel_Project
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI

struct FormularioTarjeta: View {
    
    @EnvironmentObject var startUpTag: StartUpTabViewModel
    @Binding var showStartUp: Bool
    
    var body: some View {
        VStack{
            Text("Formulario Tarjeta")
            
            Button{
                showStartUp = false
                startUpTag.startUpTag = 0
            } label:{
                Text("Registrar tarjeta")
            }
        }
    }
}

//#Preview {
//    FormularioTarjeta()
//}
