//
//	Mux.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Mux : NSObject, NSCoding, Mappable{

	var concurrency : Int?
	var enable : Bool?


	class func newInstance(map: Map) -> Mappable?{
		return Mux()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		concurrency <- map["concurrency"]
		enable <- map["enable"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         concurrency = aDecoder.decodeObject(forKey: "concurrency") as? Int
         enable = aDecoder.decodeObject(forKey: "enable") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if concurrency != nil{
			aCoder.encode(concurrency, forKey: "concurrency")
		}
		if enable != nil{
			aCoder.encode(enable, forKey: "enable")
		}

	}

}