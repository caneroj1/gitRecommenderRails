class User < ActiveRecord::Base
  serialize(:language_breakdown, Array)
end
