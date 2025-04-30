//
//  Auth0View.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//
import SwiftUI
import Auth0

struct Auth0View: View {
    @ObservedObject var viewModel: Auth0ViewModel = Auth0ViewModel()

    var body: some View {
//        if let user = viewModel.user {
            VStack {
//                Auth0ProfileView(user: user)
//                Button("Logout", action: viewModel.logout)
                HomeView()
            }
//        } else {
//            VStack {
//                Auth0FrontView()
//                Button("Login", action: viewModel.login)
//            }
//        }
    }
}

