class Camp < ActiveRecord::Base

  attr_accessible :start_date, :end_date, :camp_type, :price, :location

end
