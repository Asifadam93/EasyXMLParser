//
//  SimpleParserTest.swift
//  EasyXMLParser
//
//  Created by Asif on 11/02/2017.
//  Copyright © 2017 Esgi. All rights reserved.
//

import XCTest

@testable import EasyXMLParser

class UtilisationXMLParserTest: XCTestCase {
    
    /****************************************************************
        Simple user test case to find the same blog name
     ****************************************************************/
    
    func testUrl() {
        
        if let url = URL.init(string: "https://korben.info/feed"){
            
            if let xmlData = try? Data.init(contentsOf: url){
                
                let parser = EasyXMLParser(withData: xmlData)
                
                let easyXMLElement = parser.parse()
                
                let title = "\(easyXMLElement["rss"]["channel"]["title"].value!)"
                
                XCTAssertEqual(title,"Korben")
                
            }
            
        }
        
    }
    
    /****************************************************************
        Simple user test case to parse xml file
     ****************************************************************/
    
    func testXMLFile() {
        
        if let utilisateursFichier = Bundle.main.path(forResource: "utilisateurs", ofType: "xml") {
            
            if let utilisateursString = try? String(contentsOfFile: utilisateursFichier) {
                
                if let utilisateurData = utilisateursString.data(using: .utf8) {
                    
                    let parser = EasyXMLParser(withData: utilisateurData)
                    
                    let items = parser.parse()
                    
                    var item = items["utilisateurs"]["utilisateur"].get()
                    
                    
                }
            }
        }
    }
    
    private func affichage(elements: [EasyXMLElement]) {
        
        for element in elements {
            
            if var tempoValue = element.value as? String {
                
                let sizeTempoValue = tempoValue.distance(from: tempoValue.startIndex, to: tempoValue.endIndex)
                
                let tempoValue2 = tempoValue.substring(to: tempoValue.index(    tempoValue.startIndex, offsetBy: ((sizeTempoValue  > 80) ? 80 : sizeTempoValue)))
                
                if (tempoValue.characters.count > tempoValue2.characters.count) {
                    
                    print ("\(element.name) : \(tempoValue2) ...")
                    
                    XCTAssertEqual(tempoValue2,"Lenore")

                } else {
                    
                    print ("\(element.name) : \(tempoValue)")
                    
                    XCTAssertEqual(tempoValue2,"Lenore")
                }
            } else {
                print ("\(element.name) : VIDE")
            }
        }
    }
}
