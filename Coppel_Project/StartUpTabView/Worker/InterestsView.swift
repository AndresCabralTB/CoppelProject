//
//  InterestsView.swift
//  Coppel_Project
//
//  Created by Omar Atriano on 23/04/24.
//

import SwiftUI

struct InterestsView: View {
    
    @StateObject var interestsViewModel = AddInfoViewModel()
    @StateObject var authenticationManager = AuthenticationManager()
    
    @State private var selectedInterests: Set<String> = []
    @Binding var showIntereses: Bool
    @State var tempInterests: [String] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text("Intereses")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                .foregroundColor(Color.coppelBlue)
            
            Text("Selecciona aquellas áreas de interés en las que te gustaría trabajar ")
                .padding(.horizontal)
                .padding(.vertical,2)

                VStack {
                    ForEach(0..<(intereses.count / 3) + 1, id: \.self) { rowIndex in
                        HStack {
                            ForEach(0..<3, id: \.self) { columnIndex in
                                let index = rowIndex * 3 + columnIndex
                                if index < intereses.count {
                                    interestButton(interest: intereses[index])
                                }
                            }
                        }
                    }
                    
                    
                }
            .padding(10)
            
            Spacer()
            
            Button{
                
                tempInterests = Array(selectedInterests)
                print(tempInterests)
                
                Task{
                    do{
                        let user_id = try authenticationManager.getAuthenticatedUser().uid
                        try await interestsViewModel.addInterests(userId: user_id, interests: tempInterests)
                    }
                }
                //Enter to firebase
                showIntereses = false
            } label: {
                Text("Registrar")
                    .foregroundColor(.white)
                    .font( .title3)
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .padding(.vertical)
                    .background(RoundedRectangle(cornerRadius: 10.0).stroke(Color.black, lineWidth: 1).fill(Color.coppelBlue))
            }
            .padding(.horizontal, 20)
            
        }
        .padding(.bottom)
    }
    
    private func interestButton(interest: String) -> some View {
        Button(action: {
            if selectedInterests.contains(interest) {
                selectedInterests.remove(interest)
            } else {
                selectedInterests.insert(interest)
            }
        }) {
            Text(interest)
                .foregroundColor(selectedInterests.contains(interest) ? .blue : .primary)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .frame(minWidth: 80, idealWidth: 100, maxWidth: .infinity)
                .background(selectedInterests.contains(interest) ? Color.coppelYellow : Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.coppelBlue, lineWidth: 1)
                )
        }
    }
}

//#Preview {
//    InterestsView()
//}
