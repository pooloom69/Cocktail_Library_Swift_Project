#include "Recipe.h"

Recipe dirtyMartiniRecipe() {
    Recipe r;
    r.id    = "dirty_martini_classic";
    r.name  = "Dirty Martini";
    r.base  = "Gin";  // swap to "Vodka" if you prefer
    r.style = "Spirit-forward stirred";
    r.flavors = {"spirit-forward", "briny", "savory", "herbal"}; // tags only; numeric profile comes from FlavorUtils
    r.abv   = 25.0;  // ~2.5 oz gin (40%), 0.5 oz dry vermouth (~16%), 0.5 oz brine, ~25% dilution ≈ ~25% in-glass
    r.ice   = "Stir with ice, serve up";

    r.ingredients = {
        {"Gin", 2.5, "oz"},                 // or "Vodka"
        {"Dry vermouth", 0.5, "oz"},
        {"Olive brine", 0.5, "oz"}
    };

    r.steps = {
        "Add gin, dry vermouth, and olive brine to a mixing glass with plenty of ice.",
        "Stir until very cold (about 20–30 seconds).",
        "Strain into a chilled martini or coupe glass.",
        "Garnish and serve."
    };

    r.glass = "Martini (cocktail) glass or Coupe";
    r.garnish = {"2–3 olives on a pick"};

    return r;
}
