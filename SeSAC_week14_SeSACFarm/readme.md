![SeSAC_Farm_all](https://user-images.githubusercontent.com/61327153/155844973-ec7d1b25-9cab-4cbd-9dc2-101594bdba1f.png)

# 새싹 농장 🌱

- SeSAC과정을 함께 수강하는 친구들과 게시글, 댓글을 통해서 소통하는 app
- 서버 통신을 이용한 회원가입, 로그인 기능과 게시글 및 댓글 CRUD 기능

</br>

## 개발 기간 및 사용 기술

- 개발 기간: 2021.12.29 ~ 2022.01.14 (약 2주)
- 세부 개발 기간
  - 2021.12.29 ~ 2022.01.06 - 메인 기능(회원가입, 로그인, 게시글 및 댓글 CRUD)
  - 2022.01.07 ~ 2022.01.14 - 부가 기능(비밀번호 변경, 최신순 정렬 등), 버그 수정, 코드 리팩토링

- 사용 기술: `Codebase UI`, `UIKit`, `SnapKit`, `Toast`, `URLSession`, `Codable`, `MVVM`
 
 </br>
 

## 새로 배운 것

**코드 베이스의 UI구성, SnapKit 라이브러리의 사용([블로그 글 작성](https://kokojong.tistory.com/6))**

**라이브러리가 아닌 URLSession을 이용한 데이터 통신**

**Generic Type에 대한 JSONDecoder처리**

**Observable을 이용한 실시간 UI Bind**

**MVVM 패턴의 기초 이해**

**싱글턴의 ViewModel 사용(리팩토링 완료)**

</br>

## 이슈

- MVVM 패턴의 ViewModel에 대한 이해부족으로 값 전달 이슈가 발생 -> 싱글턴 패턴의 적용으로 해결

```swift

class PostMainViewModel {
    
    static let shared = PostMainViewModel()
    
}
```

```swift

class PostMainViewController: UIViewController {

    let postMainView = PostMainView()
    
    var viewModel = PostMainViewModel.shared
}
```

<br/>

- ViewModel에서 비지니스 로직 처리

```swift

extension PostMainViewModel {
    var numberOfRowsInSection: Int {
        return allPosts.value.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> PostElement {
        return allPosts.value[indexPath.row]
    }
    
}
```

</br>

## UI

| 회원가입, 로그인 | 로그아웃 | 게시글 정렬, 비밀번호 변경 |
| ------ | ------ | ------ |
|![sesacfarm_signup](https://user-images.githubusercontent.com/61327153/155847199-8aaa19d9-ce53-4e5e-bd9d-4a5ddce4003e.gif)| ![sesacfarm_logout](https://user-images.githubusercontent.com/61327153/155847224-c2e3ed02-1c0e-45dc-bdb6-436360282e6f.gif) | ![sesacfarm_menu](https://user-images.githubusercontent.com/61327153/155847228-a60fa2d8-0e45-4b7a-987c-d6b6fd7de27b.gif) |

| 게시글 작성, 수정, 삭제 | 댓글 작성, 수정, 삭제 |
| ------ | ------ |
| ![sesacfarm_post](https://user-images.githubusercontent.com/61327153/155847303-ca288d95-17c3-4885-bb77-8d109021a763.gif) | ![sesacfarm_comment](https://user-images.githubusercontent.com/61327153/155847305-02c4fdc9-0911-4e5d-a934-4796676b36aa.gif) |

</br>
