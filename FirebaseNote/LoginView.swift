//
//  LoginView.swift
//  FirebaseNote
//
//  Created by Maruf on 16/4/26.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("InsightHub")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                Button("Login") {
                    login()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(26)
                
                NavigationLink("Create Account") {
                    SignupView()
                }
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    func login() {
        AuthService.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let user):
                print("FN: Logged in: \(user.uid)")
            case .failure(let error):
                errorMessage = error.localizedDescription
                print("FN: Login failed: \(errorMessage)")
            }
        }
    }
}

#Preview {
    LoginView()
}
