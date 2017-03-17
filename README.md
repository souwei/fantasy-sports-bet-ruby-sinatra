## Idea and Inspiration
 I used to play a of simulation games such as Football Manager but could not find similar version for basketball that i enjoy
but recently i found a very similar concept in NBA2k17 videogame published by 2kSPORTS.
<a href="https://ibb.co/fq5gaa"><img src="https://image.ibb.co/gbNSFa/nba2kmtr.png" alt="nba2kmtr" border="0"></a><br /><a target='_blank' href='https://imgbb.com/'>NBA2k MYTEAM</a><br />
<a href="https://ibb.co/kp0NFa"><img src="https://image.ibb.co/hFg7gF/2353882_0001.jpg" alt="2353882_0001" border="0"></a><br /><a target='_blank' href='https://imgbb.com/'>Football Manager</a><br />
So i thought of combining ideas from both games and add a virtual bet twist to it.

## Plan and Approach 
#### Overview
- I started by thinking what the main "feature" or selling point of my web application which was to allow users to bet on "real" sportsevent with real odds with virtual currency. With the collected virtual currency, users will then be able to purchase "players" from the app and build their own teams and pit their teams against other players.
- I understood that my final product for this project would not be completed in time , therefore i tried to break down
users should be able to see livesports / basketball events on the home page and the win odds set by bookers, then be able to bet virtual currency
on these games.
- Due to being unable to find a free API that shows live game schedules, odds and results, i decided to manually insert games into the database for the time being.
- The next phase was to run either a algorithm or a simple random pick of winner to determine a "game result" which would determine
the outcome of the bet.
#### Core Features
I went to planning my project by questioning, what are the immediate features that i needed to develop in order to help my end-user
achieve their goal or objective? Asides from technical requirements, Every other feature was secondary for now.
1. See Games
2. Bet On These Games
3. Modify "Live" Bets
4. Delete "Live" Bets
5. See Result

#### ER Diagram and Classess
Then i designed the ER diagram with classes.
<a href="https://ibb.co/byKeTv"><img src="https://image.ibb.co/cOBF1F/er_diagram.png" alt="er_diagram" border="0"></a><br /><a target='_blank' href='https://imgbb.com/'></a><br />

#### User Workflow
With the core features, i also came up with a simple workflow to determine the types of web pages i would need.
<a href="https://ibb.co/hjO1aa"><img src="https://image.ibb.co/mNAgaa/Untitled_Diagram.png" alt="Untitled_Diagram" border="0"></a>
#### Sinatra Paths
I proceed to draft out the sinatra paths of the web pages.

|Method   	|Path   	|Action   	|Page
|---	|---	|---	|---
|GET   	|/   	|Home Page   	|index.erb
|GET  	|/games  	|Show All Games   	|games.erb
|GET  	|/bets  	|List All User Bets   	|account.erb
|POST  	|/bets   	|Create a new Bet   	| redirect to  GET /bets
|GET  	|/bets/edit/:id   	|Edit Bet Page   	| editbet.erb
|PUT  	|/bets/edit/:id   	|Edit Bet   	| redirect to  GET /bets
|POST  	|/bets   	|Create a new Bet   	| redirect to  GET /bets
|GET  	|/bets/:id/delete   	|Delete Bet Page   	| delete_confirm.erb
|DELETE  	|/bets/:id/delete   	|Delete a Bet  	| redirect to  GET /bets
|GET  	|/user/new   	|Show Register Page   	| newuser.erb
|POST  	|/user/new   	|Register User   	| user_register_success.erb
|POST  	|/user/edit  	|Edit User Profile Page   	| user_edit.erb
|POST  	|/session  	|Authenticate login    	| redirect GET /
|DELETE  	|/session   	|Log out from session  	| redirect to  GET /

#### Layout Wireframe
Finally i drafted a simple layout that will be used for all the pages in the web app.
<a href="https://ibb.co/jsB4va"><img src="https://image.ibb.co/fcYHFa/fantasy_not_signed_in.png" alt="fantasy_not_signed_in" border="0" style="width:40px"></a><br /><a target='_blank' href='https://imgbb.com/'>online uploader</a><br />
<a href="https://ibb.co/c0DTMF"><img src="https://image.ibb.co/f5Qa1F/fantasy_logged_in.png" alt="fantasy_logged_in" border="0"></a><br /><a target='_blank' href='https://imgbb.com/'></a><br />


## Technologies Used
### Front End
- HTML,CSS,Bootstrap library for majority of presentation, layout.
- Some javascript and jquery to handle dynamic changes in  presentation data to user.
### Back End
## <img src="http://www.oceancircuitmedia.com/css/images/ruby.png" height='80px' > ##
- Ruby

|Gem Used   	|Used For
|---	|---
|Sinatra   	|Web Framework
|Bcrypt  	|Encrypt password and authenticate
|Httparty  	|connect to API and retrieve data
|ActiveRecord 	|access to database and provide ORM platform

### Database
- PostgreSQL


### Installation
I packaged my web app using the bundle install command which installs all the gems required for my app and bundled it
as a whole.Then i deployed the app to heroku by creating a heroku app from console then pushed my bundled app to the heroku container.
I proceeded to create my tables by inserting SQL commands from the heroku PG:PSQL command. Finally the app is then
online and available for end users.

### Unsolved Problems / Incomplete Features
- Haven't completed javascript feature to calculate bet returns (stake amount * odds) and display to user.
- Haven't completed password change in main.rb
- Lack of client and server side form data validations
- Haven't found a free-to-use sportsbet API that delivers game schedules, odds and results.
- Therefore not able to determine the Game outcome and subsequently bet outcomes.

### "Ideal" Features
- Create "League" class which will be able to categorize games into "Real Games" and "Fantasy League"
- Create "Teams" class which will have "Real Teams" and "Fantasy Teams"
- Create "Players" class which will have active players in the league and retired players that will contain attributes and statlines
- Add simulating feature which will simulate matches at a set interval where "users" can bet on games where simulation has not run yet.
