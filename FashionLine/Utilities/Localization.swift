//
//  Localization.swift
//  FashionLine
//
//  Created by Furkan Y. on 29.01.2021.
//  Copyright © 2021 Furkan Y. All rights reserved.
//

import UIKit

public class Localization{
    
    static public let shared = Localization()
    
    public var lang: [String: Any] = [:]
    
    public func getLangFile(path: String = "local"){
        switch path {
        case "local":
            var path = "localizable-tr"
            switch UIApplication.getPreferredLanguageCode() {
            case "tr":
                path = "localizable-tr"
            case "en":
                path = "localizable-en"
            default:
                return
            }
            if let langFile = Bundle(for: LoginVC.self).path(forResource: path, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: langFile), options: .mappedIfSafe)
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let object = json as? [String: Any] {
                        lang = object
                    }else {
                        print("JSON is invalid")
                    }
                }catch {
                    print(error.localizedDescription)
                }
            } else {
                print("no file")
            }
        
        default:
            break
        }
    }
    
    public func format(_ parent: String, _ child: Any, arguments: CVarArg?...) -> String{
        var localizedText = ""
        if child is Int {
            let parent = lang[parent] as? [String]
            if let child = parent?[child as! Int]{
                if arguments.isEmpty {
                    localizedText = child
                } else {
                    localizedText = child.formatLocal(arguments as! [CVarArg])
                }
                return localizedText
            }
        } else if child is String {
            if let parent = lang[parent] as? [String: String] {
                if let child = parent[child as! String]{
                    if arguments.isEmpty {
                        localizedText = child
                    } else {
                        localizedText = child.formatLocal(arguments as! [CVarArg])
                    }
                    return localizedText
                }
            }
        }
        return localizedText
    }
}

extension String {
    
    public func formatLocal(_ arguments: [CVarArg]) -> String {
        let args = arguments.map {
            return String(describing: $0.self)
        }
        return String.init(format: self, arguments: args)
    }
}
extension UIApplication {
    class func getPreferredLanguageCode() -> String {
           guard let preferredIdentifier = Locale.preferredLanguages.first else {
               return Locale.current.languageCode!
           }
           return Locale(identifier: preferredIdentifier).languageCode!
       }
}
