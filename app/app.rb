class App
  def initialize(db:, current_user: nil)
    @db = db
    @current_user = current_user
  end

  def me
    @current_user
  end

  def users
    Models::User
  end

  def user(id:)
    users.where(id: id)
  end
end
