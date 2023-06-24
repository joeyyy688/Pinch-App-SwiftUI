//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Joseph on 6/23/23.
//

import SwiftUI

struct InfoPanelView: View {
    var scale: CGFloat
    var offset: CGSize
    
    @State var isInfoPanelVisibile: Bool = true
    
    var body: some View {
        HStack {
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1){
                    withAnimation(.spring()){
                        isInfoPanelVisibile.toggle()
                    }
                }
            
            Spacer()
            
            HStack(spacing: 2){
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
                
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                    
                Spacer()
            } //: HSTACK
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(7)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisibile ? 1: 0)
            
            
            Spacer()
        }//: HSTACK
        
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offset: CGSize(width: 1.0, height: 1.0))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
