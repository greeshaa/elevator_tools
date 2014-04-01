class Inspection < ActiveRecord::Base
  attr_accessible :inspection_at, :plained_at

  belongs_to :lift
end
