//
//  UNetworkingError.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//


import Result

enum UNetworkingError: Error {
    case responseCodeError
    case networkFailure
    case dataError
}
