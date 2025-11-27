# Server Starter

A modern Rails 8 starter template for building web applications quickly. This template includes all the essential features you need to kickstart your next project.

## Features

- **Rails 8.1.1** - Latest stable version with modern features
- **PostgreSQL** - Production-ready relational database
- **Devise Authentication** - Complete user authentication system
- **Hotwire** - Turbo and Stimulus for SPA-like interactivity
- **Environment Configuration** - dotenv-rails for managing environment variables
- **Docker Support** - Ready for containerized deployment with Kamal
- **Modern Asset Pipeline** - Importmap for JavaScript modules
- **Solid Suite** - Solid Cache, Solid Queue, and Solid Cable for background jobs and caching
- **Security Tools** - Brakeman and bundler-audit for security scanning
- **Code Quality** - RuboCop with Rails Omakase style guide
- **CI/CD Ready** - GitHub Actions workflow included

## System Requirements

- **Ruby**: 3.2.3 or higher
- **Rails**: 8.1.1
- **PostgreSQL**: 9.3 or higher
- **Node.js**: 18+ (for asset compilation)

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
bin/dev
```

Or use the traditional Rails server:

```bash
rails server
```

Visit http://localhost:3000 in your browser.

## Database Configuration

The database is configured to use environment variables for flexibility across different environments. The configuration supports:

- **Development**: Uses environment variables with sensible defaults
- **Test**: Separate test database
- **Production**: Multi-database setup for primary, cache, queue, and cable

Database credentials are managed through the `.env` file (not committed to git) using dotenv-rails.

## Authentication

User authentication is powered by Devise. The starter includes:

- User registration
- User login/logout
- Password reset functionality
- Email confirmation (can be enabled)
- Remember me functionality

### Creating Your First User

You can create a user through the web interface at http://localhost:3000/users/sign_up or via Rails console:

```ruby
rails console
User.create(email: 'user@example.com', password: 'password123', password_confirmation: 'password123')
```

## Project Structure

```
server-starter/
├── app/
│   ├── controllers/      # Application controllers
│   ├── models/           # ActiveRecord models
│   ├── views/            # View templates
│   ├── javascript/       # Stimulus controllers and JS
│   ├── assets/           # Stylesheets and images
│   └── helpers/          # View helpers
├── config/
│   ├── database.yml      # Database configuration
│   ├── routes.rb         # Application routes
│   ├── initializers/     # Rails initializers
│   └── environments/     # Environment-specific configs
├── db/
│   ├── migrate/          # Database migrations
│   └── seeds.rb          # Database seeds
├── test/                 # Test files
├── .env                  # Environment variables (git-ignored)
├── .env.example          # Example environment variables
├── Dockerfile            # Docker configuration
└── config.ru             # Rack configuration
```

## Running Tests

```bash
rails test
rails test:system  # Run system tests with browser automation
```

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
3. Update `package.json` - Change the name field
4. Update this README

### Adding New Features

This is a starter template - feel free to add or remove features:

- **Add gems** to `Gemfile` and run `bundle install`
- **Generate models**: `rails generate model ModelName`
- **Generate controllers**: `rails generate controller ControllerName`
- **Generate Stimulus controllers**: `rails generate stimulus ControllerName`

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

## Common Tasks

### Reset Database

```bash
rails db:drop db:create db:migrate db:seed
```

### Generate Devise Views (for customization)

```bash
rails generate devise:views
```

### Check Routes

```bash
rails routes
```

### Open Rails Console

```bash
rails console
```

## Troubleshooting

### Database Connection Issues

- Ensure PostgreSQL is running
- Verify credentials in `.env`
- Check `config/database.yml` settings

### Asset Issues

- Clear asset cache: `rails assets:clobber`
- Rebuild assets: `rails assets:precompile`

### Devise Issues

- Check email configuration in `config/environments/development.rb`
- Review Devise initializer at `config/initializers/devise.rb`

## Contributing

This is a starter template for your projects. Fork it, customize it, and make it your own!

## License

This starter template is available as open source under the terms of your chosen license.

## Resources

- [Rails Guides](https://guides.rubyonrails.org/)
- [Devise Documentation](https://github.com/heartcombo/devise)
- [Hotwire Documentation](https://hotwired.dev/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Kamal Deployment](https://kamal-deploy.org/)
