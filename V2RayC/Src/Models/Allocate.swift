//
//	Allocate.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class Allocate: NSObject, NSCoding, Mappable {

    var concurrency: Int?
    var refresh: Int?
    var strategy: String?


    class func newInstance(map: Map) -> Mappable? {
        return Allocate()
    }
    required init?(map: Map) { }
    private override init() { }

    func mapping(map: Map)
    {
        concurrency <- map["concurrency"]
        refresh <- map["refresh"]
        strategy <- map["strategy"]

    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        concurrency = aDecoder.decodeObject(forKey: "concurrency") as? Int
        refresh = aDecoder.decodeObject(forKey: "refresh") as? Int
        strategy = aDecoder.decodeObject(forKey: "strategy") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if concurrency != nil {
            aCoder.encode(concurrency, forKey: "concurrency")
        }
        if refresh != nil {
            aCoder.encode(refresh, forKey: "refresh")
        }
        if strategy != nil {
            aCoder.encode(strategy, forKey: "strategy")
        }

    }

}
