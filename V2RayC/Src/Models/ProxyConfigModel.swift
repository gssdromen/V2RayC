//
//	ProxyConfigModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ProxyConfigModel : NSObject, NSCoding, Mappable{

	var dns : Dns?
	var inbound : Inbound?
	var inboundDetour : [InboundDetour]?
	var log : Log?
	var outbound : Outbound?
	var outboundDetour : [OutboundDetour]?
	var routing : Routing?


	class func newInstance(map: Map) -> Mappable?{
		return ProxyConfigModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		dns <- map["dns"]
		inbound <- map["inbound"]
		inboundDetour <- map["inboundDetour"]
		log <- map["log"]
		outbound <- map["outbound"]
		outboundDetour <- map["outboundDetour"]
		routing <- map["routing"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         dns = aDecoder.decodeObject(forKey: "dns") as? Dns
         inbound = aDecoder.decodeObject(forKey: "inbound") as? Inbound
         inboundDetour = aDecoder.decodeObject(forKey: "inboundDetour") as? [InboundDetour]
         log = aDecoder.decodeObject(forKey: "log") as? Log
         outbound = aDecoder.decodeObject(forKey: "outbound") as? Outbound
         outboundDetour = aDecoder.decodeObject(forKey: "outboundDetour") as? [OutboundDetour]
         routing = aDecoder.decodeObject(forKey: "routing") as? Routing

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if dns != nil{
			aCoder.encode(dns, forKey: "dns")
		}
		if inbound != nil{
			aCoder.encode(inbound, forKey: "inbound")
		}
		if inboundDetour != nil{
			aCoder.encode(inboundDetour, forKey: "inboundDetour")
		}
		if log != nil{
			aCoder.encode(log, forKey: "log")
		}
		if outbound != nil{
			aCoder.encode(outbound, forKey: "outbound")
		}
		if outboundDetour != nil{
			aCoder.encode(outboundDetour, forKey: "outboundDetour")
		}
		if routing != nil{
			aCoder.encode(routing, forKey: "routing")
		}
	}
    
    func fillWith(model: ProxyModel) {
        outbound?.settings?.vnext?[0].address = model.address
        outbound?.settings?.vnext?[0].port = model.port
        outbound?.settings?.vnext?[0].users?[0].id = model.id
        outbound?.settings?.vnext?[0].users?[0].alterId = model.alterID
        outbound?.settings?.vnext?[0].users?[0].security = model.security?.rawValue
        outbound?.streamSettings?.network = model.network?.rawValue
        outbound?.streamSettings?.security = model.tls! ? "tls" : "none"
    }

    func writeToConfigJsonFile() -> String {
        if let jsonString = toJSONString(), let folderPath = Bundle.main.resourcePath {
            let filePath = "\(folderPath)/config.json"
            
            if FileManager.default.fileExists(atPath: filePath) {
                try? FileManager.default.removeItem(atPath: filePath)
            }
            
            FileManager.default.createFile(atPath: filePath, contents: jsonString.data(using: String.Encoding.utf8), attributes: nil)
            return filePath
        }
        return ""
    }
}
