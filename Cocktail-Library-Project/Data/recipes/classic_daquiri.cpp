#include "Recipe.h"

Recipe daiquiriRecipe() {
    Recipe r;
    r.id    = "daiquiri_classic";
    r.name  = "Daiquiri";
    r.base  = "Rum";
    r.style = "Classic sour";
    r.flavors = {"citrus", "refreshing", "bright"};
    r.abv   = 20.0;
    r.ice   = "Shake with ice, serve up";

    r.ingredients = {
        {"White rum", 2.0, "oz"},
        {"Fresh lime juice", 1.0, "oz"},
        {"Simple syrup (1:1)", 0.75, "oz"}
    };

    r.steps = {
        "Add rum, lime juice, and simple syrup to a shaker with ice.",
        "Shake hard for about 10–12 seconds until chilled.",
        "Fine-strain into a chilled coupe glass.",
        "Garnish and serve."
    };

    r.glass = "Coupe";
    r.garnish = {"Lime wheel (optional)"};

    return r;
}
