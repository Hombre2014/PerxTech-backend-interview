json.extract! purchase, :id, :date, :country_of_purchase, :amount, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
