# openid_connect_example

## Rename application's name

```
git grep -l 'module OpenidConnectExample'|xargs sed -i '' 's/OpenidConnectExample/Youropenid_connect_example/g'
git grep -l 'openid_connect_example'|xargs sed -i '' 's/openid_connect_example/youropenid_connect_example/g'
```

## Setup for development

rename Guardfile.example to Guardfile

```
$ cp Guardfile.example Guardfile
```

## External API Credential

```
cp config/application.yml.example config/application.yml
```

Fill in api credential

```
rake secret
```

Fill in SECRET_TOKEN by the key above result.

```
rake secret
```

Change devise's secret_token(config/initializers/devise.rb) by the key above result.

## Start guard

```
$ guard
```

## heroku

```
heroku create openid_connect_example
git remote rename heroku openid_connect_example
git push openid_connect_example master
heroku addons:add newrelic
heroku addons:add pgbackups:auto-month
heroku addons:add mandrill:starter
rake figaro:heroku\[openid_connect_example\]
```

### staging

```
heroku create openid_connect_example-stg
git remote set-url openid_connect_example-stg git@heroku.com:openid_connect_example-stg.git
git push openid_connect_example master
heroku addons:add newrelic
heroku addons:add pgbackups:auto-month
heroku addons:add mandrill:starter
heroku addons:add mailtrap
heroku config:set RACK_ENV=staging RAILS_ENV=staging
rake figaro:heroku\[openid_connect_example-stg\]
```

## s3

create 'openid_connect_example' bucket on 'us-east-1'

### IAM

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetBucket*"
      ],
      "Resource": [
        "arn:aws:s3:::openid_connect_example"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "s3:DeleteObject*",
        "s3:GetObject*",
        "s3:PutObject*"
      ],
      "Resource": [
        "arn:aws:s3:::openid_connect_example/*"
      ],
      "Effect": "Allow"
    }
  ]
}
```

Fill config/application.yml

```
AWS_ACCESS_KEY_ID: ''
AWS_SECRET_ACCESS_KEY: ''
AWS_REGION: 'us-east-1'
AWS_S3_BUCKET: 'openid_connect_example'
```
