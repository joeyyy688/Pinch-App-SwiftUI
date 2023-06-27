//
//  PageModel.swift
//  Pinch
//
//  Created by Joseph on 6/27/23.
//

import Foundation

struct Page: Identifiable{
    let id: Int
    let imageName: String
}


extension Page{
    var thumbNailName: String {
        return "thumb-" + imageName
    }
}
