import SwiftUI

struct AboutEmpactSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showWhyEmpactSheet = false
    @State private var showAboutMeSheet = false
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .padding(.top, 10)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Text("About Empact")
                .font(.title)
                .foregroundStyle(.black)
                .bold()
                .padding(.top, -40)
            
            Divider()

        
            Button("Why I made Empact?") {
                showWhyEmpactSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .foregroundColor(.white)
            .padding(.top, 30)
            .frame(width: .infinity, height: 60)
            .font(.system(size: 22, weight: .bold))

            Button("About Me") {
                showAboutMeSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .foregroundColor(.white)
            .frame(width: .infinity, height: 60)
            .font(.system(size: 22, weight: .bold))
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .sheet(isPresented: $showWhyEmpactSheet) {
            WhyEmpactSheetView()
        }
        .sheet(isPresented: $showAboutMeSheet) {
            AboutMeSheetView()
        }
    }
}

struct WhyEmpactSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .padding(.top, UIScreen.main.bounds.height * 0.03)
                        .padding(.trailing, 20)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
                Text("Why I Made Empact?")
                    .font(.title)
                    .foregroundStyle(.black)
                    .bold()
                    .padding(.top, -UIScreen.main.bounds.height * 0.025)
            
            Divider()
                
                Text("Last school year, I participated in the 'Value Orientation Project' at a local community center called 'Centrum Rodiny Dúbravka' in my hometown, Bratislava, Slovakia. I really liked the idea behind this project, so I decided to create an app that encourages people to help — not just others, but themselves too. I believe that when you feel good about yourself, you can offer even better help to those around you. (Btw, I was inspired by the Pou app, which was one of my favorite apps when my dad got our family an iPad in 2011.)")
                    .foregroundStyle(.black)
                    .padding()
                    .padding(.horizontal, 20)

                
                Spacer()
        }
        .background(Color.white)
    }
}


struct AboutMeSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .padding(.top, UIScreen.main.bounds.height * 0.03)
                        .padding(.trailing, 20)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
                Text("About me")
                    .font(.title)
                    .foregroundStyle(.black)
                    .bold()
                    .padding(.top, -UIScreen.main.bounds.height * 0.025)
            
            Divider()
            VStack{
                Text("Hi, I’m a 19-year-old high school student from Bratislava, Slovakia. I’m passionate about computer science and new technologies. When I heard about this challenge, I decided to give it a try and learn something new. Since I only knew how to program in Python, I started watching Swift online courses and taught myself how to code in Swift.")
                Text(" I also love learning new languages and hope to study at a German university, as I attend a German-bilingual class in high school.")
                
                Text("I also have been playing football for around 12 years. One of the biggest lessons football has taught me is that teamwork and helping each other are essential for achieving the best results. I apply this mindset to my daily life — and that’s exactly what Empact is about. I hope you enjoy my app! :)")
            }
                    .foregroundStyle(.black)
                    .padding()
                    .padding(.horizontal, 20)
                
                Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    AboutEmpactSheet()
}

