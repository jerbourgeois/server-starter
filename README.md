# Server Starter - API Edition

A modern Rails 8 API-only starter template for building backend services. Perfect for serving React, Vue, or any JavaScript frontend framework. This template includes all the essential features you need to kickstart your next API project.

## Features

- **Rails 8.1.1 (API Mode)** - Latest stable version configured for API-only applications
- **PostgreSQL** - Production-ready relational database
- **JWT Authentication** - Token-based authentication with Devise-JWT
- **CORS Configured** - Ready to accept requests from your frontend applications
- **Environment Configuration** - dotenv-rails for managing environment variables
- **Docker Support** - Ready for containerized deployment with Kamal
- **Solid Suite** - Solid Cache, Solid Queue, and Solid Cable for background jobs and caching
- **Security Tools** - Brakeman and bundler-audit for security scanning
- **Code Quality** - RuboCop with Rails Omakase style guide
- **CI/CD Ready** - GitHub Actions workflow included
- **API Versioning** - Clean `/api/v1/` structure for future-proof APIs

## System Requirements

- **Ruby**: 3.2.3 or higher
- **Rails**: 8.1.1
- **PostgreSQL**: 9.3 or higher

## Getting Started

### 1. Clone or Copy This Template

```bash
git clone <your-repo-url>
cd server-starter
```

### 2. Install Dependencies

```bash
bundle install
```

### 3. Configure Environment Variables

Copy the example environment file and configure your local settings:

```bash
cp .env.example .env
```

Edit `.env` and update the database credentials:

```env
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=your_password
DATABASE_HOST=localhost
DATABASE_PORT=5432
```

### 4. Set Up the Database

Create and migrate the database:

```bash
rails db:create
rails db:migrate
```

Optional - seed the database with sample data:

```bash
rails db:seed
```

### 5. Start the Development Server

```bash
rails server
```

The API will be available at http://localhost:3000

## Database Configuration

The database is configured to use environment variables for flexibility across different environments. The configuration supports:

- **Development**: Uses environment variables with sensible defaults
- **Test**: Separate test database
- **Production**: Multi-database setup for primary, cache, queue, and cable

Database credentials are managed through the `.env` file (not committed to git) using dotenv-rails.

## API Authentication

User authentication is powered by Devise with JWT (JSON Web Tokens). The API uses token-based authentication perfect for frontend frameworks.

### Authentication Flow

1. **Sign Up**: POST to `/api/v1/signup` to create a new user
2. **Login**: POST to `/api/v1/login` to receive a JWT token in the `Authorization` header
3. **Authenticated Requests**: Include the JWT token in the `Authorization` header for protected endpoints
4. **Logout**: DELETE to `/api/v1/logout` to revoke the token

### API Endpoints

#### User Registration
```bash
POST /api/v1/signup
Content-Type: application/json

{
  "user": {
    "email": "user@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
}
```

**Response:**
```json
{
  "message": "Signed up successfully.",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "created_at": "2025-01-27T12:00:00.000Z"
  }
}
```

#### User Login
```bash
POST /api/v1/login
Content-Type: application/json

{
  "user": {
    "email": "user@example.com",
    "password": "password123"
  }
}
```

**Response:**
```json
{
  "message": "Logged in successfully.",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "created_at": "2025-01-27T12:00:00.000Z"
  }
}
```
**Headers:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

#### User Logout
```bash
DELETE /api/v1/logout
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response:**
```json
{
  "message": "Logged out successfully."
}
```

### Creating Your First User via Console

```ruby
rails console
User.create(email: 'user@example.com', password: 'password123', password_confirmation: 'password123')
```

### Testing with curl

#### Sign Up
```bash
curl -X POST http://localhost:3000/api/v1/signup \
  -H "Content-Type: application/json" \
  -d '{"user": {"email": "test@example.com", "password": "password123", "password_confirmation": "password123"}}'
```

#### Login
```bash
curl -X POST http://localhost:3000/api/v1/login \
  -H "Content-Type: application/json" \
  -d '{"user": {"email": "test@example.com", "password": "password123"}}' \
  -i
```

Note: The `-i` flag shows headers including the `Authorization` header with your JWT token.

#### Logout
```bash
curl -X DELETE http://localhost:3000/api/v1/logout \
  -H "Authorization: Bearer YOUR_JWT_TOKEN_HERE"
