//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class User : NSObject, NSCoding{

	var avatarUrl : String!
	var commentsCount : Int!
	var createdAt : String!
	var email : String!
	var favoCount : Int!
	var id : Int!
	var name : String!
	var postReadCount : Int!
	var qq : Bool!
	var score : Int!
	var sex : Int!
	var uuid : String!
	var weixin : Bool!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		avatarUrl = json["avatar_url"].stringValue
		commentsCount = json["comments_count"].intValue
		createdAt = json["created_at"].stringValue
		email = json["email"].stringValue
		favoCount = json["favo_count"].intValue
		id = json["id"].intValue
		name = json["name"].stringValue
		postReadCount = json["post_read_count"].intValue
		qq = json["qq"].boolValue
		score = json["score"].intValue
		sex = json["sex"].intValue
		uuid = json["uuid"].stringValue
		weixin = json["weixin"].boolValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if avatarUrl != nil{
			dictionary["avatar_url"] = avatarUrl
		}
		if commentsCount != nil{
			dictionary["comments_count"] = commentsCount
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if email != nil{
			dictionary["email"] = email
		}
		if favoCount != nil{
			dictionary["favo_count"] = favoCount
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if postReadCount != nil{
			dictionary["post_read_count"] = postReadCount
		}
		if qq != nil{
			dictionary["qq"] = qq
		}
		if score != nil{
			dictionary["score"] = score
		}
		if sex != nil{
			dictionary["sex"] = sex
		}
		if uuid != nil{
			dictionary["uuid"] = uuid
		}
		if weixin != nil{
			dictionary["weixin"] = weixin
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         avatarUrl = aDecoder.decodeObject(forKey: "avatar_url") as? String
         commentsCount = aDecoder.decodeObject(forKey: "comments_count") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         favoCount = aDecoder.decodeObject(forKey: "favo_count") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         postReadCount = aDecoder.decodeObject(forKey: "post_read_count") as? Int
         qq = aDecoder.decodeObject(forKey: "qq") as? Bool
         score = aDecoder.decodeObject(forKey: "score") as? Int
         sex = aDecoder.decodeObject(forKey: "sex") as? Int
         uuid = aDecoder.decodeObject(forKey: "uuid") as? String
         weixin = aDecoder.decodeObject(forKey: "weixin") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if avatarUrl != nil{
			aCoder.encode(avatarUrl, forKey: "avatar_url")
		}
		if commentsCount != nil{
			aCoder.encode(commentsCount, forKey: "comments_count")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if favoCount != nil{
			aCoder.encode(favoCount, forKey: "favo_count")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if postReadCount != nil{
			aCoder.encode(postReadCount, forKey: "post_read_count")
		}
		if qq != nil{
			aCoder.encode(qq, forKey: "qq")
		}
		if score != nil{
			aCoder.encode(score, forKey: "score")
		}
		if sex != nil{
			aCoder.encode(sex, forKey: "sex")
		}
		if uuid != nil{
			aCoder.encode(uuid, forKey: "uuid")
		}
		if weixin != nil{
			aCoder.encode(weixin, forKey: "weixin")
		}

	}

}
