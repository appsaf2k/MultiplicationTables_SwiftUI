//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by @andreev2k on 07.09.2022.
//

import SwiftUI

struct TextMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("", size: 70))
            .frame(width: 100, height: 150)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .shadow(color: .white, radius: 10, x: 0, y: 0)
    }
}

extension View {
    func textStyle() -> some View {
        modifier(TextMod())
    }
}

struct MainView: View {
    @State private var number1 = Int.random(in: 2...12)
    @State private var number2 = Int.random(in: 2...12)
    @State private var showValue = false
    @State private var textTitle = ""
    
    var arrNumber = [2,3,4,5,6,7,8,9,10,11,12]
    
    static var number = [Int.random(in: 2...138), Int.random(in: 2...138)]
    
    var multiply: Int {
        let multi = number1 * number2
        return multi
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack(spacing: 60) {
                HStack(spacing: 30) {
                    Section {
                        Text("\(number1)")
                            .foregroundStyle(.orange)
                            .textStyle()
                    }
                    
                    Section {
                        Text("X")
                            .font(.custom("", size: 50))
                            .foregroundStyle(.orange)
                    }
                    
                    Section {
                        Text("\(number2)")
                            .foregroundStyle(.orange)
                            .textStyle()
                }
                }
                
                Button(showValue ? "Обновить" : "Варианты ответов") {
                    showValue.toggle()
                    restart()
                    textTitle = ""
                }
                    .font(.custom("", size: 20))
                    .foregroundStyle(showValue ? .orange : .green)
                    .frame(width: 250, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .shadow(color: .white, radius: 10, x: 0, y: 0)
                
                ZStack {
                    Text("\(multiply)")
                        .foregroundStyle(.green)
                        .font(.custom("", size: 40))
                        .frame(width: 110, height: 90)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(color: .green, radius: 10, x: 0, y: 0)
                        .opacity(showValue ? 1 : 0)
                        .opacity(textTitle == "Правильно" ? 1 : 0)
                        
                    HStack {
                        ForEach(MainView.number, id: \.self) { i in
                            Button {
                                if i == multiply {
                                    textTitle = "Правильно"
                                } else {
                                    textTitle = "Не правильно"
                                }
                            } label: {
                                Text("\(i)")
                                    .foregroundStyle(textTitle == "Правильно" ? .green : .red)
                                    .font(.custom("", size: 40))
                                    .frame(width: 110, height: 90)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(20)
                                    .shadow(color: textTitle == "Не правильно" ? .red : .white, radius: 10, x: 0, y: 0)
                                    .opacity(showValue ? 1 : 0)
                                    .opacity(textTitle == "Правильно" ? 0 : 1)
                            }
                        }
                        .disabled(showValue == false || textTitle == "Правильно" || textTitle == "Не правильно")
                    }
                }
                
                Text(textTitle)
                    .font(.custom("", size: 40))
                    .foregroundStyle(textTitle == "Правильно" ? .green : .red)
                    .frame(width: 300, height: 100)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(color: textTitle == "Правильно" ? .green : .red, radius: 10, x: 0, y: 0)
                    .animation(.default)
                
            }
        } .ignoresSafeArea()
    }
    
    func restart() {
        if showValue == true {
            MainView.number.append(multiply)
            MainView.number.shuffle()
        } else {
            number1 = Int.random(in: 2...12)
            number2 = Int.random(in: 2...12)
            MainView.number.removeLast()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
