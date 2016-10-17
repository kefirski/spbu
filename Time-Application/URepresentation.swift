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

class URepresentation {
    
    fileprivate var _data: [AnyObject]?
    fileprivate var _metadata: Metadata?
    
    let networkingBrain = UNetworking()
    
    func loadDataWith(_ target: UService, rawData: Bool = false, andThen performCallback: @escaping UVoidClojure) {
        
        // representations with different targets should prepare data in different way
        // raw data uses when it is necessary to store in UDataElement not only main data
        
        // UVoidClojure is discribed in UResult file
        
        self.clearData()
        
        switch target {
        case .getData(_, let level):
            networkingBrain.loadDataWith(target) { result in
                switch result {
                case .success(let data):
                    // fill data and metadata from json
                    let rawJSON = JSON(data: data)
                    self.fillData(with: rawJSON, dependingOn: level, using: rawData, andThen: performCallback)
                    
                case .failure(let error):
                    // callback with connection error
                    performCallback(.failure(error))
                    
                }
            }
        }
    }
    
    var data: [AnyObject] {
        if let _data = _data {
            return _data
        } else {
            return []
        }
    }
    
    var metadata: Metadata? {
        return _metadata
    }
    
    fileprivate func fillData(with rawJSON: JSON, dependingOn level: ULevel, using rawData: Bool, andThen performCallback: UVoidClojure) {
        
        let (dataJSON, metadataJSON) = self.extractDataAndMetadata(from: rawJSON)
        
        self._metadata = Metadata(from: metadataJSON)
        
        guard dataJSON.exists() else {
            performCallback(.failure(.dataError))
            return
        }
        
        let jsons: [JSON] = self.jsonArrayFrom(json: dataJSON)
        
        switch level {
        case .l1, .l2, .l4:
            self._data = jsons.map { item in
                return UDataElement(from: item, withRawData: rawData)
            }
        case .l3:
            let rawData: [UDataElementWithForm] = jsons.map { item in
                return UDataElementWithForm(from: item)
            }
            self._data = rawData.groupByForm()
            
        case .l5, .widget:
            self._data = jsons.flatMap { item in
                return UDataElementStudyDay(from: item)
            }
        }
        
        performCallback(.success())
        
    }
    
    fileprivate func extractDataAndMetadata(from: JSON) -> (JSON, JSON) {
        return (from["data"], from["metadata"])
    }
    
     fileprivate func jsonArrayFrom(json: JSON) -> [JSON] {
        let range = 1...json.count
        return range.map {json["\($0)"]}
    }
    
    fileprivate func clearData() {
        _data = nil
        _metadata = nil
    }
    
   
    
}




