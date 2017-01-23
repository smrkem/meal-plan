# Meal Plan
Project for tutorial on docker rails development found at:  
- https://www.youtube.com/watch?v=JdBWb7jWALg

#### Setup  
To get the app and running:  
```
$ docker-compose up -d
```

To install the app db schema (necessary first time):
```
$ docker-compose run --rm app rake db:create db:migrate
```
