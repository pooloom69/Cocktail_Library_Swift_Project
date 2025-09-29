#ifndef FLAVOR_UTILS_H
#define FLAVOR_UTILS_H

#include "Recipe.h"
#include <map>
#include <string>
#include <vector>

// Canonical flavor keys we’ll compute
inline const std::vector<std::string>& canonicalFlavorKeys() {
    static const std::vector<std::string> KEYS = {
        "citrus", "sweet", "spirit-forward", "refreshing"
    };
    return KEYS;
}

// Compute a numeric flavor profile (0..1) derived from ingredients & metadata.
// Does NOT modify the Recipe; returns a map of canonical flavor -> intensity.
std::map<std::string, double> computeFlavorProfile(const Recipe& r);

// Average a set of flavor profiles (by canonical keys).
std::map<std::string, double> averageFlavorProfile(const std::vector<Recipe>& recipes);

// Pretty-print a flavor profile.
void printFlavorProfile(const std::map<std::string,double>& profile, const std::string& title = "");

// Side-by-side compare two profiles (same keys).
void compareFlavorProfiles(const std::map<std::string,double>& a,
                           const std::map<std::string,double>& b,
                           const std::string& labelA,
                           const std::string& labelB);

#endif
