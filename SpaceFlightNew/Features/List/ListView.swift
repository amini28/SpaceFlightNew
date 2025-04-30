//
//  ListView.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import SwiftUI

struct SearchableListWithCategoryFilter: View {
    @State private var searchText = ""
    @State private var selectedCategory: String = "All"
    
    let categories = ["All", "SUV", "Sedan", "Hatchback"]
    
    struct Car: Identifiable {
        let id = UUID()
        let name: String
        let category: String
    }
    
    let items = [
        Car(name: "Hyundai Kona", category: "SUV"),
        Car(name: "Toyota Yaris", category: "Hatchback"),
        Car(name: "Mazda CX-5", category: "SUV"),
        Car(name: "Honda Jazz", category: "Hatchback"),
        Car(name: "BMW 3 Series", category: "Sedan"),
        Car(name: "Toyota Fortuner", category: "SUV")
    ]
    
    var filteredItems: [Car] {
        items.filter { car in
            (selectedCategory == "All" || car.category == selectedCategory) &&
            (searchText.isEmpty || car.name.localizedCaseInsensitiveContains(searchText))
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Search cars...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                
                List(filteredItems) { car in
                    Text("\(car.name) - \(car.category)")
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Car Finder")
        }
    }
}
