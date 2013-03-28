class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_id, :access_token, :secret_token 
      t.timestamps
    end
  end
end
