# Furui
Furui is a Rails application where user can label images by hand with arbitrarily configured categories.

# Installation
```
git clone github.com/ayemos/furui
cd furui
```

# How to use

## Setup Database
```
bundle exec rake db:create
bundle exec rake db:migrate
```

## Place images to classify
First you have to place the images you need to give labels.

### Images from local file system
```
bundle exec rake 'images:create_records_for_local_images[NAME_OF_DATASET, PATH_TO_IMAGE_DIR]'
```

### Images from Amazon S3
WIP

## Run server
```
bundle exec rails s
```

## Classify
Open `localhost:3000` on your browser and classify images.

## Retrieve results
```
bundle exec rake 'images:export[NAME_OF_DATASET, OUTPUT_FORMAT]'
```

