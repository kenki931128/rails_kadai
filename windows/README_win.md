# ROR reference for Windows user

If you want to use Virtual machine that would not affect your computer environment, you can refer the following steps to build a simple sample Rails application.
Otherwise, you can do with your own preference.

## 1. Install VirtualBox
[Download VirtualBox](https://www.virtualbox.org/wiki/Downloads) <br/>
Select Windows hosts

## 2. Install Vagrant 
[Download Vagrant](https://releases.hashicorp.com/vagrant/2.0.3/) <br/>
Select vagrant_2.0.3_x86_64.msi


## 3. Set VM
#### (1) Make directory
```code
> mkdir c:\assmt
> cd c:\assmt
```

#### (2) Add VM machine
```code
>  vagrant box add CentOS6.5 https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box
```
```code
> mkdir C:\assmt\CentOS
> cd C:\assmt\CentOS
> vagrant init CentOS6.5
```

#### (3) Start VM
```code
> vagrant up
```
Connect to the VM terminal

```
> vagrant ssh
```

When you want to stop the VM, run:

```
> vagrant halt
```

## 4. Install Ruby
In the connected VM terminal, run:

```
> sudo yum update
> sudo yum -y install git gcc make openssl-devel zlib-devel readline* gcc-c++
> sudo yum -y install nodejs
> sudo yum -y install sqlite-devel
```

Then install ruby:

```
> git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
> echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
> echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
> . ~/.bash_profile
> git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
> rbenv install -l
> rbenv install -v 2.4.0
> rbenv rehash
> rbenv global 2.4.0
```

Check installed ruby:

```
> ruby -v
``` 

## 5. Install Rails and several packages
In the VM terminal:

```
> git clone https://github.com/kenki931128/rails_kadai.git
```

```
> cd rails_kadai/windows
> ./setup_win.sh
```

## 6. Build a sample app
Change the host and port in the 'Vagrantfile'
If you already started the VM, halt it with the halt command that mentioned above.

```
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 3000, host: 3000
```

Deploy a sample appp:

```
> cd /vagrant
> rails new sample
> cd sample
> rails g scaffold Twitter tweet:string
> rake db:migrate
> rails server
```

Then you should find the page in the browser with:

```
http://localhost:3000/twitters
```

## 7. Upload and deploy with Heroku
If you don't have an account for git and heroku, please create git and heroku accounts.

Also you can refer the procedure write in README_en.md

Before upload, you have to change the database setting in Gemfile

```
#Comment out sqlite3 and replace with pg

# gem 'sqlite3', group: :development
gem 'pg', group: :production

#In config/database.yml, production part:
production:
    <<: *default
    adapter: postgresql
    encoding: unicode
    pool: 5
    
```

Don't forget bundle install after changing the Gemfile
```
bundle install
```

Install heroku cli in this link with windows version: https://devcenter.heroku.com/articles/heroku-cli

Then in windows prompt CMD (not in virtual machine)
You can check if it is installed by:

```
heroku --version
```

Upload your project to heroku


```
# cd to your project folder
cd:/assmt/centos/(app name)

# login with heroku, it will ask your email and password
heroku login
heroku create (server name) (server name should be long because you cannot use same name with anyone.)
git init
git add .
git commit -m "initial commit" 

# if it request your git account, run the following command
git config --global user.email "your email address"

heroku git:remote -a (server name)

# Before pushing, making sure that you have commented out the "gem 'sqlite3', group: :development" in Gemfile and replaced with pg "gem 'pg', group: :production"

git push heroku master
heroku run:detached rake db:migrate
```
Then you can find your repo in heroku https://dashboard.heroku.com/apps

Confirm the working on http://(server name).herokuapp.com/
