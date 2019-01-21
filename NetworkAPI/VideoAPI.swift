//
//  VideoAPI.swift
//  parenting
//
//  Created by Vergil.Wang on 2018/12/14.
//  Copyright © 2018 zheng-chain. All rights reserved.
//

import Moya
import HandyJSON

let VideoProvider = MoyaProvider<VideoAPI>(manager: DefaultAlamofireManager.sharedManager)

enum VideoAPI {
    case video_category
    case videos(Int?, Int)
    case video_like(String, Bool)
    case video_comments(Int, Int)
    case videos_user(Int, Int)
    case video_comment(Int, String)
    case video(String, String, String)
}

extension VideoAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: ServerHost)!//"http://dappore.store/api"
    }
    
    public var path: String {
        switch self {
        case .video_category:
            return "/api/video_taxons"
        case .videos:
            return "/api/videos"
        case let .video_like(videoID, isLike):
            return "/api/Video/\(videoID)/attitudes/\(isLike ? "like" : "cancel")"
        case let .video_comments(videoID, _):
            return "/api/Video/\(videoID)/comments"
        case .videos_user:
            return "/api/videos"
        case let .video_comment(videoID, _):
            return "/api/Video/\(videoID)/comments"
        case .video:
            return "/api/videos"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .video_category:
            return .get
        case .videos:
            return .get
        case .video_like:
            return .post
        case .video_comments:
            return .get
        case .videos_user:
            return .get
        case .video_comment:
            return .post
        case .video:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .video_category:
            return .requestPlain
        case let .videos(categoryID, page):
            var parameters: [String: Any] = ["page":page, "per":"10"]
            if let categoryID = categoryID {
                parameters["video_taxon_id"] = categoryID
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .video_like:
            return .requestPlain
        case let .video_comments(_, page):
            return .requestParameters(parameters: ["page":page, "per":"10"], encoding: URLEncoding.default)
        case let .videos_user(userID, page):
            return .requestParameters(parameters: ["author_id": userID, "page":page, "per":"12"], encoding: URLEncoding.default)
        case let .video_comment(_, string):
            return .requestParameters(parameters: ["comment": ["content": string]], encoding: JSONEncoding.default)
        case let .video(title, media, cover):
            return .requestParameters(parameters: ["video": ["title": title, "media": media, "cover": cover]], encoding: JSONEncoding.default)
        }
    }
    
    var validationType: ValidationType {
        return .none
    }
    
    var headers: [String: String]? {
        var headers = ["Accept-Language": "zh-CN",
                       "Device-ID": AppService.sharedInstance.uniqueIdentifier,
                       "OS": UIDevice.current.systemName,
                       "OS-Version": UIDevice.current.systemVersion,
                       "Device-Model": UIDevice.current.machineModel ?? "",
                       "App-Version": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String,
                       "Accept": "application/vnd.inee.v1+json"]
        if let model = AuthorizationService.sharedInstance.user, let token = model.auth_token {
            headers["Auth-Token"] = token
        }
        return headers
    }
}
