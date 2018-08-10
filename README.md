# Ballerina Reminder App

This app will fetch the tasks set at Google Tasks and schedule the SMS notifications reminding that there is a task
scheduled.

## How to Start

1. First, you need to have a [Google](https://accounts.google.com/SignUp?hl=en-GB) account and a
[Twilio](https://www.twilio.com/try-twilio) account obtain credentials.

### How to obtain Google OAuth2.0 Credentials

1. Visit [Google API Console](https://console.developers.google.com), click **Create Project**, and follow the wizard
to create a new project.
2. Go to **Credentials -> OAuth consent screen**, enter a product name to be shown to users, and click **Save**.
3. On the **Credentials** tab, click **Create credentials** and select **OAuth client ID**.
4. Select an application type, enter a name for the application, and specify a redirect URI
(enter https://developers.google.com/oauthplayground if you want to use
[OAuth 2.0 playground](https://developers.google.com/oauthplayground)
to receive the authorization code and obtain the access token and refresh token).
5. Click **Create**. Your client ID and client secret appear.
6. In a separate browser window or tab, visit [OAuth 2.0 playground](https://developers.google.com/oauthplayground),
select the required GTask API scopes, and then click **Authorize APIs**.
7. When you receive your authorization code, click **Exchange authorization code for tokens** to obtain the refresh token
and access token.

### How to obtain Twilio Credentials
