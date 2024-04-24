//
//  InputTextView.swift
//  Coppel_Project
//
//  Created by Omar Atriano on 23/04/24.
//

import SwiftUI

import SwiftUI

struct InputTextView: View {
    @Binding var text: String
    
    let title: String
    let placeholder: String
    var isSecureField = false
    var allowsOnlyNumbers = false
    
    var body: some View {
        VStack(alignment: .leading ){
            Text(title)
                .foregroundColor(Color(.black))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if allowsOnlyNumbers {
                TextField(placeholder, text: numberOnlyBinding)
                    .keyboardType(.numberPad) // Show numeric keypad
                    .font(.system(size: 14))
                    .padding(10)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.black), lineWidth: 1))
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .toolbar { // Toolbar to add a Done button
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                hideKeyboard()
                            }
                        }
                    }
            }
            else if !allowsOnlyNumbers{
                if isSecureField{
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 14))
                        .padding(10)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.black), lineWidth: 1))
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                }
                
                else if !isSecureField{
                    TextField(placeholder, text: $text)
                        .font(.system(size: 14))
                        .padding(10)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.black), lineWidth: 1))
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                }
                
                
            }
            
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 2)
    }
    
    private var numberOnlyBinding: Binding<String> {
        Binding<String>(
            get: { self.text },
            set: {
                self.text = $0.filter { "0123456789".contains($0) }
            }
        )
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
}

#Preview {
    Group {
        InputTextView(text: .constant(""), title: "Correo Electrónico", placeholder: "name@example.com")
        InputTextView(text: .constant(""), title: "Contraseña", placeholder: "Contraseña", isSecureField: true)
        InputTextView(text: .constant(""), title: "Número de Teléfono", placeholder: "1234567890", allowsOnlyNumbers: true)
    }}
