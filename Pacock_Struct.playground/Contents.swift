import UIKit


// 재료들
struct 대분류 {
    let id: Int,
    let name: String,
    let ingredient: Int, // 0 재료가 x , 1 스트롱한 재료, 2일때는 소프트한 재료
    
    let 중: 중분류
    
}

struct 중분류 {
    let id: Int,
    let name: String,
    let 소: 소분류
    
}

struct 소분류 {
    let id: Int,
    let name: String,
    let difficulty: Int,
    let gs: Bool,
    let mart: Bool,
    let dungeon: Bool,
    let coupang: Bool,
    let recipeCount: Int,
    
    let isInMyPocket: Bool,
        let isInMyDream: Bool
    
}

// 레시피

struct Recipe {
    let id: Int,
    let name: String,
    let ingre: [소분류],
    let ganish: Ganish,
    let reference : String, // 스트럭트 만들기 구찮음
    let rink: String // url
    
}

struct Ganish {
    let id: Int,
    let name: String
}


