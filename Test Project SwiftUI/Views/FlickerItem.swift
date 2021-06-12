//
//  FlickerItem.swift
//  Test Project SwiftUI
//
//  Created by Admin on 09/06/2021.
//

import SwiftUI

struct FlickerItem: View {
    let urlString: String
    var body: some View {
        VStack{
            RemoteImage(urlString: urlString)
                .frame(minWidth: 120, maxWidth: 160, minHeight: 120, maxHeight: 160, alignment: .center)
        }
    }
}

struct FlickerItem_Previews: PreviewProvider {
    static var previews: some View {
        FlickerItem(urlString: "https://cdn.sstatic.net/Sites/stackoverflow/Img/favicon.ico?v=ec617d715196")
    }
}
