class Currency < ActiveRecord::Base
  validates_presence_of :uuid, :rates
end
