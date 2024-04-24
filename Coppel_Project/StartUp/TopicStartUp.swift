//
//  TopicStartUp.swift
//  Coppel_Project
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI

struct TopicStartUp: View {
    
    @State var array = ["Conducir", "Programador", "Staff", "Chef"]
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 100)), count: 2)
    }
    
    var body: some View {
        VStack{
            Text("¿Cuales son tus intereses?")
                .font(.title)
                .fontWeight(.bold)
            
            LazyVGrid(columns: items, alignment: .leading){
                ForEach(array, id:\.self){interes in
                    
                    Text(interes)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.coppelBlue)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.coppelYellow))
                    
                }
            }
        }
    }
}

#Preview {
    TopicStartUp()
}
