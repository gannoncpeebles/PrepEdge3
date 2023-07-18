struct QuestionData {
    static func loadQuestions() -> [Question] {
        // Load questions from the external file and return them as an array
        // You can replace this implementation with your own logic to load the questions
        // from the file in a randomized manner
        
        // Sample implementation with hardcoded questions for demonstration purposes
        let questions = [
            Question(text: "What is an IPO?", options: ["Initial Public Offering", "International Partnership Organization", "Investment Plan Oversight", "Internal Policy Orientation"], answerIndex: 0),
            
            Question(text: "What is a leveraged buyout?", options: ["A high-risk investment strategy", "The purchase of a company using borrowed money", "An investment approach in the tech industry", "A financial derivative instrument"], answerIndex: 1),
            
            Question(text: "What is the purpose of a pitchbook in investment banking?", options: ["To showcase investment banking deals", "To summarize quarterly financial statements", "To outline marketing strategies", "To create corporate logos"], answerIndex: 0),
            
            Question(text: "What is a discounted cash flow (DCF) analysis?", options: ["A method for valuing a company based on projected future cash flows", "A financial metric used to evaluate profitability", "A risk assessment model used in investment banking", "A tool for analyzing market trends"], answerIndex: 0)
        ]
        
        return questions
    }
}
