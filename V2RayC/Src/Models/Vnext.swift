//
//	Vnext.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Vnext : NSObject, NSCoding, Mappable{

	var address : String?
	var port : Int?
	var users : [User]?


	class func newInstance(map: Map) -> Mappable?{
		return Vnext()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		address <- map["address"]
		port <- map["port"]
		users <- map["users"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObject(forKey: "address") as? String
         port = aDecoder.decodeObject(forKey: "port") as? Int
         users = aDecoder.decodeObject(forKey: "users") as? [User]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if port != nil{
			aCoder.encode(port, forKey: "port")
		}
		if users != nil{
			aCoder.encode(users, forKey: "users")
		}

	}

}