# Rails New API

<!-- [![Maintainability](https://api.codeclimate.com/v1/badges/5f81c59b93f185a611da/maintainability)](https://codeclimate.com/repos/5bf2ae161b9400146a004ddd/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/5f81c59b93f185a611da/test_coverage)](https://codeclimate.com/repos/5bf2ae161b9400146a004ddd/test_coverage) [![CircleCI](https://circleci.com/gh/SeasonedSoftware/new-rails-api.svg?style=svg)](https://circleci.com/gh/SeasonedSoftware/new-rails-api) -->

## Installation

### Install Dependencies

#### 1. Install PostgreSQL

[PostgreSQL](http://postgresql.org/)

#### 2. Install Rbenv

Rbenv: [repo](https://github.com/rbenv/rbenv)

- Check that the rbenv PATH is configured correctly, according to the repo instructions.

#### 3. Install Rbenv-gemset

Rbenv-gemset: [repo](https://github.com/jf/rbenv-gemset)

#### 4. Install ruby 2.5.3

```
$ rbenv install 2.5.3
```

If rbenv complains you don't have that ruby version, upgrade [ruby-build](https://github.com/rbenv/ruby-build#readme).

### Setup the project

#### Clone the repository & update git remote

```
$ git clone git@github.com:SeasonedSoftware/new-rails-api.git
$ cd new-rails-api
$ git remote set-url origin [your new github URL]
```

#### Rename your project references

1. First of all, rename the folder to match your project name
2. Now access the "find and replace" of your editor and select CASE SENSITIVE
3. Search and replace the following words:

```
NewRailsApi -> YourProjectName
new-rails-api -> your-project-name
```

#### Create a new README for your project

You can copy the README from [this project](https://github.com/SeasonedSoftware/brazil-lab-api/blob/master/README.md) and just change the badges and project name on title

#### Install local bundler

Make sure you're running the correct ruby version. Run:

```
rbenv versions
```

It should return something like:

```
system
...(other ruby versions installed)...
* 2.5.3 (set by /home/<path-to-repo-folder>/new-rails-api/.ruby-version)

```

Make sure you're using the correct gemset. Run:

```
rbenv gemset active
```

It should return:

```
.gems global
```

If both are ok, run:

```
$ gem install bundler
```

Verify that the bundler was installed inside `new-rails-api/.gems` folder.

#### Use local bundler to install the other gems

Always use this command to ensure the gems are installed in `.gems`.

```
$ bin/bundle
```

#### IF RUNNING A PROJECT THAT ALREADY EXISTS

#### Set the env vars

```
$ cp .env.sample .env
```

Ask a colleague for the values.

#### IF SETTING UP A NEW PROJECT

##### Generate a new master key

DO THIS ONLY WHEN SETTING UP A NEW PROJECT

You can choose the editor you prefer, for example:

```
$ EDITOR="nano" bin/rails credentials:edit
```

This will create `config/credentials.yml.enc` and `config/master.key`.
Commit `config/credentials.yml.enc` to git. Do not commit `config/master.key`.

Copy the contents of `master.key` to your `.env` file at `RAILS_MASTER_KEY=` and send it to the other team members. You will need it to deploy the API too.

##### Configure the api names

Search for the `new-rails-api` string on the project files and change it to your project name.

Some places to change:

```
circleci/config.yml
database.yml
config/cable.yml
production.rb
schema/meta.json
```

Suggestions to automate this process are welcome.

#### Prepare the database

```
$ bin/rails db:create db:migrate db:seed
```

## Running the server

```
$ bin/rails s
```

You can check that it worked by browsing `localhost:3000`.

## Tests

```
$ bin/rspec
```

The coverage will be available on the `coverage/` folder. Open `coverage/index.html` on your browser to see details.

#### Running the linter

```
$ bin/rubocop
```

## Docker help section

### Build the container for the project

```
$ docker-compose build

options:
--no-cache (build the entire container using no cached infos)
```

### Up the project

```
$ docker-compose up
```

### Listing running containers

```
$ docker ps

This command will show the running containers, example:

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
dfb80bf0ae96        postgres:10.4       "docker-entrypoint.s…"   3 hours ago         Up 3 hours          0.0.0.0:5432->5432/tcp   new-rails-api_postgres_1
```

### Running commands using docker-compose

```
$ docker-compose run [container name] [command]

example:

$ docker-compose run rails bin/rails db:create
```

### Running commands on a running container

```
$ docker exec [options] [container ID] [command]

options:

-i (interactive)
-t (attach terminal to command)

examples:

$ docker exec -it dfb80bf0ae96 bin/rails db:migrate
```

## Deployment

### Setup - for new projects

Create a one Heroku project for Staging and another one for Production.
Configure the `RAILS_MASTER_KEY` env var for both heroku projects (they are the same).
Configure the app names at `.circleci/config.yml` to match the heroku project names. Add the heroku api key.

### Staging

All commits to `master` branch will be pushed to staging by CircleCI.

### Production

Generate a new release - all tags in the format `vX`, where `X` is an integer, will be automatically pushed to production.
