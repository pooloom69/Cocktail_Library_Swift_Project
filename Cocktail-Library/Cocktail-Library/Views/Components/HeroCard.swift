import SwiftUI


struct HeroCard: View {
    @EnvironmentObject var store: RecipeStore
    let recipe: Recipe
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue.opacity(0.2))
                .frame(width: 200, height: 250)
                .shadow(radius: 4)
            
            VStack(spacing: 12) {
                Text(recipe.name)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Text(recipe.base)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(recipe.style)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(recipe.flavors.joined(separator: ", ")) // show all flavors
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}


struct HeroCard_Previews: PreviewProvider {
    static var previews: some View {
        HeroCard(recipe: Recipe(
            id: "preview_id",
            name: "Preview Cocktail",
            base: "Gin",
            style: "Classic",
            flavors: ["Sweet", "Citrus"],
            abv: 12.0,
            ice: "Shaken with ice",
            ingredients: [
                Ingredient(name: "Gin", amount: 2.0, unit: "oz"),
                Ingredient(name: "Lemon Juice", amount: 1.0, unit: "oz")
            ],
            steps: ["Shake all ingredients with ice", "Strain into glass"],
            glass: "Coupe",
            garnish: ["Lemon Twist"]
        ))
    }
}
