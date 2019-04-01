# Celebrity Spotting with WhatsApp and AWS Rekognition

This application brings together the [Twilio API for WhatsApp](https://www.twilio.com/docs/sms/whatsapp/api) and [AWS Rekognition](https://aws.amazon.com/rekognition/) to build a service where you can send photos to a WhatsApp number and reply with which celebrities are in the photo.

## What you'll need

To run this application you'll need a few things:

* A Twilio account, [sign up for a free one here](https://www.twilio.com/try-twilio)
* [An AWS account](https://aws.amazon.com/)
* [Ruby](https://www.ruby-lang.org/en/downloads/) and [Bundler](https://bundler.io/) installed
* [ngrok](https://ngrok.com/) to help us [test our webhooks](https://www.twilio.com/blog/2015/09/6-awesome-reasons-to-use-ngrok-when-testing-webhooks.html)

## Running the application

Clone or download the repo and change into the directory on the command line:

```bash
git clone https://github.com/philnash/celebrity-spotting.git
cd celebrity-spotting
```

Install the dependencies with Bundler:

```bash
bundle install
```

### Config

Copy the example config from `config/env.yml.example`

```bash
cp config/env.yml.example config/env.yml
```

Fill in your Twilio and AWS credentials in `config/env.yml`. You'll need an AWS user that has access to the Rekognition APIs (for example, with the `AmazonRekognitionFullAccess` policy). For more detail, check out the [documentation on authentication and access control for Rekognition](https://docs.aws.amazon.com/rekognition/latest/dg/authentication-and-access-control.html).

### Start the application

You can start the app with the following command:

```bash
bundle exec rackup
```

The application will start on localhost:9292.

### Webhooks

When you send a message to the Twilio API for WhatsApp, Twilio will send the details of the message to your application as a webhook. Webhooks are HTTP requests, so you need to be able to receive an incoming HTTP request to your application. You can use [ngrok](https://ngrok.com) as a tool to give you a public URL that tunnels through to your local development environment.

To do so, start ngrok pointing to the port your application is running on:

```bash
ngrok http 9292
```

ngrok will display a URL like `https://RANDOM_STRING.ngrok.io` and you will use that to receive the incoming webhooks from Twilio.

### Set up WhatsApp

Now you have your URL, you need to set up WhatsApp. Open the [WhatsApp Sandbox admin in your Twilio console](http://twilio.com/console/sms/whatsapp). Go through the process to connect to your sandbox number. Add a `/messages` path to your ngrok URL, it should look like:

```
https://RANDOM_STRING.ngrok.io/messages
```

In the sandbox configuration, enter your ngrok URL in the field for "When a message comes in".

Now you're all set up.

## Send a message

Send a picture to the WhatsApp sandbox number and you will get a message back telling you if there are any celebrities in the picture.

