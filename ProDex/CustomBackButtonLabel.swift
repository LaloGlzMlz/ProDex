//
//  CustomBackButtonLabel.swift
//  ProDex
//
//  Created by Eduardo Gonzalez Melgoza on 23/11/23.
//

import Foundation
import SwiftUI

struct CustomBackButtonLabel: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
            Text("Back to List")
        }
        .onTapGesture {
            // Handle back button tap
        }
    }
}
