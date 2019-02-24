import Apollo

class API {
    /// Fly-weight Result type based on Result coming in Swift 5.
    enum Response<T> {
        enum Error {
            case graphql([GraphQLError])
            case transport(Swift.Error?)
            case unknown
        }

        case success(T)
        case failure(Error)
    }

    typealias Completion<T> = (Response<T>) -> Void

    static let url = URL(string: "http://localhost:3000/graphql")!

    init() {
    }

    private let client = ApolloClient(url: API.url)
    private let queue = DispatchQueue(label: "org.example.Meetup")

    func users(completion: @escaping Completion<Int>) {
        let query = Backend.ListUsersQuery()
        let completion: Completion<Int> = { [completion] response in
            DispatchQueue.main.async {
                completion(response)
            }
        }

        client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData, queue: queue) { result, error in
            guard let result = result else {
                completion(.failure(.transport(error)))
                return
            }

            guard let users = result.data?.users else {
                if let errors = result.errors {
                    completion(.failure(.graphql(errors)))
                } else {
                    completion(.failure(.unknown))
                }

                return
            }

            completion(.success(users.count))
        }
    }
}
