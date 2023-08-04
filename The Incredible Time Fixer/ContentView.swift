//
//  ContentView.swift
//  The Incredible Time Fixer
//
//  Created by Panagiotis Peikidis on 8/3/23.
//

import SwiftUI

struct ContentView: View, DropDelegate {
    @State private var isFirstStep: Bool = true
    
    var body: some View {
        VStack {
            if isFirstStep {
                VStack {
                Text("Choose two photos from two different cameras that are shot more or less at the same time. \nThe closer they are in time, the better.")
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 400)
                Text("Drop Files Here")
                    .fontWeight(Font.Weight.bold)
                    .font(.title)
                    .padding(120)
                    .background()
                    .cornerRadius(20)
                    .foregroundColor(Color.init(red: 0.3, green: 0.3, blue: 0.3))
                    .frame(width: 400, height: 260)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.init(red: 0.3, green: 0.3, blue: 0.3), style: StrokeStyle(lineWidth: 5, dash: [10]))
                    )
                    .onDrop(of: [(kUTTypeFileURL as String)], delegate: self)
                }.padding(20)
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
        }
    }
    
    func performDrop(info: DropInfo) -> Bool {
        guard let itemProvider = info.itemProviders(for: [(kUTTypeFileURL as String)]).first else { return false }
        
        itemProvider.loadItem(forTypeIdentifier: (kUTTypeFileURL as String), options: nil) {item, error in
            guard let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) else { return }
            // Do something with the file url
            // remember to dispatch ono main in case of a @State change
            print(url)
            isFirstStep = false
        }
        
        return true
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
