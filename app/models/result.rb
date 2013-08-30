class Result < ActiveRecord::Base
  belongs_to :runner
  belongs_to :race
  
  validates_presence_of :runner_id, :race_id, :distance
end
