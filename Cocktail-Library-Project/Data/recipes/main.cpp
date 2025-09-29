#include "Recipe.h"
#include "FlavorUtils.h"
#include <vector>

int main() {
    std::vector<Recipe> recipes;

    recipes.push_back(margaritaRecipe());
    recipes.push_back(daiquiriRecipe());
    recipes.push_back(dirtyMartiniRecipe());
    recipes.push_back(oldFashionedRecipe());

    // Print each recipe
    for (const auto& r : recipes) {
        printRecipe(r);
    }

    // Compute & print flavor profiles
    auto mProf = computeFlavorProfile(recipes[0]);
    auto dProf = computeFlavorProfile(recipes[1]);

    printFlavorProfile(mProf, "Margarita – Flavor Profile (0–1):");
    printFlavorProfile(dProf, "Daiquiri – Flavor Profile (0–1):");

    // Compare side-by-side
    compareFlavorProfiles(mProf, dProf, "Margarita", "Daiquiri");

    // Average profile across collection
    auto avg = averageFlavorProfile(recipes);
    printFlavorProfile(avg, "Average Profile (all recipes):");

    return 0;
}
