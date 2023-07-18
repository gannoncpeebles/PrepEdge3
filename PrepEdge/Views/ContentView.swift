import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                VStack {
                    Text("Welcome to PrepEdge")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.black)
                    
                    NavigationLink(destination: TechnicalView()) {
                        Text("Technical")
                            .font(.headline)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: BehavioralView()) {
                        Text("Behavioral")
                            .font(.headline)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Added to fix navigation view style in iOS 15
    }
}

struct TechnicalView: View {
    @State private var score = 0
    @State private var selectedAnswerIndex: Int?
    @State private var currentQuestionIndex = 0
    
    let questions = QuestionData.loadQuestions()
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack {
                if let question = currentQuestion {
                    QuestionView(question: question, answerSelected: { selectedAnswerIndex in
                        if selectedAnswerIndex == question.answerIndex {
                            score += 1
                        }
                        
                        loadNextQuestion()
                    }, selectedAnswerIndex: $selectedAnswerIndex)
                } else {
                    Text("Loading question...")
                        .font(.title)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Technical Portion")
        .onAppear {
            loadNextQuestion()
        }
    }
    
    private var currentQuestion: Question? {
        guard currentQuestionIndex >= 0 && currentQuestionIndex < questions.count else {
            return nil
        }
        return questions[currentQuestionIndex]
    }
    
    private func loadNextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let selectedAnswerIndex = selectedAnswerIndex {
                if currentQuestionIndex + 1 < questions.count {
                    currentQuestionIndex += 1
                } else {
                    currentQuestionIndex = 0 // Loop back to the first question if all questions have been answered
                }
                score += (selectedAnswerIndex == currentQuestion?.answerIndex) ? 1 : 0
                self.selectedAnswerIndex = nil // Clear selected answer for the next question
            }
        }
    }



}



struct BehavioralView: View {
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack {
                Text("Behavioral Portion")
                    .font(.largeTitle)
                
                Spacer()
            }
        }
        .navigationBarTitle("Behavioral Portion")
    }
}

struct QuestionView: View {
    let question: Question
    let answerSelected: (Int) -> Void
    
    @Binding var selectedAnswerIndex: Int?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(question.text)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            ForEach(0..<question.options.count, id: \.self) { index in
                Button(action: {
                    selectedAnswerIndex = index
                    answerSelected(index)
                    
                    // Add color indication after 1 second delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        // Remove the call to loadNextQuestion() here
                    }
                }) {
                    Text(question.options[index])
                        .font(.headline)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedAnswerIndex == index ? (question.answerIndex == index ? Color.green : Color.red) : Color.gray)
                                .foregroundColor(.white)
                        )
                        .cornerRadius(10)
                        .foregroundColor(.black) // Set text color to black
                }
            }
        }
    }
}




struct Question {
    let text: String
    let options: [String]
    let answerIndex: Int
}

let backgroundColor = LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .top, endPoint: .bottom)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
