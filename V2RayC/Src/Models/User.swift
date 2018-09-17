//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class User : NSObject, NSCoding, Mappable{

	var alterId : Int?
	var id : String?
	var security : String?


	class func newInstance(map: Map) -> Mappable?{
		return User()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		alterId <- map["alterId"]
		id <- map["id"]
		security <- map["security"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         alterId = aDecoder.decodeObject(forKey: "alterId") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? String
         security = aDecoder.decodeObject(forKey: "security") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if alterId != nil{
			aCoder.encode(alterId, forKey: "alterId")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if security != nil{
			aCoder.encode(security, forKey: "security")
		}

	}

}