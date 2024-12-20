
# Overview

Demo App that makes connecting to your utility account easy!


![dashboard](https://github.com/ryoung-sf/utilities_app/blob/ee092d0aba58c5e1a79151349db0dd573d2bd620/screenshots/dashboard.png)

## Getting Started!

1. Visit www.robyoungutility.com

![homepage](https://github.com/ryoung-sf/utilities_app/blob/ee092d0aba58c5e1a79151349db0dd573d2bd620/screenshots/homepage.png)

2. Next, you will need to create an account. Click the sign-up button and follow the steps to create and account (check your spam incase you don't see a confirmation email).

3. After you have confirmed your account log in with your email and password

4. Once logged in you will be directed to a form to enter the email address associated with the your utility provider and the Utility Company. Enter the below
* Email: <your_email@example.com>
* Utility: DEMO  -> Enter DEMO (all caps)

5. You will be directed to UtilityAPI.com to grant access to the demo. You should see a page that resembles the below.
* Do **NOT** enter your real utility credentials. Make sure the "Utility" drop down is set to demo and enter "test" as the username and password.
* Click through to authorize the demo account

![Authorization Flow](https://github.com/ryoung-sf/utilities_app/blob/ee092d0aba58c5e1a79151349db0dd573d2bd620/screenshots/utilityapi_authorization.png)

6. UtilityAPI will redirect you back to the app (login again if necessary). The application is the process of collecting your meter data. After a few minutes, the collection will be complete. A button will appear. Click it to view your meter dashboard

![Collection In Progress](https://github.com/ryoung-sf/utilities_app/blob/ee092d0aba58c5e1a79151349db0dd573d2bd620/screenshots/historical_collection_in_progress.png)

7. Once the meter collection is complete a button will to view the dashboard with the data will appear. Click on the button to see the below page

![Collection Complete](https://github.com/ryoung-sf/utilities_app/blob/ee092d0aba58c5e1a79151349db0dd573d2bd620/screenshots/historical_collection_complete.png)


## Download the project
* Download the application with git clone http://ryoung-sf/utitilies_app

## Local Setup

**Requirements**
* Ruby 3.3
* Rails 7.1
* Postrgres
* Hotwire
* Javascript
* Tailwindcss
* Goodjob
* Chartkickjs
* Redis --> required for actioncable
* [zrok.io](https://zrok.io/) --> required for webhooks and redirects in development (alternative to ngrok)
* UtilityApi account

**zrok.io**
* Set up an account on zrok
* Follow the guide to set up a public [reserved share](https://docs.zrok.io/docs/concepts/sharing-reserved/).
* Make sure the reserved share points to localhost:3000
* In your development.rb, file add this line with the provided reserved share `config.hosts << YOUR_RESERVED_SHARE.share.zrok.io`
* The reserved share will also be used for redirects and webhooks for UtilityAPI
* Why use a reserved share? Without a reserved share, everytime the zrok server is reset the development.rb and the webhooks and redirect endpoints will need to be updated.  

**UtilityAPI**
* Visit [UtilityAPI.com](https://utilityapi.com/) and setup an account. Its **FREE**!
* Locate the settings page and provide endpoints for redirects and webhooks. Follow the guide from zrok.io to enable webhooks and redirects to reach your local server
    * redirect endpoint: https://YOUR_ZROK_SHARE/authorizations/receive
    * webhooks endpoint: https://YOUR_ZROK_SHARE/webhooks/utility_api
* Grab your api token from the settings page and add it your secrets. This application user rails credentials
* Also grab your webhook secret. It's located on the settings page as well. This is necessary to confirm that the webhooks that are received and processed are from UtilityAPI and not a malicious actor.
* Store your tokens/secret via Rails Credentials below:
    * `utility_api_token: YOUR_UTILITY_API_TOKEN`
    * `utility_api_webhook_secret: YOUR_UTILITY_API_WEBHOOK_SECRET`

**Local email**
* The application uses [Letter Opener](https://github.com/ryanb/letter_opener) in development to receive mail. All emails sent in development should open in a new tab in the browser.

**Frontend**
* Views leverage server-side render HTML via ERB with Hotwire and snippets of Javascript (JS) for required updates where necessary
* JS packaged leveraged via importmaps:
    * chartkick
    * Chart.bundle
    * el-transition
    * @rails/actioncable

**Running the Application**
* `cd utilities_app`
* Run `bundle install`
* Run `bin/dev` and visit http://localhost:3000/ to see the app running
* Make sure the UtilityAPI is correctly pointing to your ZROK
* Open another terminal to run zrok
* In the second terminal run `zrok share reserved abcxyz` --> this will the broader internet an entry point to your local server
* Follow steps 2-6 in the Getting Started section above to create an account

**Running Tests**
* run the ruby test suite `bin/rails spec`
