class Admin < ApplicationRecord
  has_secure_password
  def self.up
    Admin.create(:email => "admin@admin.com", :name => "Admin", :password_digest => "123456789")
  end
  def self.down
    Admin.delete_all
  end
end
