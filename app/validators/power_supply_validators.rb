# class PowerSuppliesValidators < ActiveModel::Validator
# 	def validate(record)
# 		if record.nil?
#       record.errors[:base] << "The object can't be null"
#     elsif record.properties.nil?
#       record.errors[:base] << "properties attirbute can't be nil"
#     elsif not record.properties.is_a?(Hash)
#       record.errors[:base] << "properties must be a Hash"
#     else
#       PowerSuppliesHelper::required_fields.each do |key|
#         if not record.properties.has_key? key
#           record.errors[:base] << "properties must have :#{key} key"
#         elsif record.properties[key] == nil
#           record.errors[:base] << "properties[:#{key}] can't be nil"
#         end
#
#         if record.properties[key] == ""
#           record.errors[:base] << "properties[:#{key}] can't be empty string"
#         end
#       end
#     end
# 	end
# end
