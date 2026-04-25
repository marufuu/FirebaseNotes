//
//  SignupView.swift
//  FirebaseNote
//
//  Created by Maruf on 16/4/26.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button("Create") {
                signup()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(26)
            
            Button("Sign up with Google") {
                // We'll implement this next step
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Spacer()
        }
        .padding()
    }
    
    func signup() {
        AuthService.shared.signup(email: email, password: password) { result in
            switch result {
            case .success(let user):
                print("User created: \(user.uid)")
                
            case .failure(let error):
                
                if let err = error as NSError?,
                   err.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    errorMessage = "This email is already registered."
                } else {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    SignupView()
}
