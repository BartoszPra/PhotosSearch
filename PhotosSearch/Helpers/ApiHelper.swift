//
//  ApiHelper.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 22/05/2023.
//

import Foundation

public class ApiHelper {
	
	class func buildPhotosSearchRequestURL(text:String, searchType: ImagesSearchScope) -> URL {
		
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.flickr.com"
		components.path = "/services/rest"
		components.queryItems = [URLQueryItem]()
		
		var method = ""
		if !text.isEmpty {
			method = "flickr.photos.search"
		} else {
			method = "flickr.photos.getRecent"
		}
		
		var queryText: URLQueryItem
		
		switch searchType {
		case .username:
			fallthrough
		case .all:
			queryText = URLQueryItem(name: "text", value: text)
		case .tags:
			queryText = URLQueryItem(name: "tags", value: text)
		}
		
		let queryKey = URLQueryItem(name: "api_key", value: "5f7483cb1ed57f1411919900611a6237")
		let queryMethod = URLQueryItem(name: "method", value: method)
		let queryFormat = URLQueryItem(name: "format", value: "json")
		let queryExtra = URLQueryItem(name: "extras", value: "url_t,url_l,tags")
		let queryNojsoncallback = URLQueryItem(name: "nojsoncallback", value: "1")
		let queryPage = URLQueryItem(name: "page", value: "1")
		
		components.queryItems!.append(queryKey)
		components.queryItems!.append(queryMethod)
		components.queryItems!.append(queryFormat)
		if !text.isEmpty {
			components.queryItems!.append(queryText)
		}
		components.queryItems!.append(queryExtra)
		components.queryItems!.append(queryNojsoncallback)
		components.queryItems!.append(queryPage)
		
		return components.url!
	}
	
	class func buildUserIconUrl(iconFarm: Int, iconServer:String, nsId:String) -> URL? {
		//http://farm{icon-farm}.staticflickr.com/{icon-server}/buddyicons/{nsid}.jpg
		var components = URLComponents()
		components.scheme = "https"
		components.host = "farm\(iconFarm).staticflickr.com"
		components.path = "/\(iconServer)/buddyicons/\(nsId).jpg"
		return components.url
	}
	
	class func buildPhotoDetailUrl(photoId: String) -> URL {
//https://www.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=5f7483cb1ed57f1411919900611a6237&photo_id=52921952643&format=json&nojsoncallback=1
		var components = URLComponents()
		components.scheme = "https"
		components.host = "flickr.com"
		components.path = "/services/rest/"
		components.queryItems = [URLQueryItem]()
		
		let queryMethod = URLQueryItem(name: "method", value: "flickr.photos.getInfo")
		let queryKey = URLQueryItem(name: "api_key", value: "5f7483cb1ed57f1411919900611a6237")
		let photoId = URLQueryItem(name: "photo_id", value: photoId)
		let queryFormat = URLQueryItem(name: "format", value: "json")
		let queryNojsoncallback = URLQueryItem(name: "nojsoncallback", value: "1")
		components.queryItems!.append(queryMethod)
		components.queryItems!.append(queryKey)
		components.queryItems!.append(photoId)
		components.queryItems!.append(queryFormat)
		components.queryItems!.append(queryNojsoncallback)
		return components.url!
	}
	
	class func buildUserPhotosUrl(userId: String) -> URL {
//https://www.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=5f7483cb1ed57f1411919900611a6237&user_id=130281204%40N06&format=json&nojsoncallback=1
		var components = URLComponents()
		components.scheme = "https"
		components.host = "flickr.com"
		components.path = "/services/rest/"
		components.queryItems = [URLQueryItem]()
		
		let queryMethod = URLQueryItem(name: "method", value: "flickr.people.getPublicPhotos")
		let queryKey = URLQueryItem(name: "api_key", value: "5f7483cb1ed57f1411919900611a6237")
		let photoId = URLQueryItem(name: "user_id", value: userId)
		let queryExtra = URLQueryItem(name: "extras", value: "url_t,tags")
		let queryFormat = URLQueryItem(name: "format", value: "json")
		let queryNojsoncallback = URLQueryItem(name: "nojsoncallback", value: "1")
		components.queryItems!.append(queryMethod)
		components.queryItems!.append(queryKey)
		components.queryItems!.append(photoId)
		components.queryItems!.append(queryExtra)
		components.queryItems!.append(queryFormat)
		components.queryItems!.append(queryNojsoncallback)
		return components.url!
	}
}



