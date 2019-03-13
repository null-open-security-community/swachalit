# System Components

* Rails Application
* Resque Workers
* Resque Scheduler (TODO)
* Redis Server
* MySQL Server
* Nginx as Reverse Proxy

## Deployment

### Steps for Deployment

* Source code deployment on remote server.
* Library dependency installation/upgrade on remote server.
* Database schema update on remote server.
* Static asset recompilation on remote server.
* Application server & misc. scripts re-start on remote server.

**Note:** First time deployment requires additional steps of creating directory structure, database configuration etc.
### Shared Resources

Following files with correct content must be deployd in shared folder:

* mailgun.rb
* twitter.rb
* google_api_key.p12

### Procedure

#### Local Machine

* Obtain local copy of the source code from repository.
<pre>
git clone https://<username>@bitbucket.org/null0x00/null-automation-framework.git
</pre>

* Edit `config/deploy.rb` as required.
* Execute automatic deployment script
	* This will perform a remote deployment based on configurations from `config/deploy.rb`.
	* The server address and credentials are defined in `config/deploy.rb`
<pre>
cap deploy
</pre>

**Note:** You must have Ruby 1.9.x and Bundler (`gem install bundler`) installed on your local system for the deployment script to run correctly.

#### Remote Server

* Switch to the directory where the application was deployed.
	* Example: `/var/apps/swachalit/current`

* Install dependencies
<pre>
bundle install
</pre>

**Note:** This might raise exception if appropriate system libraries are not found. For example `mysql2` gem requires `libmysqlclient` and `libmysqlclient-dev` for Ubuntu.

* Upgrade schema
<pre>
rake db:migrate
</pre>

* Pre-compile assets
<pre>
rake assets:precompile
</pre>

* There is a script available that performs all previous (3) steps:
<pre>
./script/run_build.sh
</pre>


## Start Application

* Start Redis server
* Start Rails Application server
<pre>
./script/run_app.sh
</pre>
* Start Resque workers
<pre>
./script/run_workers.sh
</pre>
* Start Resque scheduler (TODO)

