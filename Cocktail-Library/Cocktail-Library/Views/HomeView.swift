import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedBases: Set<String> = []
    @State private var selectedStyles: Set<String> = []
    @State private var selectedFlavors: Set<String> = []
    @State private var allRecipes: [Recipe] = []
    @State private var recommendations: [Recipe] = []
    
    @EnvironmentObject var store: RecipeStore
    
//    let todaysPick = recipes.randomElement()
    let units = ["oz", "ml", "dash", "slice", "bar spoon"]
    let ingredientsList = ["Lime", "Sugar", "Mint", "Soda", "Triple Sec", "Bitters"]
    
    let bases = ["Gin", "Vodka", "Rum", "Whiskey", "Tequila", "Brandy", "Mezcal", "Sake", "Soju"]
    let styles = ["Classic","Spritz", "Highball", "Martini", "Old Fashioned", "Tiki"]
    let flavors = ["Sweet", "Bitter", "Sour", "Fruity", "Spicy"]
    let ingredients = ["Lime", "Sugar", "Mint", "Soda", "Triple Sec", "Bitters"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 10) {
                // Title
                Text("Cocktail Library")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                Text("Today's Pick")
                    .font(.headline)
                
                // Banner
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue.opacity(0.2))
                        .frame(height: 100)
                        .shadow(radius: 3)
                }
                
                Text("Find your Recipe")
                    .font(.headline)
                    .padding(.top, 12)
                
                // Search Bar
                SearchBar(text: $searchText)
                    .padding(.top, 15)
                
                // Filters
                Group {
                    // Base
                    Text("Base")
                        .font(.headline)
                        .padding(.top, 4)
                    ScrollView(.horizontal, showsIndicators: false) {
                        MultiSelectChips(options: bases, selection: $selectedBases)
                            .padding(.horizontal)
                    }
                    
                    // Style
                    Text("Style")
                        .font(.headline)
                        .padding(.top, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        MultiSelectChips(options: styles, selection: $selectedStyles)
                            .padding(.horizontal)
                    }
                    
                    // Flavor
                    Text("Flavor")
                        .font(.headline)
                        .padding(.top, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        MultiSelectChips(options: flavors, selection: $selectedFlavors)
                            .padding(.horizontal)
                    }
                }
                
                // Match button
                Button(action: {
                    recommendations = allRecipes.filter { recipe in
                        (selectedBases.isEmpty || selectedBases.contains(recipe.base)) &&
                        (selectedStyles.isEmpty || selectedStyles.contains(recipe.style)) &&
                        (selectedFlavors.isEmpty || !selectedFlavors.isDisjoint(with: recipe.flavors))
                    }
                    .prefix(5) // only take first 5 matches
                    .map { $0 }
                }) {
                    Text("Match")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(12)
                        .padding(.vertical)
                }
                
                // Recommendations
                if !recommendations.isEmpty {
                    Text("Recommended Recipes")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(recommendations) { recipe in
                                HeroCard(recipe: recipe)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            allRecipes = loadRecipes() // load JSON on view load
        }
    }
}


// MARK: - JSON Loader
func loadRecipes() -> [Recipe] {
    guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        print("⚠️ Could not load recipes.json")
        return []
    }
    return (try? JSONDecoder().decode([Recipe].self, from: data)) ?? []
}

// Search Bar
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

