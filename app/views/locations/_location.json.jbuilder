# frozen_string_literal: true

json.extract! location, :id, :name, :address_line_1, :address_line_2, :postcode, :country_code, :created_at, :updated_at
json.url location_url(location, format: :json)
