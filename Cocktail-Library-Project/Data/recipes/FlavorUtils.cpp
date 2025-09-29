#include "FlavorUtils.h"
#include <algorithm>
#include <cctype>
#include <iostream>
#include <iomanip>

// --- helpers ---
static std::string lower(std::string s) {
    std::transform(s.begin(), s.end(), s.begin(),
                   [](unsigned char c){ return std::tolower(c); });
    return s;
}

static bool containsWord(const std::string& hay, const std::vector<std::string>& needles) {
    auto h = lower(hay);
    for (const auto& n : needles) {
        if (h.find(lower(n)) != std::string::npos) return true;
    }
    return false;
}

static bool isAlcoholic(const std::string& name) {
    // lightweight heuristic
    static const std::vector<std::string> alc = {
        "tequila","rum","gin","vodka","whisk","bourbon","rye",
        "brandy","cognac","mezcal","pisco","liqueur","amaro","vermouth"
    };
    return containsWord(name, alc);
}

static bool isCitrusJuice(const std::string& name) {
    static const std::vector<std::string> citrus = {
        "lime", "lemon", "grapefruit", "orange", "yuzu", "citron"
    };
    return containsWord(name, citrus) && name.find("juice") != std::string::npos;
}

static bool isSweetener(const std::string& name) {
    static const std::vector<std::string> sweets = {
        "simple", "syrup", "agave", "honey", "demerara", "maple", "grenadine", "orgeat"
    };
    return containsWord(name, sweets);
}

static bool isOrangeLiqueur(const std::string& name) {
    static const std::vector<std::string> ol = {
        "cointreau","triple sec","curaçao","curacao","grand marnier","orange liqueur"
    };
    return containsWord(name, ol);
}

// Clamp helper
static double clamp01(double x) { return std::max(0.0, std::min(1.0, x)); }

// --- public API ---
std::map<std::string, double> computeFlavorProfile(const Recipe& r) {
    double totalVol = 0.0;
    double alcVol   = 0.0;
    double citrusOz = 0.0;
    double sweetOz  = 0.0;

    for (const auto& ing : r.ingredients) {
        totalVol += ing.amount;

        if (isAlcoholic(ing.name)) {
            // assume 40% ABV for base spirits; 20–40% for liqueurs – we’ll approximate 35% if it says liqueur
            double assumedABV = (lower(ing.name).find("liqueur") != std::string::npos) ? 0.35 : 0.40;
            alcVol += ing.amount * assumedABV;
        }

        if (isCitrusJuice(ing.name)) {
            citrusOz += ing.amount;
        }

        if (isSweetener(ing.name)) {
            sweetOz += ing.amount;
        } else if (isOrangeLiqueur(ing.name)) {
            // orange liqueurs add perceived sweetness; weight as ~0.5 of their volume
            sweetOz += 0.5 * ing.amount;
        }
    }

    // Normalize by total
    double citrus = (totalVol > 0.0) ? clamp01(citrusOz / totalVol) : 0.0;
    double sweet  = (totalVol > 0.0) ? clamp01(sweetOz  / totalVol) : 0.0;

    // Spirit-forward: alcoholic fraction pre-dilution
    double spiritForward = (totalVol > 0.0) ? clamp01(alcVol / totalVol) : 0.0;

    // Refreshing: heuristic mix of citrus + lower spirit-forward + served with ice
    bool hasFreshIce = containsWord(r.ice, {"over fresh", "rocks", "over ice", "cubed"});
    double refreshing = clamp01(0.55 * citrus + 0.25 * (1.0 - spiritForward) + (hasFreshIce ? 0.20 : 0.10));

    return {
        {"citrus", citrus},
        {"sweet", sweet},
        {"spirit-forward", spiritForward},
        {"refreshing", refreshing}
    };
}

std::map<std::string, double> averageFlavorProfile(const std::vector<Recipe>& recipes) {
    std::map<std::string, double> acc;
    if (recipes.empty()) return acc;

    // init zeros
    for (const auto& k : canonicalFlavorKeys()) acc[k] = 0.0;

    for (const auto& r : recipes) {
        auto p = computeFlavorProfile(r);
        for (const auto& k : canonicalFlavorKeys()) {
            auto it = p.find(k);
            if (it != p.end()) acc[k] += it->second;
        }
    }

    for (auto& kv : acc) kv.second = kv.second / static_cast<double>(recipes.size());
    return acc;
}

void printFlavorProfile(const std::map<std::string,double>& profile, const std::string& title) {
    if (!title.empty()) std::cout << title << "\n";
    for (const auto& k : canonicalFlavorKeys()) {
        auto it = profile.find(k);
        double v = (it != profile.end()) ? it->second : 0.0;
        std::cout << "  - " << k << ": " << std::fixed << std::setprecision(2) << v << "\n";
    }
    std::cout << "\n";
}

void compareFlavorProfiles(const std::map<std::string,double>& a,
                           const std::map<std::string,double>& b,
                           const std::string& labelA,
                           const std::string& labelB) {
    std::cout << "Flavor comparison (" << labelA << " vs " << labelB << ")\n";
    std::cout << std::left << std::setw(18) << "Flavor"
              << std::right << std::setw(10) << labelA
              << std::right << std::setw(10) << labelB
              << std::right << std::setw(10) << "Δ(B-A)"
              << "\n";

    std::cout << std::string(48, '-') << "\n";
    for (const auto& k : canonicalFlavorKeys()) {
        double va = a.count(k) ? a.at(k) : 0.0;
        double vb = b.count(k) ? b.at(k) : 0.0;
        std::cout << std::left  << std::setw(18) << k
                  << std::right << std::setw(10) << std::fixed << std::setprecision(2) << va
                  << std::right << std::setw(10) << std::fixed << std::setprecision(2) << vb
                  << std::right << std::setw(10) << std::fixed << std::setprecision(2) << (vb - va)
                  << "\n";
    }
    std::cout << "\n";
}
