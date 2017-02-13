//
//  EasyXMLElement.swift
//  EasyXMLParser
//
//  Created by Fabien on 10/02/2017.
//  Copyright © 2017 Esgi. All rights reserved.
//

import Foundation

public class EasyXMLElement : NSObject{
    
    private var enfants:[EasyXMLElement] = [EasyXMLElement]()   // les sous éléments de l'élément
    public var value:String=""                                  // la valeur de l'élément
    public var parent:EasyXMLElement?                           // le parent de l'élement
    public var name:String                                      // le nom de l'élément
    
    static public let noName:String = ""
    
    init(name: String) {
        self.name = name
    }
    
    
    
    public subscript(key: String) -> EasyXMLElement {
        get {
            var dernierEnfant = EasyXMLElement(name: EasyXMLElement.noName)

            for enfant in enfants {
                
                if (enfant.name == key) {
                    dernierEnfant = enfant
                }
            }
            return dernierEnfant
        }
    }
    
    
    public func count() -> Int {
        if let total = self.parent?.get(name: self.name).count {
            return total
        }
        return 0
    }
    
    public func get(name:String) -> [EasyXMLElement] {
        var listeFiltre = [EasyXMLElement]()
        
        for enfant in enfants {
            if (name == enfant.name) {
                listeFiltre.append(enfant)
            }
        }
        return listeFiltre
    }
    
    
    public func getAllChildren() -> [EasyXMLElement] {
        return self.enfants
    }
    
    
    
    public func filter(filtre: [String:Any]) -> [EasyXMLElement] {
        //print("Je suis \(self.name) je filtre \(filtre)")
        
        var tempoEnfantFiltre = [EasyXMLElement]()
        let keys = filtre.keys

        //récupération des éléments enfants
        for key in keys {
            let tempoElementList = self.get(name: key)

            for element in tempoElementList {
                tempoEnfantFiltre.append(element)
            }
        }
        
        //récupération des petits enfants
        for enfant in enfants {
            let tempoEnfantElementList = enfant.filter(filtre: filtre)
            for element in tempoEnfantElementList {
                tempoEnfantFiltre.append(element)
            }
        }
        
        return clean(elements: tempoEnfantFiltre, filtre: filtre)

        //return tempoEnfantFiltre
        
    }
    
    private func clean(elements:[EasyXMLElement], filtre: [String:Any]) -> [EasyXMLElement]{
        var tempoEnfantFiltre = elements
        
        var a = 0
        
        for element in tempoEnfantFiltre {
            print("\(element.name) - \(a) ")
            //notre élément est dans la liste de ce qu'on demande
            if let value = filtre[element.name] {
                //print("dansle filtre")
                if (value is Dictionary<String, Any>){
                    let tempoEnfant =  clean(elements: element.enfants, filtre: value as! [String : Any])
                    element.enfants.removeAll()
                    element.enfants = tempoEnfant
                }
                a += 1
            } else {
                //print("pas dans le filtre")
                tempoEnfantFiltre.remove(at: a)
            }
        }
  
        return tempoEnfantFiltre
    }
    
    
    
    
    public func get() -> [EasyXMLElement] {
        if let papa = self.parent {
            return papa.get(name: self.name)
        }
        return [EasyXMLElement]()
    }
    
    /*
     *  Cette méthode permet d'ajouter un enfant à l'EasyXMLElement
     */
    public func addEnfant(element:EasyXMLElement) {
        element.parent = self
        enfants.append(element)
    }
    
    public func isValid() -> Bool {
        return (self.name != EasyXMLElement.noName)
    }

    /*
     *  Description du EasyXMLElement
     */
    override public var description: String{
        return "Je suis \(self.name) j'ai : \(self.enfants.count) enfant(s), ma valeur est : \"\(value)\""
    }
    
    /*
     *  Cette méthode permet d'obtenir une description longue de l'élément en cours avec une description de ses enfants
     */
    public func fullDescription() -> String {
        
        var tempoRetour = "Je suis \(self.name), ma valeur est : \"\(value)\", j'ai : \(self.enfants.count) enfant(s) : \n"
        
        for enfant in enfants {
            //on détermine la taille de value
            let sizeValue = enfant.value.distance(from: enfant.value.startIndex, to: enfant.value.endIndex)
            
            //on crée une chaine temporaire qui n dépasse pas les 80 caractères (histoire d'être lisible)
            let tempoEnfantShortValue = enfant.value.substring(to: enfant.value.index( enfant.value.startIndex, offsetBy: ((sizeValue  > 60) ? 60 : sizeValue)))
            
            //ajout du nom de l'enfant
            tempoRetour.append("  \(enfant.name) : \n")
            
            //ajout de la valeur de l'enfant
            if (enfant.value.characters.count > tempoEnfantShortValue.characters.count) {
                tempoRetour.append("    valeur : \"\(tempoEnfantShortValue)\" ...\n")
            } else {
                tempoRetour.append("    valeur : \"\(enfant.value )\"\n")
            }
            
            //nombre d'enfants de l'enfant
            tempoRetour.append("    nombre d'enfants : \(enfant.enfants.count) \n")
        }
        
        return tempoRetour
    }
}
