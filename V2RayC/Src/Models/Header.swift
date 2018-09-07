//
//	Header.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Header : NSObject, NSCoding, Mappable{

	var type : String?
	var host : String?


	class func newInstance(map: Map) -> Mappable?{
		return Header()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		type <- map["type"]
		host <- map["Host"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         type = aDecoder.decodeObject(forKey: "type") as? String
         host = aDecoder.decodeObject(forKey: "Host") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if host != nil{
			aCoder.encode(host, forKey: "Host")
		}

	}

}