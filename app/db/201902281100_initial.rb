Sequel.migration do
    change do
        create_table :users do
            column :id, String, size: 36, primary_key: true

            column :name, :text, null: false
        end

        create_table :movies do
            column :id, String, size: 36, primary_key: true

            column :title, :text, null: false
            column :poster_url, :text, null: false
        end

        create_table :reviews do
            column :id, String, size: 36, primary_key: true

            column :rating, :integer, null: false
            column :notes, :text, null: true

            foreign_key :movie_id, :movies, type: String, size: 36, null: false
            foreign_key :user_id, :users, type: String, size: 36, null: false

            unique [:movie_id, :user_id]
        end

    end
end