
heroku restart
heroku restart
heroku run rails db:migrate
heroku run rails csv_load:all

git push heroku main
heroku open


rails import (or copy rake task file)
