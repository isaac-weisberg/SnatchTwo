//
//  Snatch.swift
//  SnatchTwo
//
//  Created by Isaac Weisberg on 5/30/18.
//

import Foundation
import RxSwift
import Snatch

public extension Snatch.SnatchTaskResult {
    var asSingleEvent: SingleEvent<Result> {
        switch self {
        case .success(let res):
            return .success(res)
        case .failure(let error):
            return .error(error)
        }
    }
}

public extension Snatch {
    public func request(_ request: URLRequest) -> Single<Result> {
        return Single.create { single in
            let task = self.task(with: request, createHandler(single))
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }

    public func post<Parameters: Encodable>(_ url: URL, _ parameters: Parameters, _ headers: [String: String]? = nil) -> Single<Result> {
        let request: URLRequest
        do {
            request = try post.generate(url, parameters, headers)
        } catch {
            return Single.error(error)
        }
        return self.request(request)
    }

    public func get(_ url: URL, _ parameters: URLQueryEncoding.Parameters? = nil, _ headers: [String: String]? = nil) -> Single<Result> {
        let request: URLRequest
        do {
            request = try get.generate(url, parameters, headers)
        } catch {
            return Single.error(error)
        }
        return self.request(request)
    }
}

internal func createHandler(_ single: @escaping (SingleEvent<Result>) -> Void) -> Snatch.SnatchTaskCallback {
    return { result in
        single(result.asSingleEvent)
    }
}
