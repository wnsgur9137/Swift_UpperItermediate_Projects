import RxSwift

let disposeBag = DisposeBag()


print("-----startWith-----")
// 초기값 선언할 때 사용
let yellow = Observable.of("1", "2", "3")

yellow
    .enumerated()   // index 값과 element를 분리
    .map { index, element in
        return element + "child" + ": \(index)"
    }
    .startWith("teacher")   // Observable과 동일한 타입(String)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----concat-----")
let yellowChilds = Observable.of("1", "2", "3")
let teacher = Observable<String>.of("teacher")

let lineWalk = Observable
    .concat([teacher, yellowChilds])

lineWalk
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----concat2-----")
teacher
    .concat(yellowChilds)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----concatMap-----")
// flatMap과 밀접한 관계
// flatMap : 방출되는 Observable이 합쳐진다.
// 이는 순서가 보장된다.
let childHouse: [String: Observable<String>] = [
    "yellow": Observable.of("yellow1", "yellow2", "yellow3"),
    "blue": Observable.of("blue1", "blue2")
]

Observable.of("yellow", "blue")
    .concatMap { childClass in
        childHouse[childClass] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----merge1-----")
let 강북 = Observable.from(["강북구", "성북구", "동대문구", "종로구"])
let 강남 = Observable.from(["강남구", "강동구", "영등포구", "양천구"])

Observable.of(강북, 강남)
    .merge()    // 순서를 보장하지 않는다.
// 강북, 강남 중 하나라도 Error를 방출하면, merge는 에러를 방출하며 종료된다.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----merge2-----")
Observable.of(강북, 강남)
    .merge(maxConcurrent: 1)    // maxConcurrent의 개수만큼 시퀀스를 합친다.
//  첫 번째 시퀀스의 방출이 완전히 종료될 때까지 다른 시퀀스를 merge 하지 않는다.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----combineLastest1-----")
// 두 개의 시퀀스를 하나의 시퀀스로 합쳐준다.
// 서브 시퀀스에서 이벤트가 방출할 때 마다 이벤트를 방출한다.
// 서브 이벤트에서 최초 이벤트가 방출해야지만 합쳐진 시퀀스에서 이벤트가 방출된다.
let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable
    .combineLatest(성, 이름) { 성, 이름 in
        성 + 이름
    }

성명
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

성.onNext("김")   // 시퀀스에서 방출을 했지만 서브 시퀀스가 방출되지 않았기에 방출되지 않는다.
이름.onNext("철수")
이름.onNext("영수")
이름.onNext("은영")
성.onNext("박")
성.onNext("이")
성.onNext("조")

print("-----combineLatest2-----")
// combineLatest는 8개까지 합칠 수 있다.
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 현재날짜 = Observable<Date>.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(
        날짜표시형식,
        현재날짜,
        resultSelector: { 형식, 날짜 -> String in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = 형식
            return dateFormatter.string(from: 날짜)
        }
    )

현재날짜표시
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----combineLatest3-----")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable
    .combineLatest([firstName, lastName]) { name in
        name.joined(separator: " ")
    }

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lily")


print("-----zip-----")
// 일련의 Observable이 방출 완료되면 zip 전체가 완료된다.
// 즉 Observable의 Element의 개수가 다르면 다른 만큼 방출되지 않는다.
enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승, .승, .패, .승, .패)
let 선수 = Observable<String>.of("대한민국", "스위스", "미국", "브라질", "일본", "중국")

let 시합결과 = Observable
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + " \(결과)"
    }

시합결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("----withLatestFrom1-----")
// 특정 트리거가 방출 되었을 때 특정 상태의 최신 값을 얻고 싶을 때 사용한다.
// 가장 최신의 이벤트 값을 방출.
let gunfire = PublishSubject<Void>()
let running = PublishSubject<String>()

gunfire
    .withLatestFrom(running)
    .distinctUntilChanged() // 동일한 이벤트는(중복된 것은) 방출하지 않고, 단 한번만 방출한다 (sample과 같이 사용 가능)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

running.onNext("1")
running.onNext("1 2")
running.onNext("1 2 3")
gunfire.onNext(Void())
gunfire.onNext(Void())


print("-----sample-----")
// withLatestFrom과 다르게 여러번 onNext해도 단 한번만 방출한다.
let start = PublishSubject<Void>()
let racer = PublishSubject<String>()

racer
    .sample(start)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

racer.onNext("red")
racer.onNext("red   blue")
racer.onNext("red   blue    yellow")
start.onNext(Void())
start.onNext(Void())
start.onNext(Void())


print("-----amb-----")
// Element를 먼저 방출하는 시퀀스를 제외한 나머지 시퀀스는 방출하지 않는다.
let bus1 = PublishSubject<String>()
let bus2 = PublishSubject<String>()

let busStation = bus1.amb(bus2)
// bus1과 bus2 두 가지를 모두 지켜보지만 먼저 방출된 시퀀스만 지켜본다.

busStation
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

bus2.onNext("bus2-customer0: customer1")
bus1.onNext("bus1-customer0: customer2")
bus1.onNext("bus1-customer1: customer3")
bus2.onNext("bus2-customer1: customer4")
bus1.onNext("bus1-customer2: customer5")
bus2.onNext("bus2-customer2: customer6")


print("-----switchLatest-----")
// source Observable(handsUp)으로 부터 들어온 마지막 시퀀스의 아이템만 구독한다.
let student1 = PublishSubject<String>()
let student2 = PublishSubject<String>()
let student3 = PublishSubject<String>()

let handsUp = PublishSubject<Observable<String>>()

let handsUP_Studnets = handsUp.switchLatest()

handsUP_Studnets
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

handsUp.onNext(student1)
student1.onNext("student1")
student2.onNext("student2")

handsUp.onNext(student2)
student2.onNext("student2")
student1.onNext("student1")

handsUp.onNext(student3)
student2.onNext("student2")
student1.onNext("student1")
student3.onNext("student3")

handsUp.onNext(student1)
student1.onNext("student1")
student2.onNext("student2")
student3.onNext("student3")
student2.onNext("student2")


print("-----reduce-----")
// 모든 이벤트를 더한 값을 방출한다.
Observable.from((1...10))
//    .reduce(0, accumulator: { summary, newValue in
//        return summary + newValue
//    })
//    .reduce(0) { summary, newValue in
//        return summary + newValue
//    }
    .reduce(0, accumulator: +)
// 위 세 가지의 reduce는 동일한 방법이다.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----scan-----")
// reduce와 같이 모든 이벤트를 더하지만, 더할 때마다 방출한다.
Observable.from((1...10))
//    .scan(0, accumulator: { summary, newValue in
//        return summary + newValue
//    })
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
