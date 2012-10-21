Album app to store multiple photos in each album.
======

This application provides the user to register and sign in using authlogic, facebook, twitter and gmail. An Email will be sent to user account after successfull registration. 

After login user can create an album and add multiple photos to the album. People can also be tagged with each photo.The photos will be saved to dropbox.

The home page will show the list of all albums.

When some user creates an album and if he is logged in with facebook. Then a post will be published on User's wall to show his activity.

Steps to run the application after download.

```
$bundle install   # To install gems
```
```
$rake db:create db:migrate   # To design database
```
```
$ rake dropbox:authorize APP_KEY=your_app_key APP_SECRET=your_app_secret
```
```
$rails server     # To start Rails Server
```
This application is also available on heroku. You can access the app with http://album-app.herokuapp.com.