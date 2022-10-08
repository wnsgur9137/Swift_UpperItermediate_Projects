import Foundation
import RxSwift

print("-----Just-----")
// just -> 하나의 element만 방출한다.
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })


print("-----Of-----")
// Of는 하나 이상의 element를 방출한다.
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })


print("-----Of2-----")
// Observable는 차입 추론을 통해 element를 방출한다.
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })


print("-----From-----")
Observable.from([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

// from은 Element가 Array만 츃나다.
// Array의 요소 하나씩 방출한다.

// Observable는 정의만 해 주기 때문에 확인하려면 구독을 해 주어야 한다.



print("-----subscribe1-----")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

print("-----subscribe2-----")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("-----subscribe3-----")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

print("-----empty-----")
// 아무런 Element를 방출하지 않는다.
// 즉시 종료할 수 있는 Observable과
// 의도적으로 0개의 값을 가지는 Obsavable을 만들고 싶을 때
Observable.empty()
    .subscribe {
        print($0)
    }

Observable<Void>.empty()
    .subscribe(onNext: {
        
    },
    onCompleted: {
        print("Completed")
    })

print("-----never-----")

Observable.never()
    .debug("never")
    .subscribe(onNext: {
        print($0)
    },
    onCompleted: {
        print("Completed")
    })

Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0) = \(2*$0)")
    })

print("-----dispose-----")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()

Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .dispose()

print("-----disposeBag-----")
let disposeBag = DisposeBag()
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)


print("-----create1-----")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("-----create2-----")
Observable.create { observer -> Disposable in
    observer.onNext(1)
//    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
onError: {
    print($0.localizedDescription)
},
onCompleted: {
    print("completed")
},
onDisposed: {
    print("disposed")
})
.disposed(by: disposeBag)


print("-----deferred1-----")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("-----deferred2-----")
var boolean: Bool = false

let fatory: Observable<String> = Observable.deferred {
    boolean = !boolean
    
    if boolean {
        return Observable.of("윗면")
    } else {
        return Observable.of("아랫면")
    }
}

for _ in 0...3 {
    fatory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}
