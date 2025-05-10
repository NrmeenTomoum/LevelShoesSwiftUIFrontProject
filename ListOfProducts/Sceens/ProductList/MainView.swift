//
//  ContentView.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 03/05/2025.
//

import SwiftUI
struct MainView: View {
    @State private var selection: Int = 2
    
    var body: some View {
        TabView(selection: $selection)  {
            
            // Search Tab
            ContentView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(0)
            
            // Text Size Adjustment Tab
            AZView()
                .tabItem {
                    Image(systemName: "textformat.size")
                    Text("A/Z")
                }.tag(1)
            
            // Level (App Name) Tab
            LevelView()
                .tabItem {
                    Text("level")
                }.tag(2)
            
            // Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }.tag(3)
            
            
            // Cart Tab with Badge
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }.tag(4)
                .badge(1)
            // Displays a badge with the number 1 (adjust dynamically as needed)
        }.tint(Color.black)
    }
}
//

// Placeholder view for ContentView (replace with your actual content)
struct ContentView: View {
    var body: some View {
        VStack {
            Text("New In")
                .font(.largeTitle)
        }
    }
}

// Placeholder view for Text Size
struct AZView: View {
    var body: some View {
        Text("Filter View")
    }
}

// Placeholder view for Level
struct LevelView: View {
    var body: some View {
        ProductsGridView()
    }
}

// Placeholder view for Profile
struct ProfileView: View {
    var body: some View {
        Text("Profile View")
    }
}

// Placeholder view for Cart
struct CartView: View {
    var body: some View {
        Text("Cart View")
    }
}

// Preview

#Preview {
    MainView()
}

