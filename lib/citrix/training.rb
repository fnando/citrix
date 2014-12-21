require 'time'

require 'aitch'

require 'citrix/training/helpers/initializer'
require 'citrix/training/helpers/http_client'
require 'citrix/training/credentials'
require 'citrix/training/client'
require 'citrix/training/namespace/trainings'
require 'citrix/training/resource/training'
require 'citrix/training/serializer/training'
require 'citrix/training/resource/training_date'
require 'citrix/training/serializer/training_date'

module Citrix
  module Training
    API_ENDPOINT = 'https://api.citrixonline.com/G2T/rest'
  end
end
