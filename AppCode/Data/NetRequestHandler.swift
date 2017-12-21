//
//  Download.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/2/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import Foundation

struct AuthToken{
    static var token: String = ""
}
struct CourseList{
    static var courses: Courses? = Courses()
}

class NetRequestHandler: NSObject {
    var urlString: String
    var postString: String?
    init(withURLString: String) {
        urlString = withURLString
        super.init()

    }
    func useParams() -> NetRequestHandler {
        urlString = urlString + "?"
        return self
    }
    func usePostString(postString: String?) -> NetRequestHandler {
        self.postString = postString
        return self
    }
    func useToken() -> NetRequestHandler{
        urlString = urlString + "token=" + AuthToken.token
        return self
    }
    func download_request<T: Codable>() -> T?{
        if let url = URL(string: urlString) {
            do {
                let contents = try String(contentsOf: url)

                if let data = contents.data(using: .utf8) {
                    return try JSONDecoder().decode(T.self, from: data)
                } else {
                    return nil
                }

            } catch let jsonErr{
                // contents could not be loaded
                print(jsonErr)
                print("Could not load contents of URL")
                return nil
            }
        } else {
            // the URL was bad
            print("URL not properly formatted or does not exist")
            return nil
        }
    }
    func post_request_callback(callback: @escaping (Data?) -> Void){
        if let url = URL(string: urlString){
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            if postString != nil {
                request.httpBody = postString?.data(using: .utf8)
            }
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                //networking error check
            
                if let data = data {
                    do {
                        callback(data)
                    }
                }
                //http error check
                else if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response!)")
                } else {
                    print("Error: \(error!)")
                }
                
            }
            task.resume()
        } else {
        }
    }
}
