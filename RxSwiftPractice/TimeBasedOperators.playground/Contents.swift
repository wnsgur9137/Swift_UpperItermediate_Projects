import RxSwift
import RxCocoa
import UIKit
import PlaygroundSupport

let disposeBag = DisposeBag()

print("-----replay-----")
// 지나간 이벤트 방출에 대해 버퍼 사이즈 수만큼 새로운 subscriber에게 replay 해주는 연산자.
let 인사말 = PublishSubject<String>()
let 반복하는앵무새 = 인사말.replay(1)

반복하는앵무새.connect()

인사말.onNext("1. hello")
인사말.onNext("2. hi")

반복하는앵무새
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

인사말.onNext("3. 안녕하세요.")


print("-----replayAll-----")
// 개수 제한 없이 지나간 이벤트 방출에 대해 모두 출력해주는 연산자.
let 닥터스트레인지 = PublishSubject<String>()
let 타임스톤 = 닥터스트레인지.replayAll()

닥터스트레인지.onNext("아아악")

타임스톤.connect()

닥터스트레인지.onNext("도르마무")
닥터스트레인지.onNext("거래를 하러왔다")

타임스톤
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-----buffer-----")
// Observable이 발생하는 이벤트들을 지정한 시간 동안(timeSpan) 지정한 개수만큼(count) 들어온 이벤트를 배열로 묶어 방출한다.

//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//
//timer.schedule(wallDeadline: .now() + 2, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(
//        timeSpan: .seconds(2),
//        count: 2,
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)


print("-----window-----")
// buffer과 비슷하지만 buffer과 달리, array가 아닌 Observable을 방출한다.

//let 만들어낼최대Observable수 = 5
//let 만들시간 = RxTimeInterval.seconds(2)
//
//let window = PublishSubject<String>()
//var windowCount = 0
//let windowTimerSource = DispatchSource.makeTimerSource()
//windowTimerSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//windowTimerSource.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//windowTimerSource.resume()
//
//window
//    .window(
//        timeSpan: 만들시간,
//        count: 만들어낼최대Observable수,
//        scheduler: MainScheduler.instance
//    )
//    .flatMap { windowObservable -> Observable<(index: Int, element: String)> in
//        return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print("\($0.index)번째 Observable의 요소 \($0.element)")
//    })
//    .disposed(by: disposeBag)


print("-----delaySubscription-----")
// 구독을 지연시킨다.

//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//delayTimeSource.setEventHandler {
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
//delaySource
//    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)


print("-----delay-----")
// delaySubscription은 구독을 지연시키지만,
// delay는 전체 시퀀스를 지연시키는 연산자이다.

//let delaySubject = PublishSubject<String>()
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now(), repeating: .seconds(1))
//delayTimeSource.setEventHandler {
//    delayCount += 1
//    delaySubject.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
//delaySubject
//    .delay(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)


print("-----interval-----")
// 설정한 간격(interval)을 두고 옵저버를 생성
// Int라고 설정하고 생성자를 아무 것도 사용하지 않았다.
// 그럼에도 불구하고 Interval 연산자가 타입 추론을 통해 0초부터 3초 간격으로 Int타입을 방출한다.

//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)


print("-----timer-----")
// Interval과 유사하지만 두 가지 차이점이 있다.
// 1. 구독 이후 첫 번째 값 사이 간격 - due timer 설정 가능
// 2. 반복 간격 설정 가능

//Observable<Int>
//    .timer(
//        .seconds(5),    // due time 5초
//        period: .seconds(2),    // 반복 시간 2초
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)


print("-----timeOut-----")
// timer와 비슷하지만 timerout은 제한시간을 두는 연산자이다.
let 누르지않으면에러나는버튼 = UIButton(type: .system)
누르지않으면에러나는버튼.setTitle("누르세요", for: .normal)
누르지않으면에러나는버튼.sizeToFit()

PlaygroundPage.current.liveView = 누르지않으면에러나는버튼
누르지않으면에러나는버튼.rx.tap
    .do(onNext: {
        print("tap")
    })
// 5초 안에 이벤트를 발생하지 않으면 에러
    .timeout(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


