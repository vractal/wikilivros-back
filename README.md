# Teledipity - API

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

#### Clone the repository
```
$ git clone git@github.com:SeasonedSoftware/teledipity-api.git
$ cd teledipity-api
```

#### Install local bundler
Make sure you're running the correct ruby version. Run:

```
rbenv versions
```
It should return something like:
```
system
...(other ruby versions installed)...
* 2.5.3 (set by /home/<path-to-repo-folder>/teledipity-api/.ruby-version)

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
Verify that the bundler was installed inside `teledipity-api/.gems` folder.

#### Use local bundler to install the other gems
Always use this command to ensure the gems are installed in `.gems`.
```
$ bin/bundle
```

#### Set the env vars
```
$ cp .env.sample .env
```
Ask a colleague for the values.

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

## Deployment

### Staging

All commits to `master` branch will be pushed to staging by CircleCI.

### Production

Generate a new release - all tags will be automatically pushed to production.
