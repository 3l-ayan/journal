import SwiftUI
struct SplashView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0, green: 0, blue: 0),
                    Color(red: 11/255, green: 11/255, blue: 18/255),
                    Color(red: 21/255, green: 21/255, blue: 23/255)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
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
