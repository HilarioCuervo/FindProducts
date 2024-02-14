//
//  RequestError.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 06/02/2024.
//

import Foundation

enum RequestError: Error {
    case invalidURL
    case noInput
    case noResponse
    case notFound
    case serverError
    case unauthorized
    case unexpectedStatusCode
}

extension RequestError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL, .notFound:
            return "Ocurrió un error al intentar acceder a lo que estabas buscando"
        case .noInput:
            return "Campo de búsqueda vacío"
        case .noResponse:
            return "No encontramos respuesta para lo que estabas buscando"
        case .serverError:
            return "No podemos realizar tu solicitud en este momento"
        case .unauthorized:
            return "Parece que no tienes los permisos para acceder a esta función"
        case .unexpectedStatusCode:
            return "Ocurrió un error"
        }
    }
    
    var message: String {
        switch self {
        case .invalidURL, .notFound:
            return "Por favor, intenta de nuevo mas tarde. Si el problema persiste comunicate con el soporte técnico."
        case .noInput:
            return "Recuerda que debes ingresar al menos una letra para poder realizar la búsqueda."
        case .noResponse:
            return "Revisa que la palabra este bien escrita, o prueba usando términos mas generales."
        case .serverError:
            return "Nuestro servidor esta teniendo inconvenientes, por favor volve a intentar mas tarde."
        case .unauthorized:
            return "Si crees que es un error intenta nuevamente o comunicate con el soporte técnico."
        case .unexpectedStatusCode:
            return "Revisa que tu conexión a internet funcione correctamente, o intenta de nuevo mas tarde."
        }
    }
}
