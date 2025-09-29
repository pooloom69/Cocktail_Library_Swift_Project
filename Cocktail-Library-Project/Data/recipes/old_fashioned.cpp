#include "Recipe.h"

Recipe oldFashionedRecipe() {
    Recipe r;
    r.id    = "old_fashioned_classic";
    r.name  = "Old Fashioned";
    r.base  = "Bourbon or Rye Whiskey";
    r.style = "Spirit-forward stirred";
    r.flavors = {"spirit-forward", "sweet", "bitter", "aromatic"};
    r.abv   = 29.0; // ~2 oz whiskey (40%), 0.25 oz syrup, bitters, dilution → ~29%
    r.ice   = "Build over ice, stir briefly, serve over large cube";

    r.ingredients = {
        {"Bourbon or Rye whiskey", 2.0, "oz"},
        {"Simple syrup (1:1) or sugar cube", 0.25, "oz"},
        {"Angostura bitters", 2.0, "dashes"}
    };

    r.steps = {
        "Add sugar (or syrup) and bitters to a mixing glass or directly to the serving glass.",
        "Add whiskey and stir to combine.",
        "Add ice (large cube preferred) and stir briefly to chill.",
        "Express an orange peel over the drink, garnish, and serve."
    };

    r.glass = "Rocks glass";
    r.garnish = {"Orange peel twist", "Optional: cocktail cherry"};

    return r;
}
