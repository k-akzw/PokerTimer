//
//  ContentView.swift
//  PokerTimer
//
//  Created by Kento Akazawa on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = Model.shared
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            if model.showButton {
                Button(action: {
                    model.isPaused = false
                    model.showButton = false
                }, label: {
                    Text("Start")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 100))
                })
                .frame(width: 280, height: 120)
                .background(.green)
                .cornerRadius(20.0)
            } else {
                VStack {
                    Spacer(minLength: 50)
                    HStack {
                        Spacer()
                        if model.chipChange {
                            Text("Chip Change")
                                .foregroundColor(.red)
                                .font(.system(size: 32))
                        }
                    }
                    Spacer(minLength: 10)
                    if model.isBreak {
                        Text("Break Time")
                            .foregroundColor(.red)
                            .font(.system(size: 128))
                    } else {
                        
                        Spacer()
                        
                        Text("\(model.timeText)")
                            .font(.system(size: 120))
                        
                        Spacer(minLength: 5)
                        
                        HStack {
                            Spacer()
                            
                            VStack {
                                Text("Small Blind")
                                    .font(.system(size: 64))
                                Text("\(model.bigBlind/2)")
                                    .font(.system(size: 64))
                            }
                            
                            Spacer(minLength: 5)
                            
                            VStack {
                                Text("Big Blind")
                                    .font(.system(size: 64))
                                Text("\(model.bigBlind)")
                                    .font(.system(size: 64))
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .foregroundColor(.white)
        .onTapGesture {
            if model.isBreak {
                model.isBreak = false
            } else {
                model.isPaused.toggle()
            }
        }
    }
}

struct BackgroundView: View {
    
    @ObservedObject var model = Model.shared
    
    var body: some View {
        Image(getImageName())
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    func getImageName() -> String {
        var imageName = model.imageName
        if model.isBreak {
            imageName = "yusei1"
        } else if imageName == "" {
            imageName = "background"
        }
        return imageName
    }
}

//#Preview {
//    ContentView()
//}
