//
//  Auth0View.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//
import SwiftUI
import Auth0

struct Auth0View: View {
    @State var user: User?

    var body: some View {
        if let user = self.user {
            VStack {
                Auth0ProfileView(user: user)
                Button("Logout", action: self.logout)
            }
        } else {
            VStack {
                Auth0FrontView()
                Button("Login", action: self.login)
            }
        }
    }
}

extension Auth0View {
    func login() {
        Auth0
            .webAuth()
//            .useHTTPS()  Use a Universal Link callback URL on iOS 17.4+ / macOS 14.4+
//            .redirectURL(URL(fileURLWithPath: "com.amini.SpaceFlightNew://auth/callback")) // <-- HARUS sama persis
            .start { result in
                switch result {
                case .success(let credentials):
                    self.user = User(from: credentials.idToken)
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }

    func logout() {
        Auth0
            .webAuth()
//            .useHTTPS() // Use a Universal Link logout URL on iOS 17.4+ / macOS 14.4+
            .clearSession { result in
                switch result {
                case .success:
                    self.user = nil
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
}
