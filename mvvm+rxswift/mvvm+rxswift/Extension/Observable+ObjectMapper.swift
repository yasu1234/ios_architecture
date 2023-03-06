import Alamofire
import ObjectMapper
import RxSwift

extension ObservableType where Element == (HTTPURLResponse, Any) {
    private func mapper<T: Mappable>(_ type: T.Type? = nil,
                                     from object: Any,
                                     keyPath: String? = nil,
                                     context: MapContext? = nil) -> (mapper: Mapper<T>, object: Any?) {
        var object: Any? = object
        if let keyPath = keyPath, let JSON = object as? [String: Any] {
            object = try? Map(mappingType: .fromJSON, JSON: JSON).value(keyPath)
        }
        let mapper = Mapper<T>()
        mapper.context = context
        return (mapper, object)
    }
    
    public func mappable<T: Mappable>(type: T.Type? = nil,
                                      to object: T? = nil,
                                      keyPath: String? = nil,
                                      context: MapContext? = nil) -> Observable<T> {
        return self.flatMapLatest { _, json -> Observable<T> in
            let tmpObject: T?
            let mapper = self.mapper(type, from: json, keyPath: keyPath, context: context)
            if let object = object {
                tmpObject = mapper.mapper.map(JSONObject: mapper.object, toObject: object)
            } else {
                tmpObject = mapper.mapper.map(JSONObject: mapper.object)
            }
            
            guard let object = tmpObject else {
                return .error(rxAlamofireObjectMapperError)
            }
            return .just(object)
        }
    }
}
