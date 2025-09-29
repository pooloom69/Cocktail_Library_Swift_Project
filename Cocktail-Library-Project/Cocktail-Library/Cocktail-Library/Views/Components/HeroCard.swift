import SwiftUI

struct HeroCard: View {
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


//struct HeroCard_Previews: PreviewProvider {
//    static var previews: some View {
//        HeroCard()
//    }
//}

