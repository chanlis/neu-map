# NEU MAP
GITHUB REPO: https://github.com/chanlis/neu-map/

WEBPAGE: http://neumap.lisachan.info/

Web application built using Elixir and Phoenix, and Google Maps API serving as an interactive Northeastern University campus map. The application provides a database of all buildings (academic, service, residential, parking) and their locations. The purpose of this project is to assist in navigating around campus through easy search methods (by address, building name, service offered, etc), an improvement to the [current campus map](https://www.northeastern.edu/campusmap/map/index.html) provided on Northeastern’s website. Using Google Maps API to create a web app that allows users to enter into a search bar either a building name, building street address, building area name, area name, service name, service tag name, or favorites name which will show the building’s pinpointed latitude and longitude if the query is successful.

## Demo
Visit the [webpage](http://neumap.lisachan.info/) and login with the following credentials:
- email: test@example.com
- password: neumaptest

For access to an admin user, email [chan.lis@husky.neu,edu](mailto:chan.lis@husky.neu.edu) with a request.

## Running this locally
- Install the latest nodejs using nvm. Follow the directions here: [Node Version Manager](https://github.com/creationix/nvm).
- Install Erlang v20.0 and Elixir 1.5.1. Follow the directions here: [Installing Elixir](https://elixir-lang.org/install.html).
- Install Phoenix v1.3, directions here: [Installing Phoenix](https://hexdocs.pm/phoenix/installation.html).
- Clone this repo using `git clone https://github.com/chanlis/neu-map.git`
- cd into this `neu-map` repository. 
- Run `mix deps.get`
- Setup your dev database with:
````
sudo su - postgres 
createuser -d -P neu_map
Enter password: Xae2haebae
Again: Xae2haebae
exit
````
- Create the database with `mix ecto.create`
- Add migrations `mix ecto.migrate`
- Assuming the path to the csv files in `priv/repo/seed.exs` are correct, run `mix run priv/repo/seed.exs`
- Start up localhost server using `mix phx.server`
View the web app on `localhost:4000`.

## Functionalities Implemented
CRUD functionalities can be found on each object User, Area, Building, Service, Tag, and Favorite.

Sign up as new user:
- Visit application.
- Click "signup" button on navigation bar.
- Fill in form appropriately (name is optional, email is unique, and password is at least 8 charcters).
- If input fields are valid, add new user to User table and redirect to home page. Otherwise, form shows error messages on the fields that are invalid.

Login as existing user:
- Visit application.
- Enter email and password for exisiting user.
- Click "login" button.
- If user exists, redirect to home page, where alert "Logged in as *insert email here.*" is flashed and search functionality is shown. Otherwise, flash alert "Email/password not found".

Deleting existing users:
- Login as an admin user.
- Click on "Users" on navigation bar.
- Click "delete" on users to be deleted and confirm deletion.
- Flash alert "User deleted successfully" and remove user from User listing.

Adding new buildings, services, areas, tags:
- Login as admin user.
- Navigate to appropriate object page.
- Click "New *insert object here*".
- Enter in the appropriate inputs for the object and submit.
- If input fields are valid, add new object to appropriate table and redirect to object show page. Otherwise, form shows error messages on the fields that are invalid.

Search by building name, service name, area name, tag name, buidling address, or favorite name:
- Login as an exisiting user.
- Enter query into search box and submit.
- If query is successful, show list of related searches with links to appropriate object show page and labels with object type. Otherwise, no results found is displayed where the count normally is.

Marking buildings and services as favorites:
- Login as an exisiting user.
- Visit any building or serivce show page (either through searching or from full listing).
- Click "Add to favorites" button.
- Button now shows "Remove from favorites" and building/service is viewable from favorites listing.

Custon names for favorites:
- Login as an exisiting user with favorites.
- Click "Favorites" on navigation bar to view full listing of favorites.
- Click pencil icon to edit name of favorite.
- Enter desired custom name for favorite and click submit.
- Page redirects to favorites listing and shows updated name. This name can now be queried in the search functionality.

Removing favorites:
- Login as an existing user with favorites.
- Either view the favorite's show page or the favorites listing.
- Click "Remove from favorites" or the "x" button on the show page or listing respectively.
- Button is now "Add to favorites" or no longer listed on the show page or listing respectively.
