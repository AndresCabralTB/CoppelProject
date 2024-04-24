//
//  UpperInputTextView.swift
//  Coppel_Project
//
//  Created by Omar Atriano on 23/04/24.
//

import SwiftUI

struct UpperInputTextView: View {
    let title: String
    var body: some View {
       
        HStack{
            Text("\(title)")
                .foregroundColor(Color(.black))
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .padding(.vertical,5)
                .padding(.horizontal,20)
            Spacer()
        }
        
        }
    
}

#Preview {
    UpperInputTextView(title: "Hola")
}
