import SwiftUI

struct ChallengesView: View {
    @StateObject var store = ChallengeStore()
    @StateObject private var streakManager = StreakManager()
    @State private var selectedChallenge = UserDefaults.standard.integer(forKey: "selectedChallenge")
    @State private var showMoreSheet = false
    @AppStorage("empactScore") var empactScore = 0
    @Binding var isHappy: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {

                TabView(selection: $selectedChallenge) {
                    ForEach(store.selectedChallenges.indices, id: \.self) { index in
                        VStack {
                            RoundedRectangle(cornerRadius: geometry.size.width < 600 ? 35 : 50)
                                .frame(
                                    width: geometry.size.width * 0.85,
                                    height: geometry.size.width < 600 ? geometry.size.width * 0.60 : geometry.size.width * 0.40
                                )
                                .foregroundStyle(Color.white)
                                .shadow(radius: 10)
                                .overlay(
                                    VStack(spacing: geometry.size.width < 600 ? 10 : 15) {
                                        Text(store.selectedChallenges[index].name)
                                            .font(.system(size: geometry.size.width < 600 ? 22 : 32))
                                            .foregroundColor(.black)
                                            .bold()
                                        Divider()
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text("Category: \(store.selectedChallenges[index].category)")
                                            Text("Time: ⏳ \(store.selectedChallenges[index].time)")
                                            Text("Empact score: 🧠  + \(store.selectedChallenges[index].empactScore) ")
                                        }
                                        .font(.system(size: geometry.size.width < 600 ? 16 : 26))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                        Button(action: {
                                            showMoreSheet.toggle()
                                        }) {
                                            Text("More Info")
                                                .font(.system(size: geometry.size.width < 600 ? 18 : 24))
                                                .foregroundColor(.white)
                                                .frame(
                                                    width: UIDevice.isIpad ? UIScreen.main.bounds.width * 0.25 : UIScreen.main.bounds.width * 0.30,
                                                    height: UIDevice.isIpad ? UIScreen.main.bounds.height * 0.05 : UIScreen.main.bounds.height * 0.06)
                                                .background(Color.green)
                                                .cornerRadius(28)
                                        }
                                        .padding(.top, 12)
                                    }
                                    .padding(geometry.size.width < 600 ? 20 : 30)
                                    .padding(.top, 10)
                                )
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                HStack(spacing: geometry.size.width < 600 ? 8 : 15) {
                    ForEach(store.selectedChallenges.indices, id: \.self) { dotIndex in
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 2)
                            .frame(
                                width: geometry.size.width < 600 ? 12 : 20,
                                height: geometry.size.width < 600 ? 12 : 20
                            )
                            .background(
                                Circle().fill(selectedChallenge == dotIndex ? Color.white : Color.clear)
                            )
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedChallenge = dotIndex
                                }
                            }
                    }
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 16)
            .onChange(of: selectedChallenge) { newValue in
                UserDefaults.standard.set(newValue, forKey: "selectedChallenge")
            }
            .sheet(isPresented: $showMoreSheet) {
                if store.selectedChallenges.indices.contains(selectedChallenge) {
                    ChallengeDetailSheet(
                        challengeIndex: selectedChallenge,
                        empactScore: $empactScore,
                        isHappy: $isHappy,
                        store: store,
                        streakManager: streakManager
                    )
                }
            }
        }
    }
}




