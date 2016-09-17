//
//  ArrayOfUDataElementWithForm.swift
//  Time-Application
//
//  Created by Даниил on 17.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation

extension Array where Element: UDataElementWithForm {
    func groupByForm() -> [GroupedUDataElement] {
        
//        let forms: Set<String> = Set(self.map {$0.form}) // unique forms form data
//        
//        var result: [GroupedUDataElement] = []
//        
//        for form in forms {
//            // find appropriate to form elements
//            let elementsWithForm = self.filter {element in
//                let dataElement = element as UDataElementWithForm
//                return dataElement.form == form
//            }
//            // instance groupedUDataElement with appropriate elements and append it to result
//            let groupedElement = GroupedUDataElement(form: form, elements: elementsWithForm)
//            result.append(groupedElement)
//        }
//        return result
        
        let filteredDataElements = self.groupByFeature {$0.form}.map { (elements: [Element]) in
            elements.map { (element: Element) in
                return element as UDataElementWithForm
            }
        }
        
        let result = filteredDataElements.map { dataElements -> GroupedUDataElement in
            let form = dataElements.first!.form
            return GroupedUDataElement(form: form, elements: dataElements)
        }
        
        return result
    }
}


extension Array {
    func groupByFeature<T: Hashable> (_ f: @escaping (Element) -> T) -> [[Element]] {
        let uniqueFeatures = Set(self.map {f($0)})
        
        let result = uniqueFeatures.reduce([]) { (resultAccomulator: [[Element]], nextFeature: T) in
            let appropriateElements = self.filter {f($0) == nextFeature}
            
            return resultAccomulator + [appropriateElements]
        }
        
        return result
    }
}
