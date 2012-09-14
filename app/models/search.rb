class Search < ActiveRecord::Base
  attr_accessible :last_crawled_at, :query
end
