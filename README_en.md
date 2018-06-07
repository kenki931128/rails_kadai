# Practice of Information System Design Ruby on rails format

This is how to create the environment where you can use Ruby on rails.

This is for Mac User, so if not, please let TA know.

## Prepare

- [Xcode](https://itunes.apple.com/jp/app/xcode/id497799835?mt=12) and command line tools are needed.

If you still don't install Xcode, go to App store from the above link and please install it.

After open Xcode, input to commandline

`xcode-select --install`

## How to setup

Execute the following commands in any directory, 

1. `git clone https://github.com/kenki931128/rails_kadai.git`
2. `cd rails_kadai`
3. `rm -rf .git/`
4. `./setup.sh` (`./setup`) (No need if you already have VirtualBox and Vagrant)

## Prepare for Ruby on rail s

1. `vagrant up` (it takes about 25 minutes for the first time, from the second time, about 90s)
2. `vagrant ssh` (login to local server)
3. `cd /vagrant`
4. `rails new (app name)`
5. `cd (app name)`
6. `rails s`

you might access http://192.168.33.10:3000/

## How to edit Ruby on rails

- You could find rails_kadai/(app name)
- You edit these files directly

If you confirm the working, after login, execute the following commands.

1. `cd /vagrant/(app name)`
2. `rails s`

and access http://192.168.33.10:3000/

## commands for Vagrant

vagrant is commandline tool for creating Virtual Environment easily.


|description|command|
|:--:|:--:|
|start VM（in the project directory）|`vagrant up`|
|stop VM|`vagrant halt`|
|confirm the status of VM|`vagrnt status`|
|ssh login to VM|`vagrant ssh`|
|delete VM|`vagrant box remove <box_name>`|

## How to upload to Heroku

### Modify to uplad
1. modify `Gemfile`

```
gem 'sqlite3', group: :development
gem 'pg', group: :production
```

2. `bundle install`

3. modify `production` of `config/database.yml`

```
production:
  <<: *default
  adapter: postgresql
  encoding: unicode
  pool: 5
```

4. modify the code `#!/usr/bin/env ruby2.4` to `#!/usr/bin/env ruby` in all files under `bin`

#### deploy to heroku and git
If you don't have an account for git and heroku, please create [git](https://github.com/) and [heroku](https://jp.heroku.com/home)

1. `heroku login`
2. `heroku create (server name)` (server name should be long because you cannot use same name with anyone.)
3. `git init`
4. `git add .`
5. `git commit -m "initial commit"`
6. `heroku git:remote -a (server name)`
7. `git push heroku master`
8. `heroku run:detached rake db:migrate` 

Confirm the working on http://(server name).herokuapp.com/

