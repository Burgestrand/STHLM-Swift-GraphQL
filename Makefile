GRAPHQL_SCHEMA=./GraphQL/schema.json
GRAPHQL_ENDPOINT=https://glacial-dawn-15840.herokuapp.com/graphql
GENERATED_CODE=./GraphQL/GraphQL.swift
GRAPHQL_PATTERN=GraphQL/*.graphql
GRAPHQL_FILES := $(shell ls -1 $(GRAPHQL_PATTERN) | sed 's: :\\ :g')

app:
	carthage bootstrap --platform iOS --cache-builds

code: $(GENERATED_CODE)

# Generate Swift code from GraphQL.
$(GENERATED_CODE): $(GRAPHQL_SCHEMA) $(GRAPHQL_FILES)
	yarn apollo codegen:generate --queries="GraphQL/*.graphql" --schema=$(GRAPHQL_SCHEMA) --passthroughCustomScalars --customScalarsPrefix GraphQLCustomTypes. --namespace Backend $@

# Download GraphQL schema from remote endpoint.
.PHONY: schema
schema:
	yarn apollo schema:download --endpoint=$(GRAPHQL_ENDPOINT) $(GRAPHQL_SCHEMA)
