import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false

    let pages = [
        OnboardingPageData(
            imageName: "img-0",
            title: "Welcome to",
            subtitle: "PlayMakerFit",
            description: "Simple tool to organize your fitness journey with ease!"
        ),
        OnboardingPageData(
            imageName: "img-1",
            title: "Built on",
            subtitle: "Blocks",
            description: "Design your path: simple exercises build workouts, workouts shape plans."
        ),
        OnboardingPageData(
            imageName: "img-2",
            title: "Stay on",
            subtitle: "Track",
            description: "Use timers to guide you through your workouts and track your progress effortlessly."
        ),
        OnboardingPageData(
            imageName: "img-3",
            title: "Get",
            subtitle: "Discounts",
            description: "Generate a QR code in the settings tab to get exclusive discounts at your gym!"
        ),
        OnboardingPageData(
            imageName: "img-4",
            title: "Track",
            subtitle: "History",
            description: "View your workout and training history to see how far you've come."
        ),
        OnboardingPageData(
            imageName: "img-5",
            title: "Have fun and",
            subtitle: "Good Luck!",
            description: "We hope you enjoy using Gym Planning App. Let's crush those fitness goals!"
        )
    ]

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    OnboardingPage(data: pages[index])
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

            // Navigation buttons
            HStack {
                if currentPage < pages.count - 1 {
                    Button("Skip") {
                        completeOnboarding()
                    }
                    .padding()
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                }

                Spacer()

                Button(currentPage == pages.count - 1 ? "Get Started" : "Next") {
                    if currentPage == pages.count - 1 {
                        completeOnboarding()
                    } else {
                        currentPage += 1
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                .animation(.spring(), value: currentPage)
            }
            .padding()
        }
    }

    private func completeOnboarding() {
        hasSeenOnboarding = true
        presentationMode.wrappedValue.dismiss()
    }
}

struct OnboardingPage: View {
    let data: OnboardingPageData

    var body: some View {
        VStack {
            Spacer()
            Text(data.title)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
            Text(data.subtitle)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.cyan)
                .padding(.top, 1)
            Image(data.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 280)
                .padding()
            Text(data.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .padding()
    }
}

struct OnboardingPageData {
    let imageName: String
    let title: String
    let subtitle: String
    let description: String
}

#Preview {
    OnboardingView()
}
