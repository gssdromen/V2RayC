//
//	Setting.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Setting : NSObject, NSCoding, Mappable{

	var auth : String?
	var ip : String?
	var udp : Bool?
	var timeout : Int?
	var vnext : [Vnext]?
	var domainStrategy : String?
	var rules : [Rule]?


	class func newInstance(map: Map) -> Mappable?{
		return Setting()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		auth <- map["auth"]
		ip <- map["ip"]
		udp <- map["udp"]
		timeout <- map["timeout"]
		vnext <- map["vnext"]
		domainStrategy <- map["domainStrategy"]
		rules <- map["rules"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         auth = aDecoder.decodeObject(forKey: "auth") as? String
         ip = aDecoder.decodeObject(forKey: "ip") as? String
         udp = aDecoder.decodeObject(forKey: "udp") as? Bool
         timeout = aDecoder.decodeObject(forKey: "timeout") as? Int
         vnext = aDecoder.decodeObject(forKey: "vnext") as? [Vnext]
         domainStrategy = aDecoder.decodeObject(forKey: "domainStrategy") as? String
         rules = aDecoder.decodeObject(forKey: "rules") as? [Rule]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if auth != nil{
			aCoder.encode(auth, forKey: "auth")
		}
		if ip != nil{
			aCoder.encode(ip, forKey: "ip")
		}
		if udp != nil{
			aCoder.encode(udp, forKey: "udp")
		}
		if timeout != nil{
			aCoder.encode(timeout, forKey: "timeout")
		}
		if vnext != nil{
			aCoder.encode(vnext, forKey: "vnext")
		}
		if domainStrategy != nil{
			aCoder.encode(domainStrategy, forKey: "domainStrategy")
		}
		if rules != nil{
			aCoder.encode(rules, forKey: "rules")
		}

	}

}