import SwiftUI

struct HomeView: View {
    @AppStorage("empactScore") var currentScore = 0
    @State private var selectedTab = 0
    @State private var showMoreSheet = false
    @State private var showQMSheet = false
    @Binding var isHappy: Bool
    
    private var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    var body: some View {
        
        VStack(spacing: -50) {
                    HStack {
                        Spacer()
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: isIpad ? 60 : 40))
                            .foregroundStyle(.white)
                            .padding()
                            .onTapGesture {
                                showQMSheet.toggle()
                            }
                    }
                    .padding(.trailing, isIpad ? 30 : 10)
                    .padding(.top, isIpad ? 30 : 10)
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                    .sheet(isPresented: $showQMSheet) {
                              AboutEmpactSheet()
                            .presentationDetents([.fraction(0.5)])  
                          }
                
                    HStack(spacing: 0) {
                        if !isHappy {
                            BrainView()
                                .frame(height: UIScreen.main.bounds.height * 0.5)
                                .offset(y: -0.09 * UIScreen.main.bounds.height)
                        } else {
                            HappyBrainView(isHappy: $isHappy)
                                .frame(height: UIScreen.main.bounds.height * 0.5)
                                .offset(y: -0.09 * UIScreen.main.bounds.height)
                        }
                    }
                    
                    HStack(spacing: 0) {
                        EmpactBarView(currentScore: currentScore)
                            .offset(y: isIpad ? -0.12 * UIScreen.main.bounds.height : -0.16 * UIScreen.main.bounds.height)
                    }
                    
                    HStack(spacing: 0) {
                        ChallengesView(empactScore: currentScore, isHappy: $isHappy)
                            .offset(y: -0.07 * UIScreen.main.bounds.height)
                    }
                    
                    Spacer()
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue.ignoresSafeArea(.all))
            }
        }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentScore: 50, isHappy: .constant(true))
    }
}



