//
//  CRMAPI.swift
//  parenting
//
//  Created by Vergil.Wang on 2019/4/23.
//  Copyright © 2019 zheng-chain. All rights reserved.
//

import Moya
import HandyJSON

let CRMProvider = MoyaProvider<CRMAPI>(manager: DefaultAlamofireManager.sharedManager)

enum CRMAPI {
    case accounts
    case members
    case messages(Int)
    case message(Int)
    case messages_asReadAll
}

extension CRMAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: CRMServerHost)!
    }
    
    public var path: String {
        switch self {
        case .accounts:
            return "/my/accounts"
        case .members:
            return "/my/members"
        case .messages:
            return "/notifications"
        case let .message(identifier):
            return "/notifications/\(identifier)"
        case .messages_asReadAll:
            return "/notifications/read_all"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .accounts:
            return .get
        case .members:
            return .get
        case .messages:
            return .get
        case .message:
            return .get
        case .messages_asReadAll:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .accounts:
            return .requestPlain
        case .members:
            return .requestPlain
        case let .messages(page):
            return .requestParameters(parameters: ["page":page, "per":"10"], encoding: URLEncoding.default)
        case .message:
            return .requestPlain
        case .messages_asReadAll:
            return .requestPlain
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
        if let token = AuthorizationService.sharedInstance.authToken {
            headers["Auth-Token"] = token
        }
        if let organToken = AuthorizationService.sharedInstance.organToken {
            headers["Organ-Token"] = organToken
        }
        return headers
    }
}

