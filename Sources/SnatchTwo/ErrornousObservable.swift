//
//  ErrornousObservable.swift
//  SnatchTwo
//
//  Created by Isaac Weisberg on 5/30/18.
//

import RxSwift

internal func errornousObservable<Thing>(_ error: Error) -> Observable<Thing> {
    return Observable.create { observable in
        observable.onError(error)
        observable.onCompleted()
        return Disposables.create()
    }
}
