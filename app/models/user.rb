class User < ActiveRecord::Base

  include Authem::Model

  attr_accessible :email, :salt, :crypted_password, :password, :password_confirmation


end
