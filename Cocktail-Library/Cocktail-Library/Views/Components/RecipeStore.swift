import SwiftUI


class RecipeStore: ObservableObject {
    // Published arrays so SwiftUI views automatically update when data changes
    @Published var defaultRecipes: [Recipe] = []   // Preloaded recipes from recipes.json (read-only, bundle)
    @Published var userRecipes: [Recipe] = []      // User-created recipes from user_recipes.json (read/write, Documents folder)
    
    init() {
        // Load both sets of recipes when the app starts
        loadDefaultRecipes()
        loadUserRecipes()
    }
    
    // MARK: - Load default recipes (from app bundle)
    // These are packaged with the app and cannot be modified
    func loadDefaultRecipes() {
        if let urls = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: "Data/recipes") {
            print("Found \(urls.count) JSON files in bundle:")
            urls.forEach { print(" - \($0.lastPathComponent)") }
            
            var loaded: [Recipe] = []
            for url in urls {
                do {
                    let data = try Data(contentsOf: url)
                    let decoded = try JSONDecoder().decode(Recipe.self, from: data)
                    loaded.append(decoded)
                } catch {
                    print("Failed to decode \(url.lastPathComponent): \(error)")
                }
            }
            defaultRecipes = loaded
            print("Loaded \(defaultRecipes.count) recipes")
        } else {
            print("No recipes found in Data/recipes.")
        }
    }


    // MARK: - Load user recipes (from Documents directory)
    // These are recipes created or saved by the user, stored persistently
    func loadUserRecipes() {
        if let url = getUserRecipesURL(),
           let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([Recipe].self, from: data) {
            userRecipes = decoded
        }
    }
    
    // MARK: - Add a new user recipe
    // Appends the new recipe to the array and then saves to JSON file
    func addUserRecipe(_ recipe: Recipe) {
        userRecipes.append(recipe)
        saveUserRecipes()
    }
    
    // MARK: - Save user recipes back to JSON file
    // Converts the array into JSON and writes to Documents directory
    func saveUserRecipes() {
        if let url = getUserRecipesURL(),
           let data = try? JSONEncoder().encode(userRecipes) {
            try? data.write(to: url)
        }
    }
    
    // MARK: - Helper: Get URL path for user_recipes.json in Documents directory
    private func getUserRecipesURL() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("user_recipes.json")
    }
}
