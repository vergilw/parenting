//
//  AuthorizationAPI.swift
//  parenting
//
//  Created by Vergil.Wang on 2018/11/12.
//  Copyright © 2018 zheng-chain. All rights reserved.
//

import Foundation
import Moya

let AuthorizationProvider = MoyaProvider<AuthorizationAPI>(manager: DefaultAlamofireManager.sharedManager)

enum AuthorizationAPI {
    case fetchCode(phone: Int)
    case signIn(phone: String, code: String)
    case signInWithWechat(openID: String, accessToken: String)
    case signUpWithWechat(openID: String, phone: String, code: String)
    case bindWechat(parameters: [String: Any])
}

extension AuthorizationAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: ServerHost)!
    }
    
    public var path: String {
        switch self {
        case .fetchCode:
            return "/app/login/confirm"
        case .signIn:
            return "/app/login"
        case .signInWithWechat:
            return "/app/wechats"
        case .signUpWithWechat:
            return "/app/wechats/bind_mobile"
        case .bindWechat:
            return "/app/login/bind_wechat"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchCode:
            return .get
        case .signIn:
            return .post
        case .signInWithWechat:
            return .post
        case .signUpWithWechat:
            return .post
        case .bindWechat:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .fetchCode(phone):
            return .requestParameters(parameters: ["mobile":phone, "device":"app"], encoding: URLEncoding.default)

        case let .signIn(phone, code):
            return .requestParameters(parameters: ["mobile":phone, "token":code], encoding: URLEncoding.default)
            
        case let .signInWithWechat(openID, accessToken):
            return .requestParameters(parameters: ["openid":openID, "access_token":accessToken], encoding: URLEncoding.default)
            
        case let .signUpWithWechat(openID, phone, code):
            return .requestParameters(parameters: ["uid":openID, "mobile":phone, "token":code], encoding: URLEncoding.default)
            
        case let .bindWechat(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
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
