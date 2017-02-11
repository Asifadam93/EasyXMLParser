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
        Simple user case test to find the same blog name
     ****************************************************************/
    
    func testUtilisation() {
        
        if let url = URL.init(string: "https://korben.info/feed"){
            
            if let xmlData = try? Data.init(contentsOf: url){
                
                let parser = EasyXMLParser(withData: xmlData)
                
                let easyXMLElement = parser.parse()
                
                let title = "\(easyXMLElement["rss"]["channel"]["title"].value!)"
                
                XCTAssertEqual(title,"Korben")
                
            }
            
        }
        
    }
    
}
