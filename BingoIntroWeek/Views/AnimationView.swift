import SwiftUI

struct AnimatedIntroView: View {
    @State private var topBlockOffset: CGFloat = -500
    @State private var bottomBlockOffset: CGFloat = 500
    @State private var logoOpacity: Double = 0.0
    @State private var bingoOpacity: Double = 0.0
    @State private var expandPrimaryBlock: Bool = false
    @Binding var showIntroView: Bool // Controlled by ContentView

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            // Expanding Top-left block
            RoundedRectangle(cornerRadius: expandPrimaryBlock ? 0 : 40)
                .fill(AppColors.primary)
                .frame(
                    width: expandPrimaryBlock ? UIScreen.main.bounds.width * 1.2 : 450, // Reduce excessive scaling
                    height: expandPrimaryBlock ? UIScreen.main.bounds.height * 1.2 : 330
                )
                .rotationEffect(.degrees(expandPrimaryBlock ? 0 : -30))
                .offset(
                    x: expandPrimaryBlock ? 0 : topBlockOffset,
                    y: expandPrimaryBlock ? 0 : topBlockOffset
                )
                .zIndex(3)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1)) {
                        topBlockOffset = -250
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 1)) {
                            expandPrimaryBlock = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showIntroView = true // Switch to IntroView
                        }
                    }
                }

            // Bottom-right block
            RoundedRectangle(cornerRadius: 40)
                .fill(AppColors.secondary)
                .frame(width: 500, height: 250)
                .rotationEffect(.degrees(-30))
                .offset(x: bottomBlockOffset, y: bottomBlockOffset)
                .zIndex(0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1)) {
                        bottomBlockOffset = 250
                    }
                }

            VStack(spacing: 10) {
                // Fontys Logo
                Image("fontys")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .opacity(logoOpacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).delay(1)) {
                            logoOpacity = 1.0
                        }
                    }

                // "BINGO" Text
                Text("BINGO")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.primary)
                    .opacity(bingoOpacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).delay(1)) {
                            bingoOpacity = 1.0
                        }
                    }
            }
            .zIndex(2)
        }
    }
}

#Preview {
    AnimatedIntroView(showIntroView: .constant(false))
}
