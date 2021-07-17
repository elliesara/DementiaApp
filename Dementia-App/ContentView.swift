//
//  ContentView.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/10/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let appState = AppState()
    
    init() {
        configureAppearance()
    }
    
    var body: some View {
        
        if appState.reset == .reset {
            MockedData()
        }
        
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            ReportsView()
                .tabItem {
                    Image(systemName: "doc.on.clipboard")
                    Text("Reports")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
    
    private func configureAppearance() {
        configureTableViewAppearance()
//        configureNavigationBarAppearance()
    }
    
    private func configureTableViewAppearance() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().tableFooterView = UIView()
    }
    
    private func configureNavigationBarAppearance() {
        // Not the same as manipulating the proxy directly
        let appearance = UINavigationBarAppearance()
        // This overrides everything we set up earlier
        appearance.configureWithTransparentBackground()
        // We make sure to apply the style for good
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
