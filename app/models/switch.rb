class Switch
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash
end
