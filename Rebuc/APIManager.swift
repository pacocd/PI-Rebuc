//
//  APIManager.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 26/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct APIManager {

    static let shared: APIManager = APIManager()

    func login(using email: String, and password: String, success: @escaping (User, [String: Any]) -> Void, failure: @escaping (Error) -> Void) {

        let url = URLManager.shared.getURL(from: .signIn)
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        let headers: HTTPHeaders = URLManager.shared.getBaseRequestHeaders()

        request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let json = response.value as? [String: Any] {
                    if let error = self.parseErrorFromResponse(findingIn: json) {
                        failure(error)
                    } else {
                        if let userData = json["data"] as? [String: Any] {
                            if let user = Mapper<User>().map(JSON: userData) {
                                success(user, response.response?.allHeaderFields as! [String: Any])
                            } else {
                                failure(APIError())
                            }
                        } else {
                            failure(APIError())
                        }
                    }
                } else {
                    failure(APIError())
                }
            case .failure(let error):
                failure(error)
            }
        }
    }

    func signUp(using email: String, _ password: String, _ passwordConfirmation: String, _ names: String, _ fatherLastName: String, _ motherLastName: String?, _ dependenceId: Int, success: @escaping (User, [String: Any]) -> Void, failure: @escaping (Error) -> Void) {

        let url: String = URLManager.shared.getURL(from: .signUp)
        let headers: HTTPHeaders = URLManager.shared.getBaseRequestHeaders()
        let parameters: Parameters = [
            "email": email,
            "password": password,
            "password_confirmation": passwordConfirmation,
            "user_role_id": 2,
            "father_last_name": fatherLastName,
            "mother_last_name": motherLastName ?? "",
            "dependence_id": dependenceId,
            "name": names
        ]

        request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let json = response.value as? [String: Any] {
                    if let error = self.parseErrorFromResponse(findingIn: json) {
                        failure(error)
                    } else if let userData = json["user"] as? [String: Any] {
                        if let user = Mapper<User>().map(JSON: userData) {
                            success(user, response.response?.allHeaderFields as! [String: Any])
                        } else {
                            failure(APIError())
                        }
                    } else {
                        failure(APIError())
                    }
                } else {
                    failure(APIError())
                }
            case .failure(let error):
                failure(error)
            }
        }
    }

    func getObject<T>(of type: T.Type, using id: Int, success: @escaping(T) -> Void, failure: @escaping(Error) -> Void) where T: Mappable, T: Model {

        let headers: HTTPHeaders = URLManager.shared.getBaseRequestHeaders()
        let url = "\(T.getUrl())/\(id)"

        request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let json = response.value as? [String: Any] {
                    if let error = self.parseErrorFromResponse(findingIn: json) {
                        failure(error)
                    } else if let objectData = json[T.singularNodeName()] as? [String: Any] {
                        if let object = Mapper<T>().map(JSON: objectData) {
                            success(object)
                        } else {
                            failure(APIError())
                        }
                    } else {
                        failure(APIError())
                    }
                } else {
                    failure(APIError())
                }
            case .failure(let error):
                failure(error)
            }
        }
    }

    func getObjects<T>(of type: T.Type, success: @escaping([T]) -> Void, failure: @escaping(Error) -> Void) where T: Mappable, T: Model {

        let headers: HTTPHeaders = URLManager.shared.getBaseRequestHeaders()
        let url = "\(T.getUrl())"

        request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseArray) in
            switch responseArray.result {
            case .success:
                if let json = responseArray.value as? [String: Any] {
                    if let error = self.parseErrorFromResponse(findingIn: json) {
                        failure(error)
                    } else if let objectArrayData = json[T.pluralNodeName()] as? [[String: Any]] {
                        if let objectArray = Mapper<T>().mapArray(JSONObject: objectArrayData) {
                            success(objectArray)
                        } else {
                            failure(APIError())
                        }
                    } else {
                        failure(APIError())
                    }
                } else {
                    failure(APIError())
                }
            case .failure(let error):
                failure(error)
            }
        }
    }

    func getUser(success: @escaping(User, [String: Any]) -> Void) {

        let url: String = User.getUrl()
        let headers: HTTPHeaders = UserManager.shared.getHeadersForAuthentication()

        request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let json = response.value as? [String: Any] {
                    if let userJson = json[User.singularNodeName()] as? [String: Any] {
                        if let user = Mapper<User>().map(JSON: userJson) {
                            success(user, response.response?.allHeaderFields as! [String: Any])
                        }
                    }
                }
            case .failure(let error):
                UIViewController().showBasicAlert(with: error.localizedDescription)
            }
        }
    }
    fileprivate func parseErrorFromResponse(findingIn json: [String: Any]) -> APIError? {
        var errorMessage: String?
        var errorMessages: [String]?
        if let error = json["error"] as? String {
            errorMessage = error
        } else if let errors = json["errors"] as? [String: Any] {
            if let fullMessageErrors = errors["full_messages"] as? [String] {
                errorMessages = fullMessageErrors
            }
        } else if let errorsMessages = json["errors"] as? [String] {
            errorMessages = errorsMessages
        }
        if let errorMessages = errorMessages {
            errorMessage = errorMessages.joined(separator: "\n")
        }

        if let errorMessage = errorMessage {
            return APIError(message: errorMessage, code: 400)
        } else {
            return nil
        }
    }

}