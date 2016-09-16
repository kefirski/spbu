//
//  Networking.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation

import Moya
import Result

class UNetworking {
    
    fileprivate let provider = MoyaProvider<UService>()
    
    func loadDataWith(_ target: UService, and callback: @escaping (Result<Data, UNetworkingError>) -> Void) {
        print("start downloading – target = \(target.baseURL, target.path)")
    // performs data downloading and pass it through the callback
        provider.request(target) {result in
            switch result {
            case let .success(moyaResponse):
                print("succes with statuscode = \(moyaResponse.statusCode)")
                // if everything is ok, then pass data through the callback
                if moyaResponse.statusCode <= 400 {
                    let data = moyaResponse.data
                    callback(.success(data))
                } else {
                    // probably not everything is ok
                    callback(.failure(.responseCodeError))
                }
                
            case .failure(_ ):
                print("faulture in downloading \(#file)")
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out). In this case wait not for a while and try to get data again
                callback(.failure(.networkFailure))
            }
        }
    }
}
