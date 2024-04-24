//
//  StartUpView.swift
//  Coppel_Project
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI

struct StartUpView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Bienvenido")
                .font( .title)
                .fontWeight(.bold)
            
            Text("¿Tienes Cuenta Bancaria?")
                .font(.title2)
                .fontWeight(.bold)
            
            HStack{
                Button{
                    
                } label:{
                    Text("Si")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.10)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.coppelBlue))
                }
                
                Button{
                    
                } label:{
                    Text("No")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.10)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.coppelYellow))
                }
            }
        }
    }
}

#Preview {
    StartUpView()
}
