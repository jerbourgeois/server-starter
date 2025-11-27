# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # In development, allow requests from localhost on any port
    # In production, replace with your actual React app domain
    origins_list = if ENV["CORS_ORIGINS"].present?
      ENV["CORS_ORIGINS"].split(",").map(&:strip)
    elsif Rails.env.development?
      # Allow common React development ports
      ["http://localhost:3000", "http://localhost:3001", "http://localhost:5173", "http://localhost:5174"]
    else
      # In production, specify your actual domain
      []
    end

    origins(*origins_list)

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ["Authorization"],
      credentials: true
  end
end
