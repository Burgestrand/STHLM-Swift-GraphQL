class Mutation::CreateArticle < GraphQL::Schema::Mutation
  class Input < GraphQL::Schema::InputObject
    graphql_name "CreateArticleInput"

    argument :author_id, ID, required: true
    argument :title, String, required: true
    argument :content, String, required: true

    def author
      context.object.user(id: arguments.author_id) or raise GraphQL::ExecutionError, "Unable to find author #{arguments.author_id}"
    end
  end

  argument :input, Input, required: true

  field :article, Types::Article, null: false

  def resolve(input:)
    author = input.author
    article = Models::Article.make(author: author, title: input.title, content: input.content)
    author.articles.append(article)
    { article: article }
  end
end

