//
//  ProfileView.swift
//  Cocktail-Library
//
//  Created by Sola Lhim on 9/10/25.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        TabView {
            // Home tab
            VStack {
                Text("Profile")
                    .font(.largeTitle)
                    .bold()
                    .padding()
            }


        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
