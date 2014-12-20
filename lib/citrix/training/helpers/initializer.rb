module Citrix
  module Training
    module Helpers
      module Initializer
        def initialize(attributes = {})
          attributes.each do |name, value|
            public_send "#{name}=", value
          end
        end
      end
    end
  end
end
