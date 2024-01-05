import SwiftUI

struct ContentView: View {
    @State private var countries = ["🇹🇷","🇧🇷", "🇨🇦", "🇩🇪", "🇪🇸", "🇫🇷", "🇬🇧", "🇮🇹", "🇯🇵", "🇺🇸"].shuffled()
    @State private var correctAnswer = ["Türkiye","Brazil","Canada","Germany","Spain","France","England","Italy","Japan","America"]
    
    @State private var userGuess = ""
    @State private var score = 0
    @State private var isCorrect = false
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Guess the Flag")
                .font(.largeTitle)
                .foregroundColor(.white)

            Spacer()

            Text(countries[0])
                .font(.system(size: 100))
                .gesture(
                    DragGesture()
                        .onChanged { _ in
                            // Bayrağı sürüklediğinizde başka bir bayrak göster
                            self.askQuestion()
                        }
                )

            TextField("Enter the country", text: $userGuess)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            Button("Check") {
                self.checkAnswer()
            }
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(50)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(isCorrect ? "Correct" : "Wrong Answer"))
            }

            Spacer()

            Text("Score: \(score)")
                .font(.largeTitle)
                .foregroundColor(.yellow)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: askQuestion)
    }

    func askQuestion() {
        countries.shuffle()
    }

    func checkAnswer() {
        isCorrect = false
        for index in 0..<countries.count {
            if userGuess == correctAnswer[index] {
                isCorrect = true
                score += 100
                showAlert = true
                userGuess = ""
                askQuestion()
                return // Doğru eşleşme bulundu, fonksiyonu bitir
            }
        }
        showAlert = true // Yanlış eşleşme, uyarıyı göster
        userGuess = ""
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
