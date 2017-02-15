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
    
    func testWithUrl() {
        
        if let url = URL.init(string: "https://korben.info/feed") {
            if let xmlData = try? Data.init(contentsOf: url) {
                
                let parser = EasyXMLParser(withData: xmlData)
                let letFluxRSS = parser.parse()
                
                let blogName = "\(letFluxRSS["rss"]["channel"]["title"].value)"
                
                XCTAssertEqual("Korben", blogName)
                
            }
        }

    }
    
    /****************************************************************
        Simple user test case to find the first user name
     ****************************************************************/
    
    func testWithFile() {
        
        if let utilisateursFichier = Bundle.main.path(forResource: "utilisateurs", ofType: "xml"){
            if let utilisateursString = try? String(contentsOfFile: utilisateursFichier) {
                if let utilisateurData = utilisateursString.data(using: .utf8) {
                    
                    //parsing de notere fichier XML
                    let parser = EasyXMLParser(withData: utilisateurData)
                    let items = parser.parse()
                    
                    XCTAssert(items.isValid())
                    
                    XCTAssertEqual("Lenore", "\(items["utilisateurs"]["utilisateur"]["nom"].value)")
                    
                }
            }
        }
    }
}
