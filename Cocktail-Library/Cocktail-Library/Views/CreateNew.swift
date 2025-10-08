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
    @State private var instructions = ""
    @State private var recipeIngredients: [Ingredient] = [
        Ingredient(name: "", amount: 0.0, unit: "oz")]
    
    @EnvironmentObject var store: RecipeStore
    
    let units = ["oz", "ml", "dash", "slice", "bar spoon"]
    let ingredientsList = ["Lime", "Sugar", "Mint", "Soda", "Triple Sec", "Bitters"]
    
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
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach($recipeIngredients) { $ingredient in
                            HStack {
                                // Ingredient name (first)
                                HStack {
                                    // Ingredient name (text field)
                                    TextField("Ingredient", text: $ingredient.name)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())

                                    // Quick pick menu
                                    Menu {
                                        ForEach(ingredientsList, id: \.self) { ing in
                                            Button(ing) { ingredient.name = ing }
                                        }
                                    } label: {
                                        Image(systemName: "chevron.down.circle")
                                            .foregroundColor(.blue)
                                    }
                                }

                                // Amount (second)
                                TextField("Amount", value: $ingredient.amount, format: .number)
                                    .keyboardType(.decimalPad)
                                    .frame(width: 60)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())


                                // Unit picker (third)
                                Picker("Unit", selection: $ingredient.unit) {
                                    ForEach(units, id: \.self) { unit in
                                        Text(unit).tag(unit)
                                    }
                                }
                                .pickerStyle(.menu)
                                .frame(width: 80)

                                // Delete button (-)
                                Button(action: {
                                    if let index = recipeIngredients.firstIndex(where: { $0.id == ingredient.id }) {
                                        recipeIngredients.remove(at: index)
                                    }
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal)
                        }

                        
                        // Add new ingredient row
                        Button(action: {
                            recipeIngredients.append(Ingredient(name: "", amount: 0.0, unit: "oz", ))
                        }) {
                            Label("Add Ingredient", systemImage: "plus")
                                .padding(.horizontal)
                        }
                    }
                    
                    // etc.. temperature, abv level, carbonation, steps, glass, garnish 
                    
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
    
}
    
    struct CreateNew_Previews: PreviewProvider {
        static var previews: some View {
            CreateNew()
                .environmentObject(RecipeStore())
        }
    }

