import Foundation

struct Ingredient: Identifiable, Codable {
    let id = UUID()
    var name: String
    var amount: Double
    var unit: String
}

struct Recipe: Identifiable, Codable {
    let id: String                
    var name: String
    var base: String
    var style: String
    var flavors: [String]
    var abv: Double?
    var ice: String?
    var ingredients: [Ingredient]
    var steps: [String]
    var glass: String?
    var garnish: [String]?
    var isFavorite: Bool = false  // not in JSON, default false
}

