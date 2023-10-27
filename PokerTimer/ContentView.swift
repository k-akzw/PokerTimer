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
            VStack {
                HStack {
                    Spacer()
//                    if model.chipChange {
                        Text("Chip Change")
                            .font(.system(size: 64))
                            .opacity(0)
//                    }
                }
                Spacer()
                if model.isBreak {
                    Text("Break Time")
                        .foregroundColor(.red)
                        .font(.system(size: 128))
                } else {

                    Spacer()

                    Text("\(model.timeText)")
                        .font(.system(size: 84))

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
            .ignoresSafeArea()
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
