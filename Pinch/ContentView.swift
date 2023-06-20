//
//  ContentView.swift
//  Pinch
//
//  Created by Joseph on 6/20/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10.0)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1{
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        }else {
                            withAnimation(.spring()){
                                imageScale = 1
                            }
                        }
                    })
                    
                    .gesture(
                        DragGesture().onChanged{ gesture in
                            withAnimation(.linear(duration: 0.1)){
                                imageOffset = gesture.translation
                            }
                        }
                            .onEnded{ _ in
                                if imageScale <= 2{
                                    imageOffset = .zero
                                }
                            }
                    )
                
            }//: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 0.2)){
                    isAnimating = true
                }
            })
        }//: NAVIGATION VIEW
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
