import RxSwift


let disposeBag = DisposeBag()

print("-----toArray-----")
Observable.of("A", "B", "C")
    .toArray()
    .subscribe(
        onSuccess: {
            print($0)
        }
    )
    .disposed(by: disposeBag)

print("-----map-----")
Observable.of(Date())
    .map { date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----flatMap-----")
// flatMap은 중첩된 Observable에서 element를 뽑아낼 수 있다.
protocol 선수 {
    var 점수: BehaviorSubject<Int> { get }
}

struct 양궁선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 한국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 10))
let 미국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 8))

let 올림픽경기 = PublishSubject<선수>()

올림픽경기
    .flatMap { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

올림픽경기.onNext(한국국가대표)
한국국가대표.점수.onNext(10)

올림픽경기.onNext(미국국가대표)
한국국가대표.점수.onNext(10)
미국국가대표.점수.onNext(9)


print("-----flatMapLatest-----")
// flatMapLatest는 가장 최근의 시퀀스의 값만 뽑아낸다.
// 즉 초기값이 있는 BehaviorSubject의 경우 그 다음 첫 번째로 시퀀스가 바뀐다면 그 다음 스퀀스는 무시한다.
struct 높이뛰기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 서울 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 7))
let 제주 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 6))

let 전국체전 = PublishSubject<선수>()

전국체전
    .flatMapLatest { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

전국체전.onNext(서울)
서울.점수.onNext(9)

전국체전.onNext(제주)
서울.점수.onNext(10)
제주.점수.onNext(8)


print("-----materialize and dematerialize-----")
// materialize는 요소에 이벤트를 감싸서 방출한다.
// dematerialize는 해당 요소만 방출한다.

enum 반칙: Error {
    case 부정출발
}

struct 달리기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 김토끼 = 달리기선수(점수: BehaviorSubject<Int>(value: 0))
let 박치타 = 달리기선수(점수: BehaviorSubject<Int>(value: 1))

let 달리기 = BehaviorSubject<선수>(value: 김토끼)

달리기
    .flatMapLatest{ 선수 in
        선수.점수
            .materialize()
    }
    .filter {
        guard let error = $0.error else {
            // 에러가 없을 경우 통과 (true)
            return true
        }
        print(error)
        // 에러일 경우 에러를 출력하고 리턴 (false)
        return false
    }
// dematerialize를 주석할 경우 프린트가 다르게 됨을 확인할 수 있음.
    .dematerialize()    // 이벤트를 방출하지 않고 해당 요소만 방출
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

김토끼.점수.onNext(1)
김토끼.점수.onError(반칙.부정출발)
김토끼.점수.onNext(2)    // 표현되지 않은 이유는 박치타 선수라는 새로운 시퀀스가 등장했기에 무시하는 것이다.


달리기.onNext(박치타)


print("-----전화번호 11자리-----")
let input = PublishSubject<Int?>()

let list: [Int] = [1]

input
    .flatMap {
        $0 == nil   // nil일경우 empty() 반환.
            ? Observable.empty()
        : Observable.just($0)   // 아닐경우 그대로 반환
    }
    .map { $0! }
    .skip(while: { $0 != 0})    // 0이 아닐 경우 스킵한다.
    .take(11)   // 11자리인지 확인
    .toArray()  // Array로 묶어준다.
    .asObservable() //toArray()를 할 경우 Single이 되므로 Observable로 묶는다.
    .map {
        $0.map {"\($0)"}    // String 타입으로 변환.
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)   // 3번째 인덱스에 "-" 추가.
        numberList.insert("-", at: 8)   // 8번째 인덱스에 "-" 추가.
        let number = numberList.reduce(" ", +)  // 각각의 스트링을 더한다.
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(1)
input.onNext(2)
input.onNext(nil)
input.onNext(3)
input.onNext(4)
input.onNext(5)
input.onNext(6)
input.onNext(7)
input.onNext(8)
input.onNext(0)

