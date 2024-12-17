//
//  WelcomeView.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 18/12/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Не успел отсканировать паспорт, а документ нужен уже сейчас?")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text("Не беда! В этом приложении ты можешь легко создать PDF-документ из фотографий в твоей галерее.")
                .font(.body)
                .foregroundColor(.secondary)

            Text("Все документы, с которыми ты работал ранее, хранятся здесь же, поэтому ты всегда можешь к ним вернуться.")
                .font(.body)
                .foregroundColor(.secondary)

            Text("Кроме того, ты можешь:")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            VStack(alignment: .leading, spacing: 5) {
                Text("• Отправлять документы напрямую через социальные сети или электронную почту.")
                    .font(.body)
                    .foregroundColor(.secondary)

                Text("• Сохранять файлы на своем телефоне для быстрого доступа в любое время.")
                    .font(.body)
                    .foregroundColor(.secondary)
            }

            Text("В общем, тут все просто! Создание, отправка и управление документами — и все в одном месте. Пошли создавать документ!")
                .padding(.top, 12)
                .font(.body)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding()
        .padding(.top, 30)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

#Preview {
    WelcomeView()
}
