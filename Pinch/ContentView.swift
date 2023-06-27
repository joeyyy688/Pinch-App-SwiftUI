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
    @State private var isDrawerOpen: Bool = false
    @State private var pageIndex: Int = 1
    
    
    
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
                
                Image(pagesData[pageIndex - 1].imageName)
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
            .overlay(alignment: .topTrailing, content: {
                HStack(spacing: 12) {
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" :  "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .foregroundStyle(.secondary)
                        .padding(8)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1), {
                                isDrawerOpen.toggle()
                            })
                        }
                    
                    Group {
                        
                        ForEach(pagesData, content: { item in
                            Image(item.thumbNailName)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10.0)
                                .frame(height: 120)
                                .shadow(radius: 4)
                                .opacity(isDrawerOpen ? 1 : 0)
                                .animation(.easeInOut(duration: 0.3), value: isDrawerOpen)
                                .onTapGesture {
                                    pageIndex = item.id
                                }
                        })
                        
                        Spacer()
                    }

                }//: DRAWER
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .background(.ultraThinMaterial)
                .cornerRadius(14)
                .frame(width: 240)
                .padding(.top, UIScreen.main.bounds.width / 6)
                .offset(x: isDrawerOpen ? 20 : 200)
                .opacity(isAnimating ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: isAnimating)
                
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
