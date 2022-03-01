

# 새싹 프렌즈 🌱

**내 위치와 취미를 바탕으로 주변 사용자와 매칭 후 채팅까지 이어지는 app**
- 첫 실행 시, 회원 탈퇴 시 온보딩 화면 제공
- FirebaseAuth를 이용한 문자 인증, 회원가입, 로그인, 회원탈퇴
- MapKit과 CLLocation을 이용한 내 주변 친구 표시 기능
- 서버 통신을 이용해 취미 기반 친구 매칭 기능
- 매칭 후 상대 신고, 취소, 리뷰 기능
- Socket.IO를 이용한 실시간 채팅 기능
- Conflunce를 통한 기획서 확인
- Figma를 통한 UI 디자인 확인

</br>

## 개발 기간 및 사용 기술

- 개발 기간: 2022.01.18 ~ 2022.02.23 (약 5주)

- 사용 기술: `Codebase UI`, `UIKit`, `SnapKit`, `Toast`, `Alamofire`, `Codable`, `Then`, `SocketIO`, `FCM`, `FirebaseAuth`, `MapKit`, `CLLocation`, `MVVM`
- 기타 라이브러리: `Tabman`, `RangeSeekSlider`
- 기타 사용 툴: `Conflunce`, `Figma`, `Swagger`, `Insomnia`, 

 
 </br>
 
## UI

| 온보딩 화면 | 문자 인증 | 회원가입 |
| ------ | ------ | ------ |


| 내 정보  | 취미 기반 친구 찾기, 매칭 요청, 수락 | 실시간 채팅, 신고, 취소, 리뷰 |
| ------ | ------ | ------ |


</br>

## 새로 배운 것

**Onboarding 화면 구성, SceneDelegate에서의 화면 전환 분기처리**

**Map에 Custom Annotation 적용** [블로그 글 작성](https://kokojong.tistory.com/7)

**FirebaseAuth를 이용한 휴대폰 문자 인증**

**Dynamic Height CollectionView 구현**

**재사용 가능한 Custom View 구현 및 사용**

**N:1로 ViewModel 구성(탭 별로 뷰모델 구성)**

**Socket.IO를 이용한 실시간 채팅 기능 구현**


</br>

## 이슈

- TableViewCell 내부의 CollectionView의 size의 초기값이 없어서 나타나지 않는 이슈 -> DynamicHeightCollectionView를 만들어서 size를 적용

```swift
class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
        
    }
    
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
```

<br/>

- 취미 태그 내부 텍스트의 길이에 따른 동적인 CollectionViewCell Size -> DummyCell을 만들고 size를 측정 후 sizeForItemAt에서 활용

<img width="412" alt="스크린샷 2022-03-01 오후 4 39 40" src="https://user-images.githubusercontent.com/61327153/156125765-33d96020-6b60-40cc-b6a6-0257aec42072.png">

```swift

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    if collectionView == nearHobbyCollectionView {
        switch indexPath.section {
        case 0:
            let dummyCell = UILabel().then {
                $0.font = .Title4_R14
                $0.text = viewModel.fromRecommendHobby.value[indexPath.row]
                $0.sizeToFit()
            }
            let size = dummyCell.frame.size
            return CGSize(width: size.width+34, height: size.height+14)

        default:
            let dummyCell = UILabel().then {
                $0.font = .Title4_R14
                $0.text = viewModel.fromNearFriendsHobby.value[indexPath.row]
                $0.sizeToFit()
            }
            let size = dummyCell.frame.size
            return CGSize(width: size.width+34, height: size.height+14)
        }


    } else {
        let dummyCell = UILabel().then {
            $0.font = .Title4_R14
            $0.text = myFavoriteHobby[indexPath.row]
            $0.sizeToFit()
        }
        let size = dummyCell.frame.size

        return CGSize(width: size.width+54, height: size.height+14)


    }
}
    
```

</br>

- Alamofire를 이용한 API 구성 중 Array가 포함된 Body의 encoding 오류 -> `encoding: URLEncoding(arrayEncoding: .noBrackets)`를 추가

```swift
static func postQueue(idToken: String, form: PostQueueForm, completion: @escaping (Int?, Error?) -> Void) {
        
    let headers = ["idtoken": idToken,
                   "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders

    let parameters: Parameters = [
        "type": form.type,
        "region": form.region,
        "long": form.long,
        "lat": form.lat,
        "hf": form.hf // [String]
    ]

    AF.request(QueueEndPoint.postQueue.url.absoluteString, method: .post, parameters: parameters, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: headers)
        .responseString { response in

            completion(response.response?.statusCode, response.error)
        }
}

```
