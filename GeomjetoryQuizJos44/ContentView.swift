//
//  ContentView.swift
//  GeomjetoryQuizJos44
//
//  Created by cmStudent on 2022/10/21.
//


import SwiftUI


struct ContentView: View {
    let sound = SoundPlayer()
    @State private var OnePice = ["ウソップ","エネル","クロコダイル","クロヒゲ","ゲッコー","ゾロ","なみ","バギー","フラミンゴ","フランキー","ブルック","ミッチー","ルフィー","ロビン"]
        .shuffled()
    
    
    @State private var Number = 4
    @State private var correctAnswer = Int.random(in: 0 ... 3)
    @State private var showingScore = false
    @State private var Title = ""
    @State private var alertMessage = ""
    @State private var userScore = 0
    @State private var count = 0
    @State var timer: Timer? = nil
    @State var timeCount: Int = 0
    @State private var goukei: Bool = false
    @State var attempts: Int = 0
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                AngularGradient(gradient: Gradient(colors: [.red, .black, .green]), center: .center, angle: .degrees(-45))
                    .edgesIgnoringSafeArea(.all)
                
                if attempts <= 10 {
                VStack(spacing: 55) {
                    VStack {
                        
                        Label("OnepiceQuiz", systemImage: "figure.walk").foregroundColor(.white)
                            .frame(width: geometry.size.width / 2, height: 100)
                            .font(.largeTitle)
                        
                        Text("10問正解したらスコアが表示されます")
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width / 2, height: 50)
                            .font(.headline)
                        
                        Text("答えを選択してください")
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width / 2, height: 50)
                            .font(.headline)
                        
                        Spacer()
                        
                        Image(OnePice[correctAnswer])
                        
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: geometry.size.width / 2, height: 50)
                        
                    }
                   
                    
                    ForEach(0 ..< Number) { number in
                        Button(action: {
                            self.Tapped(number)
                            
                        }) {
                            Text( self.OnePice[number])
                                .frame(width: geometry.size.width / 2, height: 10)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                        }
                      
                    }
                    }
                .alert(isPresented: $showingScore) {
                    Alert(title: Text(Title), message: Text("\(alertMessage)"), dismissButton: .default(Text("次の問題へ")) {
                        self.Question()
                    })
                }
                    
                    Spacer()
                } else {
                    
                    VStack {
                        Image("Image")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: geometry.size.width / 2, height: 50)
                        
                           
                        Text("得点:\(userScore)")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width / 2, height: 10)
                           
                        
                         
                        Button("Restart") {
                            self.Question()
                            attempts = 0
                            userScore = 0
                        }
                        .frame(width: geometry.size.width / 2, height: 10)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .font(.largeTitle)
                        
                    }.alert(isPresented: $showingScore) {
                        Alert(title: Text(Title), message:
                                Text(alertMessage), dismissButton: .default(Text("Continue")) {
                            self.Question()
                        })
                    
                    }
                    
                }
            }
        }
       
    }
    
    func Tapped(_ number: Int) {
       
        if number == correctAnswer {
            attempts += 1
            Title = "正解"
            userScore += 1
            alertMessage = "優秀です。ほんとうに嬉しい \(userScore)"
            self.sound.Yae()
            
        } else {
            Title = "間違い"
            alertMessage = "惜しいね頑張って！！！！！！"
            userScore -= 1
            attempts -= 1
            self.sound.No()
        }
        
        showingScore = true
    }
    
    func Question() {
        OnePice.shuffle()
        correctAnswer = Int.random(in: 0 ..< (Number))
    }
    
   
    
    func fireTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            timeCount -= 10
            if(timeCount == 0) {
                
            }
        }
    }
    
}

struct OneImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
            .frame(width: 160, height: 95)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
