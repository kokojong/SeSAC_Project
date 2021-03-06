![SeSAC_Farm_all](https://user-images.githubusercontent.com/61327153/155844973-ec7d1b25-9cab-4cbd-9dc2-101594bdba1f.png)

# ์์น ๋์ฅ ๐ฑ

- SeSAC๊ณผ์ ์ ํจ๊ป ์๊ฐํ๋ ์น๊ตฌ๋ค๊ณผ ๊ฒ์๊ธ, ๋๊ธ์ ํตํด์ ์ํตํ๋ app
- ์๋ฒ ํต์ ์ ์ด์ฉํ ํ์๊ฐ์, ๋ก๊ทธ์ธ ๊ธฐ๋ฅ๊ณผ ๊ฒ์๊ธ ๋ฐ ๋๊ธ CRUD ๊ธฐ๋ฅ

</br>

## ๊ฐ๋ฐ ๊ธฐ๊ฐ ๋ฐ ์ฌ์ฉ ๊ธฐ์ 

- ๊ฐ๋ฐ ๊ธฐ๊ฐ: 2021.12.29 ~ 2022.01.14 (์ฝ 2์ฃผ)
- ์ธ๋ถ ๊ฐ๋ฐ ๊ธฐ๊ฐ
  - 2021.12.29 ~ 2022.01.06 - ๋ฉ์ธ ๊ธฐ๋ฅ(ํ์๊ฐ์, ๋ก๊ทธ์ธ, ๊ฒ์๊ธ ๋ฐ ๋๊ธ CRUD)
  - 2022.01.07 ~ 2022.01.14 - ๋ถ๊ฐ ๊ธฐ๋ฅ(๋น๋ฐ๋ฒํธ ๋ณ๊ฒฝ, ์ต์ ์ ์ ๋ ฌ ๋ฑ), ๋ฒ๊ทธ ์์ , ์ฝ๋ ๋ฆฌํฉํ ๋ง

- ์ฌ์ฉ ๊ธฐ์ : `Codebase UI`, `UIKit`, `SnapKit`, `Toast`, `URLSession`, `Codable`, `MVVM`
 
 </br>
 

## ์๋ก ๋ฐฐ์ด ๊ฒ

**์ฝ๋ ๋ฒ ์ด์ค์ UI๊ตฌ์ฑ, SnapKit ๋ผ์ด๋ธ๋ฌ๋ฆฌ์ ์ฌ์ฉ([๋ธ๋ก๊ทธ ๊ธ ์์ฑ](https://kokojong.tistory.com/6))**

**๋ผ์ด๋ธ๋ฌ๋ฆฌ๊ฐ ์๋ URLSession์ ์ด์ฉํ ๋ฐ์ดํฐ ํต์ **

**Generic Type์ ๋ํ JSONDecoder์ฒ๋ฆฌ**

**Observable์ ์ด์ฉํ ์ค์๊ฐ UI Bind**

**MVVM ํจํด์ ๊ธฐ์ด ์ดํด**

**์ฑ๊ธํด์ ViewModel ์ฌ์ฉ(๋ฆฌํฉํ ๋ง ์๋ฃ)**

</br>

## ์ด์

- MVVM ํจํด์ ViewModel์ ๋ํ ์ดํด๋ถ์กฑ์ผ๋ก ๊ฐ ์ ๋ฌ ์ด์๊ฐ ๋ฐ์ -> ์ฑ๊ธํด ํจํด์ ์ ์ฉ์ผ๋ก ํด๊ฒฐ

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

- ViewModel์์ ๋น์ง๋์ค ๋ก์ง ์ฒ๋ฆฌ

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

| ํ์๊ฐ์, ๋ก๊ทธ์ธ | ๋ก๊ทธ์์ | ๊ฒ์๊ธ ์ ๋ ฌ, ๋น๋ฐ๋ฒํธ ๋ณ๊ฒฝ |
| ------ | ------ | ------ |
|![sesacfarm_signup](https://user-images.githubusercontent.com/61327153/155847199-8aaa19d9-ce53-4e5e-bd9d-4a5ddce4003e.gif)| ![sesacfarm_logout](https://user-images.githubusercontent.com/61327153/155847224-c2e3ed02-1c0e-45dc-bdb6-436360282e6f.gif) | ![sesacfarm_menu](https://user-images.githubusercontent.com/61327153/155847228-a60fa2d8-0e45-4b7a-987c-d6b6fd7de27b.gif) |

| ๊ฒ์๊ธ ์์ฑ, ์์ , ์ญ์  | ๋๊ธ ์์ฑ, ์์ , ์ญ์  |
| ------ | ------ |
| ![sesacfarm_post](https://user-images.githubusercontent.com/61327153/155847303-ca288d95-17c3-4885-bb77-8d109021a763.gif) | ![sesacfarm_comment](https://user-images.githubusercontent.com/61327153/155847305-02c4fdc9-0911-4e5d-a934-4796676b36aa.gif) |

</br>
