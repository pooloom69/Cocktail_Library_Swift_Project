//
//  CreateNew.swift
//  Cocktail-Library
//
//  Created by Sola Lhim on 9/10/25.
//

import SwiftUI

struct CreateNew: View {
    @State private var recipeName = ""
    @State private var selectedBase = "Gin"
    @State private var selectedStyle = "Classic"
    @State private var selectedFlavors: Set<String> = []
    @State private var selectedIngredients: [String] = []
    @State private var instructions = ""
    
    let bases = ["Gin", "Vodka", "Rum", "Whiskey", "Tequila", "Brandy", "Mezcal", "Sake", "Soju"]
    let styles = ["Classic","Spritz", "Highball", "Martini", "Old Fashioned", "Tiki"]
    let flavors = ["Sweet", "Bitter", "Sour", "Fruity", "Spicy"]
    let ingredients = ["Lime", "Sugar", "Mint", "Soda", "Triple Sec", "Bitters"]
    
    
    
    
    var body: some View {
        VStack{
            ScrollView {
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    // Title
                    Text("Create Your Own Recipe")
                        .font(.title)
                        .bold()
                        .padding(.top)
                        .padding()
                    
                    
                    //  Recipe Name
                    HStack {
                        Text("Recipe :")
                            .font(.headline)
                            .padding()
                        TextField("Enter recipe name", text: $recipeName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)
                    
                    //  Base Spirit
                    HStack {
                        Text("Base :")
                            .font(.headline)
                            .padding()
                        Picker("Select Base", selection: $selectedBase) {
                            ForEach(bases, id: \.self) { base in
                                Text(base).tag(base)
                            }
                        }
                        .pickerStyle(.menu) // dropdown
                    }
                    .padding(.horizontal)
                    
                    //  Style
                    HStack {
                        Text("Style :")
                            .font(.headline)
                            .padding()
                        Picker("Select Style", selection: $selectedStyle) {
                            ForEach(styles, id: \.self) { style in
                                Text(style).tag(style)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .padding(.horizontal)
                    
                    //  Flavor Tags
                    Text("Flavors")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            ForEach(flavors, id: \.self) { flavor in
                                Button(action: {
                                    if selectedFlavors.contains(flavor) {
                                        selectedFlavors.remove(flavor)
                                    } else {
                                        selectedFlavors.insert(flavor)
                                    }
                                }) {
                                    Text(flavor)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(selectedFlavors.contains(flavor) ? Color.orange : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedFlavors.contains(flavor) ? .white : .black)
                                        .cornerRadius(12)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                    .frame(height: 60)
                    
                    //  Ingredients
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(ingredients, id: \.self) { ing in
                                Button(action: {
                                    if selectedIngredients.contains(ing) {
                                        // If the ingredient is already selected → remove it
                                        selectedIngredients.removeAll { $0 == ing }
                                    } else {
                                        // If it's a new ingredient → add it
                                        selectedIngredients.append(ing)
                                    }
                                }) {
                                    Text(ing)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                    // Change background color depending on selection state
                                        .background(selectedIngredients.contains(ing) ? Color.blue : Color.blue.opacity(0.2))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                    
                    // Chosen ingredients
                    if !selectedIngredients.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Selected Ingredients:")
                            ForEach(selectedIngredients, id: \.self) { ing in
                                Text("• \(ing)")
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    //  Instructions
                    Text("Instructions")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding()
                    TextEditor(text: $instructions)
                        .frame(height: 120)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
                        .padding(.horizontal)
                    
                    //  Optional fields (expand later)
                    Text("Optional Fields (Glass, Garnish, Carbonation, Temperature...)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
            Button(action: {
                print("Recipe saved: \(recipeName)")
                // Add your save logic here
            }) {
                Text("Save Recipe")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Create Recipe")
    }
}



struct CreateNew_Previews: PreviewProvider {
    static var previews: some View {
        CreateNew()
    }
}
