class Post < ApplicationRecord

  acts_as_tenant(:tenant)
end
