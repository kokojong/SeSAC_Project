//
//  BoardViewModel.swift
//  SeSAC_week14
//
//  Created by kokojong on 2021/12/28.
//

import Foundation

class BoardViewModel {
    
    var text: Observable<String> = Observable("text")
    var username: Observable<String> = Observable("username")
    var email: Observable<String> = Observable("email")
    var uploaddate: Observable<String> = Observable("uploaddate")

    func getBoards() {
        let tokenen = UserDefaults.standard.string(forKey: "token")!
        print(tokenen)
//        UserDefaults.standard.set(userData.jwt, forKey: "token")
        APIService.boards(token: tokenen) { board, error in
            print("board",board)
            print("error",error)
            
            guard let board = board else {
                return
            }
            
            // first로 하는 이유: 배열이기 때문에
            self.username.value = board.first?.usersPermissionsUser.username ?? "username Error"
//            completion()
        }
    }
    
}

