//
//	HomeModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class HomeModel : NSObject, NSCoding{

	var briefContent : String!
	var category : Category!
	var categorySlug : String!
	var commentsCount : Int!
	var createdAt : String!
	var id : Int!
	var mainImg : String!
	var qqMessage : Int!
	var qzone : Int!
	var title : String!
	var user : User!
	var userId : Int!
	var viewsCount : Float!
	var wxMessage : Int!
	var wxTimeline : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		briefContent = json["brief_content"].stringValue
		let categoryJson = json["category"]
		if !categoryJson.isEmpty{
			category = Category(fromJson: categoryJson)
		}
		categorySlug = json["category_slug"].stringValue
		commentsCount = json["comments_count"].intValue
		createdAt = json["created_at"].stringValue
		id = json["id"].intValue
		mainImg = json["main_img"].stringValue
		qqMessage = json["qq_message"].intValue
		qzone = json["qzone"].intValue
		title = json["title"].stringValue
		let userJson = json["user"]
		if !userJson.isEmpty{
			user = User(fromJson: userJson)
		}
		userId = json["user_id"].intValue
		viewsCount = json["views_count"].floatValue
		wxMessage = json["wx_message"].intValue
		wxTimeline = json["wx_timeline"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if briefContent != nil{
			dictionary["brief_content"] = briefContent
		}
		if category != nil{
			dictionary["category"] = category.toDictionary()
		}
		if categorySlug != nil{
			dictionary["category_slug"] = categorySlug
		}
		if commentsCount != nil{
			dictionary["comments_count"] = commentsCount
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if mainImg != nil{
			dictionary["main_img"] = mainImg
		}
		if qqMessage != nil{
			dictionary["qq_message"] = qqMessage
		}
		if qzone != nil{
			dictionary["qzone"] = qzone
		}
		if title != nil{
			dictionary["title"] = title
		}
		if user != nil{
			dictionary["user"] = user.toDictionary()
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		if viewsCount != nil{
			dictionary["views_count"] = viewsCount
		}
		if wxMessage != nil{
			dictionary["wx_message"] = wxMessage
		}
		if wxTimeline != nil{
			dictionary["wx_timeline"] = wxTimeline
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         briefContent = aDecoder.decodeObject(forKey: "brief_content") as? String
         category = aDecoder.decodeObject(forKey: "category") as? Category
         categorySlug = aDecoder.decodeObject(forKey: "category_slug") as? String
         commentsCount = aDecoder.decodeObject(forKey: "comments_count") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         mainImg = aDecoder.decodeObject(forKey: "main_img") as? String
         qqMessage = aDecoder.decodeObject(forKey: "qq_message") as? Int
         qzone = aDecoder.decodeObject(forKey: "qzone") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         user = aDecoder.decodeObject(forKey: "user") as? User
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
         viewsCount = aDecoder.decodeObject(forKey: "views_count") as? Float
         wxMessage = aDecoder.decodeObject(forKey: "wx_message") as? Int
         wxTimeline = aDecoder.decodeObject(forKey: "wx_timeline") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if briefContent != nil{
			aCoder.encode(briefContent, forKey: "brief_content")
		}
		if category != nil{
			aCoder.encode(category, forKey: "category")
		}
		if categorySlug != nil{
			aCoder.encode(categorySlug, forKey: "category_slug")
		}
		if commentsCount != nil{
			aCoder.encode(commentsCount, forKey: "comments_count")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if mainImg != nil{
			aCoder.encode(mainImg, forKey: "main_img")
		}
		if qqMessage != nil{
			aCoder.encode(qqMessage, forKey: "qq_message")
		}
		if qzone != nil{
			aCoder.encode(qzone, forKey: "qzone")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if viewsCount != nil{
			aCoder.encode(viewsCount, forKey: "views_count")
		}
		if wxMessage != nil{
			aCoder.encode(wxMessage, forKey: "wx_message")
		}
		if wxTimeline != nil{
			aCoder.encode(wxTimeline, forKey: "wx_timeline")
		}

	}

}
