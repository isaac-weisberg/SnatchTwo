//
//  ErrornousSingle.swift
//  SnatchTwo
//
//  Created by Isaac Weisberg on 5/30/18.
//

import RxSwift

internal func errornousSingle<Thing>(_ error: Error) -> Single<Thing> {
    return Single.create { single in
        single(.error(error))
        return Disposables.create()
    }
}
