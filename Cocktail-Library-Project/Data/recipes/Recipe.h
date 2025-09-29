#ifndef RECIPE_H
#define RECIPE_H

#include <string>
#include <vector>

// Ingredient structure
struct Ingredient {
    std::string name;
    double amount;   // in oz
    std::string unit;
};

// Recipe structure
struct Recipe {
    std::string id;
    std::string name;
    std::string base;
    std::string style;
    std::vector<std::string> flavors;
    double abv;
    std::string ice;
    std::vector<Ingredient> ingredients;
    std::vector<std::string> steps;
    std::string glass;
    std::vector<std::string> garnish;
};

// Function declarations
Recipe margaritaRecipe();
Recipe daiquiriRecipe();
Recipe dirtyMartiniRecipe();
Recipe oldFashionedRecipe();
void printRecipe(const Recipe& r);

#endif