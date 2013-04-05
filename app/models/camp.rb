class Camp < ActiveRecord::Base

  attr_accessible :start_date, :end_date, :camp_type, :price, :location

  default_scope order('start_date')

  has_many :reservations

end
