// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct Ingredient: Codable, Hashable {
    public let name: String
    public let amount: Double
    public let unit: String

    public init(name: String, amount: Double, unit: String) {
        self.name = name
        self.amount = amount
        self.unit = unit
    }
}

public struct Cocktail: Codable, Hashable, Identifiable {
    public let id: String
    public let name: String
    public let base: String
    public let style: String
    public let ingredients: [Ingredient]
    public let steps: [String]

    public init(id: String, name: String, base: String, style: String, ingredients: [Ingredient], steps: [String]) {
        self.id = id
        self.name = name
        self.base = base
        self.style = style
        self.ingredients = ingredients
        self.steps = steps
    }
}

// 샘플 1개 (앱에서 바로 써볼 수 있게)
public extension Cocktail {
    static var sample: Cocktail {
        Cocktail(
            id: "daiquiri-classic",
            name: "Daiquiri",
            base: "rum",
            style: "sour",
            ingredients: [
                Ingredient(name: "White Rum", amount: 60, unit: "ml"),
                Ingredient(name: "Lime Juice", amount: 25, unit: "ml"),
                Ingredient(name: "Simple Syrup", amount: 15, unit: "ml")
            ],
            steps: [
                "Shake with ice for 10–12 seconds.",
                "Strain into a chilled coupe."
            ]
        )
    }
}
