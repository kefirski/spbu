//
//  Representation.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result
import Async

final class URepresentation {
    
    private var _data: [AnyObject]?
    private var _metadata: Metadata?
    
    let networkingBrain = UNetworking()
    
    func loadData(with target: UService, rawData: Bool = false, _ callback: @escaping UVoidClosure) {
        
        // representations with different targets should prepare data in different way
        // raw data uses when it is necessary to store in UDataElement not only main data
        
        clearData()
        
        switch target {
        case .getData(_, let level):
            
            networkingBrain.loadData(with: target) { [weak self] result in
                switch result {
                case .success(let data):
                    // fill data and metadata from json
                    let rawJSON = JSON(data: data)
                    self?.fillData(with: rawJSON, dependingOn: level, using: rawData, callback)

                case .failure(let error):
                    // callback with connection error
                    callback(.failure(error))
                }
            }
        }
    }
    
    var data: [AnyObject] { return _data ?? [] }
    
    var metadata: Metadata? {
        return _metadata
    }
    
    private func fillData(with rawJSON: JSON,
                          dependingOn level: ULevel,
                          using rawData: Bool, _ callback: UVoidClosure) {
        
        let (dataJSON, metadataJSON) = extractDataAndMetadata(from: rawJSON)
        
        self._metadata = Metadata(from: metadataJSON)
        
        guard dataJSON.exists() else {
            callback(.failure(.dataError))
            return
        }
        
        let jsons = jsonArrayFrom(json: dataJSON)
        
        switch level {
        case .l1, .l2, .l4:
            _data = jsons.map { item in UDataElement(from: item, withRawData: rawData) }
        case .l3:
            let rawData = jsons.map { item in  UDataElementWithForm(from: item) }
            _data = rawData.groupByForm()
        case .l5, .widget:
            _data = jsons.flatMap(UDataElementStudyDay.init)
        }
        
        callback(.success())
        
    }
    
    private func extractDataAndMetadata(from: JSON) -> (JSON, JSON) {
        return (from["data"], from["metadata"])
    }
    
    private func jsonArrayFrom(json: JSON) -> [JSON] {
        let range = 1...json.count
        return range.map { json["\($0)"] }
    }
    
    private func clearData() {
        _data = nil
        _metadata = nil
    }
}
