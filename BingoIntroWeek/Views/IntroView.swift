import SwiftUI
import SDWebImageSwiftUI
//import SDWebImageSwiftUI

struct PageView: View {
    var page: Page
    
    var body: some View {
        VStack(spacing: 10) {
            Text(page.name)
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            Text(page.description)
                .font(.subheadline)
                .frame(width: 300)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
                .foregroundColor(.white)
            
            if let gifURL = page.gifURL {
                AnimatedImage(url: gifURL)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding()
                    .cornerRadius(30)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .padding()
            } else {
                Text("GIF not found")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(AppColors.primary)
        .cornerRadius(20)
        .padding()
    }
}

struct IntroView: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages.filter { $0.gifURL != nil }
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        NavigationStack {
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    VStack {
                        Spacer()
                        PageView(page: page)
                        Spacer()
                        if page == pages.last {
                            NavigationLink(destination: BingoView()) {
                                Text("Start")
                                    .font(.title3.bold())
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 12)
                                    .background(AppColors.secondary)
                                    .clipShape(Capsule())
                                    .padding(.bottom, 10)
                            }
                        } else {
                            Button("Next", action: incrementPage)
                                .font(.title3.bold())
                                .foregroundColor(.white)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 12)
                                .background(AppColors.secondary)
                                .clipShape(Capsule())
                                .padding(.bottom, 10)
                        }
                        NavigationLink(destination: BingoView()) {
                            Text("Skip")
                                .buttonStyle(.bordered)
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                        Spacer()
                    }
                    .tag(page.tag)
                }
            }
            .animation(.easeInOut, value: pageIndex)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .white
                dotAppearance.pageIndicatorTintColor = .gray
            }
            .background(AppColors.primary.ignoresSafeArea())
        }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

