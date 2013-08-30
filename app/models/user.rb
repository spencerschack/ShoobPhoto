class User < ActiveRecord::Base
  acts_as_authentic
  has_and_belongs_to_many :roles

  def role_symbols
    roles.map do |role|
      role.title.underscore.to_sym
    end
  end
end
