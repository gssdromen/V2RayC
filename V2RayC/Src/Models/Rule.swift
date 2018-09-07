//
//	Rule.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Rule : NSObject, NSCoding, Mappable{

	var domain : [String]?
	var ip : [String]?
	var outboundTag : String?
	var port : String?
	var type : String?


	class func newInstance(map: Map) -> Mappable?{
		return Rule()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		domain <- map["domain"]
		ip <- map["ip"]
		outboundTag <- map["outboundTag"]
		port <- map["port"]
		type <- map["type"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         domain = aDecoder.decodeObject(forKey: "domain") as? [String]
         ip = aDecoder.decodeObject(forKey: "ip") as? [String]
         outboundTag = aDecoder.decodeObject(forKey: "outboundTag") as? String
         port = aDecoder.decodeObject(forKey: "port") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if domain != nil{
			aCoder.encode(domain, forKey: "domain")
		}
		if ip != nil{
			aCoder.encode(ip, forKey: "ip")
		}
		if outboundTag != nil{
			aCoder.encode(outboundTag, forKey: "outboundTag")
		}
		if port != nil{
			aCoder.encode(port, forKey: "port")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}