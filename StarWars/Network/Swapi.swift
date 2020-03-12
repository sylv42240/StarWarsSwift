
import Foundation
import Moya

public enum Swapi {

  case film
}

extension Swapi: TargetType {
  public var baseURL: URL {
    return URL(string: "https://swapi.co/api")!
  }

  public var path: String {
    switch self {
    case .film: return "/films"
    }
  }

  public var method: Moya.Method {
    switch self {
    case .film: return .get
    }
  }

  public var sampleData: Data {
    return Data()
  }

  public var task: Task {
    switch self {
    case .film:
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
  }

  public var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }

  public var validationType: ValidationType {
    return .successCodes
  }
}
