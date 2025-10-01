import SwiftUI

struct Ingredient: Identifiable, Codable {
    let id = UUID()
    var amount: String
    var unit: String
    var name: String
}