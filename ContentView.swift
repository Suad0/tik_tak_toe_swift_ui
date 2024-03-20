//
//  ContentView.swift
//  TiktakToe
//
//  Created by Suad Demiri on 04.10.23.
//

import SwiftUI

struct ContentView: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    @State private var winner = ""
    
    var body: some View {
        ZStack { //  um die gesamten View zu umhüllen
            Color.gray.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Tik-Tak-Toe").foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 10) {
                    ForEach(0..<9, id: \.self) { index in
                        Button(action: {
                            makeMove(at: index)
                        }) {
                            Text(board[index])
                                .font(.largeTitle)
                                .frame(width: 80, height: 80)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        .disabled(board[index] != "" || winner != "")
                    }
                }
                
                if !winner.isEmpty {
                    Text("Spieler \(winner) hat gewonnen!")
                        .font(.title)
                        .padding()
                    Button("Neustart") {
                        resetGame()
                    }
                    .padding().foregroundColor(.white).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
    
    func makeMove(at index: Int) {
        if board[index].isEmpty {
            board[index] = currentPlayer
            currentPlayer = (currentPlayer == "X") ? "O" : "X"
            checkWinner()
        }
    }
    
    func checkWinner() {
        let winningCombinations: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Horizontale
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Vertikale
            [0, 4, 8], [2, 4, 6] // Diagonale
        ]
        
        for combination in winningCombinations {
            if board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] && !board[combination[0]].isEmpty {
                winner = board[combination[0]]
                return
            }
        }
        
        if !board.contains("") {
            winner = "Unentschieden"
        }
    }
    
    func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        winner = ""
    }
}



#Preview {
    ContentView()
}
