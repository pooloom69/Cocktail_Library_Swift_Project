import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "book.fill")
                }
            
            CreateNew()
                .tabItem {
                    Label("Create", systemImage: "plus.circle.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
