import Alamofire
import RxSwift
import ObjectMapper


public let rxAlamofireObjectMapperError = NSError(domain: "RxAlamofireObjectMapperDomain", code: -1, userInfo: nil)

extension Reactive where Base: DataRequest {
    func responseMappable<T: Mappable>(as type: T.Type? = nil,
                                       to object: T? = nil,
                                       keyPath: String? = nil,
                                       context: MapContext? = nil) -> Observable<T> {
        return self.responseJSON().mappable(type: type, to: object, keyPath: keyPath, context: context)
    }
}

extension Observable where Element == DataRequest {
    func responseMappable<T: Mappable>(as type: T.Type? = nil,
                                      to object: T? = nil,
                                      keyPath: String? = nil,
                                      context: MapContext? = nil) -> Observable<T> {
        return self.flatMapLatest {
            $0.rx.responseMappable(as: type,
                                   to: object,
                                   keyPath: keyPath,
                                   context: context)
            
        }
    }
}
