#include "Recipe.h"
#include <iostream>
#include <iomanip>

Recipe margaritaRecipe() {
    Recipe r;
    r.id    = "margarita_classic";
    r.name  = "Margarita";
    r.base  = "Tequila";
    r.style = "Classic sour";
    r.flavors = {"citrus", "refreshing", "balanced"};
    r.abv   = 18.5;
    r.ice   = "Shake with ice, serve over fresh cubes (or none in coupe)";

    r.ingredients = {
        {"Blanco tequila", 2.0, "oz"},
        {"Orange liqueur (Cointreau)", 1.0, "oz"},
        {"Fresh lime juice", 1.0, "oz"},
        {"Agave syrup (optional)", 0.25, "oz"}
    };

    r.steps = {
        "Optional: Salt half the rim of the glass.",
        "Add tequila, orange liqueur, lime juice, and agave syrup to a shaker with ice.",
        "Shake hard for about 10–12 seconds.",
        "Strain into the prepared glass over fresh ice (or fine-strain into a coupe).",
        "Garnish before serving."
    };

    r.glass = "Rocks glass (or Coupe)";
    r.garnish = {"Salt rim (optional)", "Lime wheel or wedge"};

    return r;
}

void printRecipe(const Recipe& r) {
    std::cout << r.name << " (" << r.style << ")\n";
    std::cout << "Base: " << r.base 
              << " | ABV: " << std::fixed << std::setprecision(1) << r.abv << "%\n";
    std::cout << "Glass: " << r.glass << "\n";
    std::cout << "Ice: " << r.ice << "\n\n";

    std::cout << "Ingredients:\n";
    for (auto &ing : r.ingredients) {
        std::cout << "  - " << ing.amount << " " << ing.unit 
                  << " " << ing.name << "\n";
    }

    std::cout << "\nSteps:\n";
    for (size_t i = 0; i < r.steps.size(); ++i) {
        std::cout << "  " << (i+1) << ". " << r.steps[i] << "\n";
    }

    std::cout << "\nGarnish:\n";
    for (auto &g : r.garnish) {
        std::cout << "  - " << g << "\n";
    }

    std::cout << "\n" << std::string(50, '=') << "\n\n";
}
