//
//  Constants.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Response {
        static let errorMessageKey = "message"
        static let errorKey = "error"
        static let errorsKey = "errors"
    }
    
    struct ErrorMessage {
        static let Error = "Error"
        static let DefaultErrorMessage = "La operación no pudo ser completada. Por favor intente nuevamente."
        static let NoInternetConnection = "Por favor chequee su conexión a Internet."
    }

    enum HTTPHeaderField: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case xmlHttpRequest = "XMLHttpRequest"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case textPlain = "text/plain"
        case imageJpeg = "image/jpeg"
        case multiPartFormData = "multipart/form-data"
    }
    
    enum imageName: String {
        case uala = "icUala"
    }
}
