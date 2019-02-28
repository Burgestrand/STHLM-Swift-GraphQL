Sequel.migration do
    change do
        create_table :users do
            column :id, :string, size: 36, primary_key: true

            column :name, :text, null: false
        end

        create_table :movies do
            column :id, :string, size: 36, primary_key: true

            column :title, :text, null: false
        end

        create_table :reviews do
            column :id, :string, size: 36, primary_key: true

            column :rating, :integer, null: false

            foreign_key :movie_id, :movies
            foreign_key :user_id, :users

            unique [:movie_id, :user_id]
        end

    end
end