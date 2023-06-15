# BoardGames

The Board Games app is a convenient solution for organizing meetups among tabletop and board game enthusiasts. This application allows users to schedule game sessions, subscribe to them, and engage with other participants through comments and photos. Also, the meetup initiator has the option of restricting access to the game to arrange a meeting with only certain people.

## Technologies Used

- Ruby on Rails 7.0.5 and Ruby 3.1.4
- Devise for authentication
- Pundit for authorization
- Bootstrap for website design
- Active Storage and Yandex Cloud for file management
- Lightbox gallery for viewing photos
- Action Mailer for email notifications
- Google reCAPTCHA for spam prevention
- Rails Internationalization (I18n) for Russian language support
- Capistrano for deployment

## Deployment

The Board Games app is deployed [here](http://45.12.72.110/). Feel free to visit and explore!

## Usage

### Prerequisites

Make sure you have Ruby 3.1.4 installed on your system. You can use a version manager like [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://github.com/rvm/rvm) for this purpose. Also you need to install [libvips](https://github.com/libvips/libvips/wiki) to make Active Storage work and [Node.js](https://nodejs.org/en/download) and [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/#debian-stable) to compile assets.

### Installation

To set up the app locally, follow these steps:

1) Clone the repository to your local machine:
```
git clone https://github.com/dr-or/boardgames
```

2) Navigate to the app directory:
```
cd boardgames
```

3) Install the required dependencies:
```
bundle config set --local without 'production'
bundle install
```

4) Run database migrations:
```
bundle exec rails db:migrate
```

5) Compile the assets:
```
bundle exec rails assets:precompile
```

6) Delete my credentials:
```
rm config/credentials.yml.enc
```

Configure your credentials in a new `config/credentials.yml.enc` file:
```
EDITOR='<your editor> --wait' rails credentials:edit
```
Provide the required values for the following settings:
```
mail:
  username: 'example@mail.com' # leave it as it is or put your e-mail
recaptcha:
  site_key: 
  secret_key:
```

7) Start the server:
```
bin/dev
```
<sub> Access the app locally by visiting http://localhost:3000. You can stop the server at any time by pressing **\`Ctrl + C\`**. </sub>

## Postscript

In the production environment, the credentials are stored in a separate directory `config/credentials`. The complete structure of the `production.yml.enc` file is as follows:

```
db: 
db_owner: 
db_owner_password: 

mail:
  username: 
  password: 

recaptcha:
  site_key: 
  secret_key: 

yc:
  access_key_id: 
  secret_access_key: 

secret_key_base:
```

**Note:** yc refers to Yandex Cloud, used for storing Active Storage files only on a server. In the development environment, files are stored locally. 

db represents the database, which is PostgreSQL on VPS. 

Emails are sent via Gmail on a server (check `config/environments/production.rb`). Locally their sending is simulated by the gem 'letter-opener'.
