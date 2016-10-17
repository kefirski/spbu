//
//  UResult.swift
//  Time-Application
//
//  Created by Даниил on 17.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import Result

// Uses in URepresentation
typealias UVoidResult = Result<Void, UNetworkingError>
typealias UVoidClosure = (UVoidResult) -> Void

// Uses in UNetworking
typealias UDataResult = Result<Data, UNetworkingError>
typealias UDataClosure = (UDataResult) -> Void
