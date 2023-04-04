class Closet < ApplicationRecord
  
  enum season_method: { spring:0, summer:1, autumn:2, winter:3, other:4 }
  
end
