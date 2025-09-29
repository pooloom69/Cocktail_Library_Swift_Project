import SwiftUI



struct LibraryView: View {

    
    @State private var searchText = ""
    @State private var selectedTab = "All"
    let tabs = ["All", "MyRecipe", "Favorite", "Popular"]

    var body: some View {
        VStack(spacing: 16) {
            // Title
            Text("Cocktail Library")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            // Search bar
            LibrarySearchBar(text: $searchText)
            
            // Tabs
            Picker("Tabs", selection: $selectedTab) {
                ForEach(tabs, id: \.self) { tab in
                    Text(tab).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            // Content changes based on tab
            Group {
                if selectedTab == "All" {
                    Text("All Recipes")
                } else if selectedTab == "MyRecipe" {
                    Text("My Recipes")
                } else if selectedTab == "Favorite" {
                    Text("Favorite Recipes")
                } else {
                    Text("Popular Recipes")
                }
            }
            .padding(.top)

            Spacer()
            
        }
        .padding(.horizontal)
        
    }
}

// 🔍 Search Bar component
struct LibrarySearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

