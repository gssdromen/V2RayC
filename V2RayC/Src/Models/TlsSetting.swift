//
//	TlsSetting.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class TlsSetting : NSObject, NSCoding, Mappable{

	var allowInsecure : Bool?


	class func newInstance(map: Map) -> Mappable?{
		return TlsSetting()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		allowInsecure <- map["allowInsecure"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         allowInsecure = aDecoder.decodeObject(forKey: "allowInsecure") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if allowInsecure != nil{
			aCoder.encode(allowInsecure, forKey: "allowInsecure")
		}

	}

}