import RxSwift

let disposeBag = DisposeBag()

print("-----ignoreElements-----")
//ignoreElement는 Next 이벤트를 무시하는 연산자이다.
let 취침모드 = PublishSubject<String>()

취침모드
    .ignoreElements()
    .subscribe { _ in
        print("취침")
    }
    .disposed(by: disposeBag)

취침모드.onNext("1알림")
취침모드.onNext("2알림")
취침모드.onNext("3알림")

취침모드.onCompleted()


print("-----elementAt-----")
// Next 이벤트에서 해당하는 인덱스의 값만 필터링하여 방출한다.
let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
    .element(at: 2) // index2
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("1알람")  // index0
두번울면깨는사람.onNext("2알람")  // index1
두번울면깨는사람.onNext("3알람")  // index2
두번울면깨는사람.onNext("4알람")  // index3

print("-----filter-----")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----skip-----")
// 해당 값만큼 건너뛰는 것.
Observable.of("1", "2", "3", "4", "5", "6")
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----skipWhile-----")
Observable.of("1", "2", "3", "4", "5", "6", "7", "8")
    .skip(while: {
        $0 != "5"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----skipUntil-----")
// 또 다른 Observable가 Next 이벤트를 방출하기 전까지는 현재 Observable의 Next 이벤트는 무시한다.

let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님
    .skip(until: 문여는시간)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손님.onNext("1")
손님.onNext("2")

문여는시간.onNext("땡!")
손님.onNext("3")


print("-----take-----")
// skip의 반대로, 해당 값만큼 가져오는 것이다.
Observable.of("1", "2", "3", "4", "5")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----takeWhile-----")
// 조건에 해당될 때까지 값을 가져온다.
Observable.of("1", "2", "3", "4", "5")
    .take(while: {
        $0 != "3"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----enumrated-----")
// takeWhile과 함께 쓰이며 element 값과 더불어 index 값도 가져온다.
Observable.of("1", "2", "3", "4", "5")
    .enumerated()
    .take(while: {
        $0.index < 3
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----takeUntil-----")
// skipUntil의 반대로 또 다른 Observable Next 이벤트를 방출하기 전까지 현재 Observable의 Next 이벤트를 방출한다.

let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

수강신청.onNext("1")
수강신청.onNext("2")

신청마감.onNext("신청 마감")
수강신청.onNext("3")

print("-----distinctUntilChanged-----")
// '연속적으로' 반복되는 요소를 무시한다.
Observable.of("1", "1", "2", "2", "3", "3", "4", "4", "1", "5", "5", "6")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


