
import Foundation
import Moya

public enum TMDB {

  case search(String)
}

extension TMDB: TargetType {
  public var baseURL: URL {
    return URL(string: "https://api.themoviedb.org/3")!
  }

  public var path: String {
    switch self {
    case .search: return "/search/movie"
    }
  }

  public var method: Moya.Method {
    switch self {
    case .search: return .get
    }
  }

  public var sampleData: Data {
    return Data()
  }

  public var task: Task {
    switch self {
    case .search(let title):
        return .requestParameters(parameters: ["api_key":"882c061eab2ca713c2d7c8301448b593", "query" : title], encoding: URLEncoding.default)
    }
  }

  public var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }

  public var validationType: ValidationType {
    return .successCodes
  }
}
