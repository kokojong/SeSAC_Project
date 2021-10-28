import UIKit

// map, filter, reduce
// 고차함수: 1급 객체 / 매개변수와 반환값에 함수 -> map, filter, reduce

// 학생 4.0 이상
let student = [2.2, 5.0, 4.3, 4.4, 3.1, 1.5, 4.0]
var resultStudent: [Double] = []
for i in student {
    if i >= 4.0 {
        resultStudent.append(i)
    }
}
print(resultStudent)

// filter

let resultFilter = student.filter { value in
    value >= 4.0
}

let resultFilter2 = student.filter { $0 >= 4.0 } // 축약해서 사용
print(resultFilter2) // 결과는 같은데 더 빠름


// 원하는 영화
let movieList = [
    "괴물" : "박찬욱",
    "기생충" : "봉준호",
    "인터스텔라" : "놀란",
    "인셉션" : "놀란",
    "옥자" : "봉준호"
]

let sortedMovie = movieList.sorted(by: { $0.key < $1.key } ) // 영화 이름을 기준으로 오름차순
print(sortedMovie)

// 반복문
for (movieName,director) in movieList {
    if director == "봉준호" {
        
    }
}

// 필터
let movieResult = movieList.filter { $0.value == "봉준호" } // $0은 한개의 요소?를 가져오는거
print(movieResult)

// 필터된 결과값에서 영화 이름만 보려면? map을 같이 사용
let movieResult2 = movieList.filter { $0.value == "봉준호" }.map { $0.key }
print(movieResult2)


// map -> 기존에 들어있는 요소를 원하는 클로저 등을 이용해서 나오는 결과값으로 바꿈?
let number = [1,2,3,4,5,6,7,8,9]
var resultNumber: [Int] = []

for n in number {
    resultNumber.append(n*2)
}

// 원본을 건들지 않음
let resultMap =  number.map { $0 * 2 }
print(resultMap)
print(number)

// reduce
let exam = [30,40,90,100,10,80]
var totalCount = 0

for i in exam {
    totalCount += i
}

// 리듀스는 초기값이 있어야 한다
let totalReduce = exam.reduce(0) { $0 + $1 }
print(totalReduce)
