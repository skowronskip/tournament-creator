# Description [![Build Status](https://travis-ci.org/skowronskip/tournament-creator.svg?branch=master)](https://travis-ci.org/skowronskip/tournament-creator)
Tournament Creator - still in development.

It is backend side for application to manage tournament. Following functionalities ended so far:
- Sigining Up new Accounts and logging in to application with use of JWT.
- Creating o tournament with name and one of games from DB
- Adding, Editing participants of tournaments
- Generating matches with Round Robin system
- Editing match score
- Generating current Table of tournament

# Deployment
You have to Ruby 2.5.1 installed. In production enviroment, PostgreSQL is used.

1. You have to run 'bundle install' in main directory
2. In production enviroment you have to update the database config in config/database.yml
3. Run your local server: 'rails s'
4. Open 'http://localhost:3000' in your web browser

# Technologies
Used technologies:
- Ruby
- Ruby on Rails
- PostgreSQL

# Demo
Api is available on: http://api.tcreator.pskowron.ski
Front client: http://tcreator.pskowron.ski
