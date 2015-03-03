# Welcome to Fanalyst App

Fanalyst is ....

# Setup

## Pre-Requisites

 * Ruby 2.2
 * Ruby On Rails 4.2
 * PostGres

## Config

### heroku

Some config variables are required.

Amazon s3 for file upload:

```
$ heroku config:add AWS_HOST_NAME=<host_name> --app <app_name>
$ heroku config:add AWS_BUCKET=<bucket> --app <app_name>
$ heroku config:add AWS_ACCESS_KEY_ID=<access_key_id> --app <app_name>
$ heroku config:add AWS_SECRET_ACCESS_KEY=<secret_access_key> --app <app_name>
```

Hostname for mail url:

```
$ heroku config:add ACTION_MAILER_URL=<action_mailer.default_url_options>  --app <app_name>
```

Required add-ons:

* Sentry
