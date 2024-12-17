//
//  NewDocumentCell.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

struct NewDocumentCell: View {
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "document.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.black.opacity(0.3))
                    .frame(width: 80, height: 80)

                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                    .padding(.top, 32)
            }

            Text("Создать новый документ")
                .font(.caption.bold())
                .multilineTextAlignment(.center)
        }
        .frame(width: 150, height: 150, alignment: .center)
        .offset(x: 0, y: -8)
    }
}

#Preview {
    NewDocumentCell()
}
