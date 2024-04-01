# README

## Introduction ##
Our team is creating an application, Jimmy, as a part of the TeamUp organization. This application will help students at Texas A&M University find workout buddies according to their preferences and interests: users will be able to create profiles with their preferred workout activities, workout times, gym location, etc., and Jimmy will present other users' profiles that matched theirs the best and potentially connect with new workout buddies.

## Requirements ##

This code has been run and tested on:

* Ruby - 3.1.2
* Rails - 7.0.8
* Ruby Gems - Listed in `Gemfile`
* PostgreSQL - 13.7

## External Deps  ##

* Docker - Download latest version at https://www.docker.com/products/docker-desktop
* Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
* Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

## Installation ##

Download this code repository by using git:

 `git clone https://github.com/CSCE431-Software-Engineering/teamup-jimmy`


## Tests ##

An RSpec test suite is available and can be ran using:

  `rspec spec/`

## Execute Code ##

Run the following code in Powershell if using windows or the terminal using Linux/Mac

  `cd teamup-jimmy`

  `docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 paulinewade/csce431:latest`

Install the app

  `bundle install && rails webpacker:install && rails db:create && db:migrate`

Run the app
  `rails server --binding:0.0.0.0`

The application can be seen using a browser and navigating to http://localhost:3000/

## Environmental Variables/Files ##

N/A yet, coming soon!


## Deployment ##

Setup a Heroku account: https://signup.heroku.com/

From the heroku dashboard select `New` -> `Create New Pipline`

Name the pipeline, and link the respective git repo to the pipline

Our application does not need any extra options, so select `Enable Review Apps` right away

Click `New app` under review apps, and link your test branch from your repo

Under staging app, select `Create new app` and link your main branch from your repo

--------

To add enviornment variables to enable google oauth2 functionality, head over to the settings tab on the pipeline dashboard

Scroll down until `Reveal config vars`

Add both your client id and your secret id, with fields `GOOGLE_OAUTH_CLIENT_ID` and `GOOGLE_OAUTH_CLIENT_SECRET` respectively

Now once your pipeline has built the apps, select `Open app` to open the app

With the staging app, if you would like to move the app to production, click the two up and down arrows and select `Move to production`

And now your application is setup and in production mode!


## CI/CD ##

For continuous development, we set up Heroku to automatically deploy our apps when their respective github branches are updated.

  `Review app: test branch`

  `Production app: main branch`

For continuous integration, we set up a Github action to run our specs, security checks, linter, etc. after every push or pull-request. This allows us to automatically ensure that our code is working as intended.

## References ##

- https://www.w3schools.com/howto/howto_js_filter_table.asp

## Support ##

Heroku Deployment Errors Solution: 
Use heroku logs --tail for error details. Common fixes include setting environment variables, running migrations, and checking the Procfile.

Database Migration Failures
Solution: Execute heroku run rake db:migrate. If errors occur, consider rolling back with heroku run rake db:rollback and correcting the migration script.
Application Crashing on Startup
Solution: Investigate with heroku logs --tail. Ensure dependencies are met, and the Procfile is correctly configured.

Slow Web App Performance
Solution: Review Heroku Dyno metrics and logs. Optimize database queries, consider dyno scaling, and use caching strategies.

Email Delivery Failures
Solution: Check third-party service dashboards (e.g., SendGrid) for errors. Ensure API keys and email settings are correctly configured in Heroku.

Failed Assets Precompilation
Solution: Precompile assets with RAILS_ENV=production rake assets:precompile. Ensure config.assets.initialize_on_precompile is false.

Connectivity Issues with External Services
Solution: Double-check credentials for external services in Heroku's config vars. Test connectivity through Heroku's console.
