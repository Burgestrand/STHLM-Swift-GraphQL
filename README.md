# Meetup App

Notes:
- Build process uses node & yarn. You can get it through homebrew: `brew install yarn`.

```
brew install yarn
yarn install
make app
```

## Resources

- GraphQL: https://graphql.org
- GraphiQL: https://electronjs.org/apps/graphiql
- Apollo iOS: https://www.apollographql.com/docs/ios/

## Makefile

- `make app` — bootstrap and build dependencies.
- `make code` — generate swift code from schema and queries.
- `make schema` — download schema from remote endpoint.
