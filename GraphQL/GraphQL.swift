//  This file was automatically generated and should not be edited.

import Apollo

/// Backend namespace
public enum Backend {
  public final class ListUsersQuery: GraphQLQuery {
    public let operationDefinition =
      "query ListUsers {\n  users {\n    __typename\n    id\n  }\n}"

    public init() {
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes = ["Query"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("users", type: .nonNull(.list(.nonNull(.object(User.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(users: [User]) {
        self.init(unsafeResultMap: ["__typename": "Query", "users": users.map { (value: User) -> ResultMap in value.resultMap }])
      }

      /// A list of all users.
      public var users: [User] {
        get {
          return (resultMap["users"] as! [ResultMap]).map { (value: ResultMap) -> User in User(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: User) -> ResultMap in value.resultMap }, forKey: "users")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}