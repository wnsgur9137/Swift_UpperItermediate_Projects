import RxSwift

let disposeBag = DisposeBag()

print("-----publishSubject-----")

let publishSubject = PublishSubject<String>()

publishSubject.onNext("onNext")

let subsceriber1 = publishSubject
    .subscribe(onNext: {
        print("첫 번째 구독자: \($0)")
    })

publishSubject.onNext("onNext2")
publishSubject.on(.next(".on(.next(3)"))

subsceriber1.dispose()

let subsceriber2 = publishSubject
    .subscribe(onNext: {
        print("두 번째 구독자: \($0)")
    })

publishSubject.onNext("onNext4")
publishSubject.onCompleted()

publishSubject.onNext("onNext5")

subsceriber2.dispose()

publishSubject
    .subscribe {
        print("세 번째 구독: ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

publishSubject.onNext("onNext6")


print("-----behaviorSubject-----")
enum SubjectError: Error {
    case error1
}

// behaviorSubject는 초기값이 필요하다.
let behaviorSubject = BehaviorSubject<String>(value: "0. 초기값")

behaviorSubject.onNext("1. onNext")

// 1 이후에 구독했지만 1을 전달 받는다.
behaviorSubject.subscribe {
    print("첫 번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

//behaviorSubject.onError(SubjectError.error1)

// error 이후에 구독했지만, error 값을 전달받는다.
behaviorSubject.subscribe {
    print("두 번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

// 가장 최신 값을 꺼내온다.
let value = try? behaviorSubject.value()
print("value: \(value)")


print("-----ReplaySubject-----")
// 몇 개의 buffer를 가질지 선언해 주어야 한다.
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1. onNext")
replaySubject.onNext("2. onNext")
replaySubject.onNext("3. onNext")

replaySubject.subscribe {
    print("첫 번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.subscribe {
    print("두 번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.onNext("4. onNext")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("세 번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

