
import SwiftUI
import Lottie

struct SplashView: View {
    
    @State private var isActive = false
    @State private var animate = false
    
    var body: some View {
        ZStack {
            if isActive {
                HomeView()
            } else {
                splashContent
            }
        }
        .onAppear {
            animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeOut(duration: 0.5)) {
                    isActive = true
                }
            }
        }
    }
    
    private var splashContent: some View {
        ZStack {
            LinearGradient(
                colors: [.black, .yellow],
                startPoint: .trailing,
                endPoint: .leading
            )
            .frame(width: UIScreen.main.bounds.width * 1.5,
                   height: UIScreen.main.bounds.height * 1.5)
            .offset(x: animate ? -40 : 40)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                LottieView(name: "splash")
                    .frame(width: 250, height: 250)
                
                Text("AJWA")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .opacity(0.9)
            }
        }
    }	
}
