//
//  SplashView.swift
//  journal
//
//  Created by layan alshehri on 30/05/1448 AH.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
    Color("BackgroundPrimary")
                .ignoresSafeArea()
            VStack{
                Image("splashNotebook")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 81)
                Text("Journali")
                      .font(.system(size: 42, weight: .black))
                      .foregroundColor(.white)

                  Text("Your thoughts, your story")
                      .font(.system(size: 18, weight: .light))
                      .foregroundColor(.white)
            }
        }
        }
    }
#Preview {
    SplashView()
}
