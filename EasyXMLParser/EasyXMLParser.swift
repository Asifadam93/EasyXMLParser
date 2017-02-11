//
//  EasyXMLParser.swift
//  EasyXMLParser
//
//  Created by Fabien on 06/02/2017.
//  Copyright © 2017 com.4amoc1.groupe10. All rights reserved.
//

import UIKit

public class EasyXMLParser : NSObject {
    
    //la donnée à parser avec le constructeur withData
    private let parserXML: XMLParser
    
    //le delegate qui sera utilisé avec notre parseur
    private let delegate:EasyXMLParserDelegate = EasyXMLParserDelegate()
    

    /*
     * Constructeur de l'objet version DATA
     */
    public  init(withData: Data) {
        self.parserXML = XMLParser(data: withData)
    }
    
    /*
     * Constructeur de l'objet version URL
     */
    public  init(withUrl: URL) {
        if let parser = XMLParser(contentsOf: withUrl) {
            self.parserXML = parser
        }else{
            self.parserXML = XMLParser()
        }
    }
    
    
    /*
     * Méthode qui sera appeller pour parser puis renvoyer un array contenant 
     * une ou plusieurs fois la collection demandée par l'utilisateur. 
     */
    public func fill(collection : [String:Any]) -> EasyXMLElement {
        
        //print("On m'a demandé de remplir avec une collection ")
        
        parse()
        
        return delegate.items
    }
    
    
    /*
     * Méthode qui va setter le delegate de notre parser
     * Le parser analysera ensuite notre contenu XML. Le résultat du parser sera stockée dans delegate.items
     */
    private  func parse() {
        //print("Ca y est on va parser")
        parserXML.delegate = delegate
        parserXML.parse()
        

    }



    
    /*
    public func fill(objectName : String) -> [Any] {
        print("\nOn m'a demandé de remplir un objet nommé \("Item")\n")
        
        
        var tempoArray:[Any] = [Any]()
        
        var instance: AnyObject! = nil
        if let classInst = NSClassFromString(objectName) as? NSObject.Type {
            //print (classInst)
            
            instance = classInst.init() // create the instance from this class
            
            //print("J'ai une instance \(instance)")
            
            let aMirror = Mirror(reflecting: instance)
            
            //print("J'ai un mirroir \(aMirror)")
            
            /*for case let (label?, value) in aMirror.children {
                print ("label : \(label), type : \(Mirror(reflecting:value).subjectType)")
            }*/

            instance.setValue("Faites de vos QR Codes de veritables ...", forKey: "Title")
            instance.setValue("https://korben.info/de-vos-qr-codes-de-veritables-oeuvres-dart.html", forKey: "Link")
            instance.setValue(["Script","Service web","QR Code"], forKey: "category")
            
            
            tempoArray.append(instance)
            
        }
        
         return tempoArray
        
    }*/
    
    
    
    
    
    
    
    
    
}
