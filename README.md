# Poke Book
랜덤한 포켓몬을 뽑아 프로필 이미지로 설정할 수 있는 전화번호부


## 프로젝트 과정에서 배운 것
- CoreDataStack을 구성하는 요소
  - Model / Context / Store Coordinator
  - core data stack을 이용하여 crud를 만들고 싱글톤 패턴을 통해 전역적으로 코어데이터의 작업을 수행하는 법
- 빌더 패턴과 체이닝을 이용한 속성의 자유로운 설정 방법
- URLSession을 통해 JSON파일을 받아오고 디코딩 하여 사용하는 기초적인 방법
- NSCache를 이용하여 네트워크 통신에 대한 부담을 줄이고 속도를 높이는 방법
- ViewController의 생명주기 흐름, isViewAppearing의 등장 배경과 특징

## 과제 목표
#### Lv1. 첫 번째 화면
- [X] 메인 화면(친구 목록 화면)의 기본적인 UI 구현. 

#### Lv2. 두 번째 화면
- [x] 연락처 추가/편집 화면 UI 구현.

#### Lv3. 화면 전환
- [x] 연락처 추가/편집 화면 네비게이션 바 (상단) 영역 구현.

#### Lv4. 연락처 프로필 사진
- [x] 랜덤 이미지 생성 버튼 구현. 포켓몬 API 연결.

#### Lv5. 데이터 저장
- [x] 적용 버튼을 누르면 연락처 데이터(이름/전화번호/프로필이미지)를 디스크에 실제 저장하도록 구현. 저장된 연락처 데이터들을 메인화면 테이블 뷰의 DataSource 로 적용. (데이터 Create)

#### Lv6. 데이터 정렬
- [x] 친구 목록 화면으로 돌아올때마다 “이름순”으로 정렬 되어 보이도록 구현.

#### Lv7. 연락처 상세 보기 및 편집
- [x] UITableViewCell 을 클릭했을때도 연락처 추가/편집 페이지로 이동하도록 구현. 이때 네비게이션 바 영역의 타이틀은 그 연락처 이름이 노출되도록 설정. 그리고 저장되어있던 이미지,이름,전화번호가 노출되도록 설정.

#### Lv8. 데이터 업데이트 
- [x]  테이블 셀을 통해 들어온 페이지였을 경우 “적용” 버튼 클릭 시 데이터 Create 가 아닌 데이터 Update 가 되도록 구현.


## 커밋 컨벤션
### 깃모지 및 태그 정의
| **깃모지**  | **태그**      | **사용 목적**           | **예시**                         |
|-------------|---------------|-------------------------|----------------------------------|
| 🎉 `:tada:` | `[Init]`      | 프로젝트 초기화         | `🎉[Init]InitialCommit`          |
| ✨ `:sparkles:` | `[Feature]` | 새로운 기능 추가        | `✨[Feature]AddLoginAPI`         |
| 🐛 `:bug:`  | `[Fix]`       | 버그 수정               | `🐛[Fix]ResolveLoginError`       |
| ♻️ `:recycle:` | `[Refactor]` | 코드 리팩토링           | `♻️[Refactor]SimplifyLogic`      |
| 🔥 `:fire:` | `[Remove]`    | 코드/파일 삭제          | `🔥[Remove]DeleteUnusedFile`     |
| 📝 `:memo:` | `[Docs]`      | 문서 추가/수정          | `📝[Docs]UpdateREADME`           |

### 커밋 메시지 구조
1. **커밋 타이틀**
   - **형식**: `<깃모지>[태그]작업내용`
   - 깃모지와 태그를 포함한 요약.
   - 예: `✨[Feature]AddUserRegistration`
3. **커밋 본문 (선택 사항)**  
   - 필요한 경우 작업의 자세한 설명을 추가.
   - 예:
     ```
     ✨[Feature]AddUserRegistration
     - Implement user registration API
     - Add form validation
     ```

## 사용 규칙
1. **깃모지와 태그를 항상 포함**: 작업의 목적을 명확히 하기 위함.
2. **한 커밋, 한 가지 작업**: 변경 사항을 명확히 구분.
