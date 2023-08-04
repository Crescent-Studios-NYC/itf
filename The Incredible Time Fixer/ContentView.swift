//
//  ContentView.swift
//  The Incredible Time Fixer
//
//  Created by Panagiotis Peikidis on 8/3/23.
//

import SwiftUI

struct ContentView: View, DropDelegate {
    @State private var isFirstStep: Bool = true
    @State private var isSecondStep: Bool = true
    @State private var isThirdStep: Bool = true
    
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
            } else if isSecondStep {
                VStack {
                    Text("Now drop the rest of the photos from the same camera as the left photo")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 500)
                    HStack(spacing: 20) {
                        VStack {
                            Rectangle()
                                .cornerRadius(30)
                                .foregroundColor(Color.black.opacity(0))
                                .frame(width: 200, height: 260)
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.init(red: 0.3, green: 0.3, blue: 0.3), lineWidth: 4)
                                )
                            Text("filename.jpg")
                        }
                        VStack {
                            Text("Drop Files Here")
                                .fontWeight(Font.Weight.bold)
                                .font(.title)
                                .cornerRadius(30)
                                .foregroundColor(Color.init(red: 0.3, green: 0.3, blue: 0.3))
                                .frame(width: 260, height: 260)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.init(red: 0.3, green: 0.3, blue: 0.3), style: StrokeStyle(lineWidth: 5, dash: [10]))
                                )
                                .onDrop(of: [(kUTTypeFileURL as String)], delegate: self)
                            Text(" ")
                        }

                    }.padding([.leading, .bottom, .trailing], 20)
                }
            } else if isThirdStep {
                VStack{
                    ZStack {
                        Image(systemName: "deskclock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                        Image(systemName: "syringe.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .offset(x: 80, y: -80)
                    }
                    Text("Fixing time...")
                }
                .frame(width: 400, height: 400)
                .padding(20)
                .onAppear(perform: {
                    withAnimation(Animation.spring().delay(3)) {
                        isThirdStep = false
                    }
                })
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
            if (isFirstStep)
            {
                isFirstStep = false
            }
            else if (isSecondStep)
            {
                isSecondStep = false
            }
        }
        
        return true
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