```

## CORS Configuration

Cross-Origin Resource Sharing (CORS) is pre-configured to allow requests from common frontend development servers:
- http://localhost:3000
- http://localhost:5173 (Vite default)
- http://localhost:5174

To add custom origins, update the `CORS_ORIGINS` environment variable in your `.env` file:

```env
CORS_ORIGINS=http://localhost:3000,http://localhost:5173,https://your-production-domain.com
```

## React Frontend Integration

Here's how to integrate this API with your React application:

### Login Example
```javascript
const login = async (email, password) => {
  const response = await fetch('http://localhost:3000/api/v1/login', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      user: { email, password }
    })
  });

  // Get JWT token from Authorization header
  const token = response.headers.get('Authorization');

  // Store token for future requests
  localStorage.setItem('token', token);

  return response.json();
};
```

### Making Authenticated Requests
```javascript
const fetchProtectedData = async () => {
  const token = localStorage.getItem('token');

  const response = await fetch('http://localhost:3000/api/v1/your_resource', {
    headers: {
      'Authorization': token,
      'Content-Type': 'application/json'
    }
  });

  return response.json();
};
```

### Logout Example
```javascript
const logout = async () => {
  const token = localStorage.getItem('token');

  await fetch('http://localhost:3000/api/v1/logout', {
    method: 'DELETE',
    headers: {
      'Authorization': token
    }
  });

  // Clear stored token
  localStorage.removeItem('token');
};
```

## Project Structure

```
server-starter/
├── app/
│   ├── controllers/
│   │   ├── api/
│   │   │   └── v1/          # API v1 controllers
│   │   │       ├── base_controller.rb
│   │   │       ├── sessions_controller.rb
│   │   │       └── registrations_controller.rb
│   │   └── application_controller.rb
│   ├── models/              # ActiveRecord models
│   │   ├── user.rb
│   │   └── jwt_denylist.rb
│   └── serializers/         # JSON serializers
│       └── user_serializer.rb
├── config/
│   ├── database.yml         # Database configuration
│   ├── routes.rb            # API routes
│   ├── initializers/
│   │   ├── cors.rb          # CORS configuration
│   │   └── devise.rb        # JWT authentication config
│   └── environments/        # Environment-specific configs
├── db/
│   ├── migrate/             # Database migrations
│   └── seeds.rb             # Database seeds
├── test/                    # Test files
├── .env                     # Environment variables (git-ignored)
├── .env.example             # Example environment variables
├── Dockerfile               # Docker configuration
└── API_CONVERSION_GUIDE.md  # Detailed API setup guide
```

## Running Tests

```bash
rails test
```

Note: System tests with browser automation are not applicable for API-only applications.

## Security Scanning

Run security audits:

```bash
bin/brakeman        # Static security analysis
bin/bundler-audit   # Check for vulnerable dependencies
```

## Code Quality

Check code style with RuboCop:

```bash
bin/rubocop
bin/rubocop -a  # Auto-correct offenses
```

## Deployment

This starter includes configuration for deployment with Kamal (Rails 8's deployment tool):

```bash
# Configure your deployment in config/deploy.yml
kamal setup
kamal deploy
```

### Docker Deployment

The included Dockerfile allows you to containerize your application:

```bash
docker build -t server-starter .
docker run -p 3000:3000 server-starter
```

## Customization

### Changing the Application Name

1. Update `config/application.rb` - Change the module name
2. Update `config/database.yml` - Change database names
3. Update this README

### Adding New API Endpoints

This is a starter template - feel free to add your own resources:

```bash
# Generate a model
rails generate model Post title:string content:text user:references

# Run migrations
rails db:migrate

# Create API controller
# Create file: app/controllers/api/v1/posts_controller.rb
```

Example API controller:
```ruby
module Api
  module V1
    class PostsController < BaseController
      before_action :authenticate_user!

      def index
        posts = Post.all
        render json: posts
      end

      def show
        post = Post.find(params[:id])
        render json: post
      end

      def create
        post = current_user.posts.build(post_params)
        if post.save
          render json: post, status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :content)
      end
    end
  end
end
```

Add routes in `config/routes.rb`:
```ruby
namespace :api do
  namespace :v1 do
    # ... existing routes ...
    resources :posts
  end
end
```

## Environment Variables

Key environment variables (see `.env.example` for full list):

| Variable | Description | Default |
|----------|-------------|---------|
| `DATABASE_USERNAME` | PostgreSQL username | `postgres` |
| `DATABASE_PASSWORD` | PostgreSQL password | (empty) |
| `DATABASE_HOST` | PostgreSQL host | `localhost` |
| `DATABASE_PORT` | PostgreSQL port | `5432` |
| `RAILS_ENV` | Rails environment | `development` |
| `RAILS_MAX_THREADS` | Puma max threads | `5` |
| `CORS_ORIGINS` | Allowed CORS origins (comma-separated) | See `.env.example` |

## Common Tasks

### Reset Database

```bash
rails db:drop db:create db:migrate db:seed
```

### Check Routes

```bash
rails routes
```

View all available API endpoints.

### Open Rails Console

```bash
rails console
```

### Generate Secret for JWT

```bash
rails secret
```

Use this to generate a new secret key for production.

## Troubleshooting

### Database Connection Issues

- Ensure PostgreSQL is running
- Verify credentials in `.env`
- Check `config/database.yml` settings

### CORS Issues

- Verify `CORS_ORIGINS` in your `.env` file includes your frontend URL
- Check CORS configuration in `config/initializers/cors.rb`
- Ensure your frontend is sending requests with correct headers

### JWT Authentication Issues

- Check that the `Authorization` header is being sent with requests
- Verify the token format: `Bearer <token>`
- Check token expiration (default: 1 day)
- Review JWT configuration in `config/initializers/devise.rb`

### API Response Issues

- Ensure `Content-Type: application/json` header is set in requests
- Check that request payloads are properly formatted JSON
- Review controller error handling

## Contributing

This is a starter template for your projects. Fork it, customize it, and make it your own!

## License

This starter template is available as open source under the terms of your chosen license.

## Resources

- [Rails API-Only Guide](https://guides.rubyonrails.org/api_app.html)
- [Devise Documentation](https://github.com/heartcombo/devise)
- [Devise-JWT Documentation](https://github.com/waiting-for-dev/devise-jwt)
- [Rack-CORS Documentation](https://github.com/cyu/rack-cors)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Kamal Deployment](https://kamal-deploy.org/)
- [JWT.io](https://jwt.io/) - Learn about JSON Web Tokens
