# SETUP

## Install dependencies
```ruby 3.2.0```  
```gem install bundler:2.4.19```  
```bundle install```


## Setup database
```cp .env.example .env```
Add DB_USERNAME and DB_PASSWORD to .env file
## Setup database
```rake db:create```
```rake db:migrate```
```rake db:seed```


# RUN
```rails s```


# API

## GET /api/templates

```
  {
    "slogan": "slogan",
    "company_name": "company_name",
    "industry_id": 1,
    "icon_ids": [],
    "per_page": 100,
    "page": 1
  }
```

