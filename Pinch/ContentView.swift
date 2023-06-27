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
    
    
    
    func resetImageState(){
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color.clear
                
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
                            resetImageState()
                        }
                    })
                    .gesture(
                        DragGesture().onChanged{ gesture in
                            withAnimation(.linear(duration: 0.1)){
                                imageOffset = gesture.translation
                            }
                        }
                            .onEnded{ _ in
                                if imageScale <= 1{
                                    resetImageState()
                                }
                            }
                    )
                    .gesture(
                        MagnificationGesture().onChanged{ gesture in
                            withAnimation(.linear(duration: 0.1)){
                                if imageScale >= 1 && imageScale <= 5{
                                    imageScale = gesture
                                }else if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale < 1 {
                                    imageScale = 1
                                }
                            }
                        }
                            .onEnded{ gesture in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if  imageScale <= 1 {
                                    resetImageState()
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
            .overlay(alignment: .top ,content: {
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
            })
            .overlay(alignment: .bottom, content: {
                Group{
                    HStack{
                        Button(action: {
                            
                            withAnimation(.spring()){
                                if imageScale > 1{
                                    imageScale -= 1
                                    
                                    if imageScale <= 1{
                                        resetImageState()
                                    }
                                }
                                
                            }
                        }, label: {
                            ControlImageView(iconName: "minus.magnifyingglass")
                                
                        })
                        
                        Button(action: {
                            resetImageState()
                        }, label: {
                            ControlImageView(iconName: "arrow.up.left.and.down.right.magnifyingglass")
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()){
                                if imageScale < 5{
                                    imageScale += 1
                                    
                                    if imageScale < 5{
                                        imageScale = 5
                                    }
                                }
                            }
                            
                        }, label: {
                            ControlImageView(iconName: "plus.magnifyingglass")
                        })
                    }//: HSTACK
                    
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    
                }//: GROUP
                    .padding(.bottom, 20)
                
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
