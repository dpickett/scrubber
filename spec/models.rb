ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => File.join(File.dirname(__FILE__), 'test.db')
)

class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.string  :login
      t.timestamps
    end
  end
end

CreateSchema.suppress_messages { CreateSchema.migrate(:up) }

class User < ActiveRecord::Base

end

User.destroy_all

User.create! do |u|
  u.first_name = "John"
  u.last_name  = "Smith"
  u.email      = "john@acme.com"
  u.login      = "john"
end

User.create! do |u|
  u.first_name = "Jane"
  u.last_name  = "Doe"
  u.email      = "jane@acme.com"
  u.login      = "jane"
end
