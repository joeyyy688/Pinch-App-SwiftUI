//
//  ControlImageView.swift
//  Pinch
//
//  Created by Joseph on 6/24/23.
//

import SwiftUI

struct ControlImageView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: 36))
            
    }
}

struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(iconName: "arrow.up.left.and.down.right.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
