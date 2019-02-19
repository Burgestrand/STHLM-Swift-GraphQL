class App
  def initialize(db:)
    @db = db
  end

  def users
    @db[:users]
  end

  def articles
    users.flat_map { |user| user.articles }
  end

  def user(id:)
    users.find { |user| user.id == id }
  end

  def article(id:)
    articles.find { |article| article.id == id }
  end
end
