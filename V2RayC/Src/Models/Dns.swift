//
//	Dn.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Dns : NSObject, NSCoding, Mappable{

	var servers : [String]?


	class func newInstance(map: Map) -> Mappable?{
		return Dns()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		servers <- map["servers"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         servers = aDecoder.decodeObject(forKey: "servers") as? [String]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if servers != nil{
			aCoder.encode(servers, forKey: "servers")
		}

	}

}
