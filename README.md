# Ballerina Reminder App

This app will fetch the tasks set at Google Tasks and schedule the SMS notifications reminding that there is a task
scheduled.

## How to Start

1. First, you need to have a [Google](https://accounts.google.com/SignUp?hl=en-GB) account and a
[Twilio](https://www.twilio.com/try-twilio) account obtain credentials.

### How to obtain Google OAuth2.0 Credentials

1. Visit [Google API Console](https://console.developers.google.com), click **Create Project**, and follow the wizard
to create a new project.
2. Go to **Dashboard**, click on **ENABLE APIS AND SERVICES** and select the **Google Task** API and click **ENABLE**.
3. Go to **Credentials --> OAuth consent screen**, enter a product name to be shown to users, and click **Save**.
4. On the **Credentials** tab, click **Create credentials** and select **OAuth client ID**.
5. Select an application type, enter a name for the application, and specify a redirect URI
(enter https://developers.google.com/oauthplayground if you want to use
[OAuth 2.0 playground](https://developers.google.com/oauthplayground)
to receive the authorization code and obtain the access token and refresh token).
6. Click **Create**. Your client ID and client secret appear.
7. In a separate browser window or tab, visit [OAuth 2.0 playground](https://developers.google.com/oauthplayground).
8. Click the **Setting** icon at the top right corner and tick **Use your own OAuth credentials**.
9. Paste the obtained client id and client secret there.
10. Select the required GTask API scopes, and then click **Authorize APIs** at the left side of the window.
11. When you receive your authorization code, click **Exchange authorization code for tokens** to obtain the refresh token
and access token.

### How to obtain Twilio Credentials

1. Login to the Twilio account created.
2. Go to **Products** tab --> **Programmable SMS** and select **Continue**.
3. Give a name for the project and click *Continue**. Skip the **Custom Project** step.
4. In the **Dashboard**, you can see the **Project Info** tab with **ACCOUNT SID**. Click on the tab and obtain the
**ACCOUNT SID** and **AUTH TOKEN**.

> Now you have obtained all the credentials you want.

2. Go to **Programmable SMS** at Twilio account and get a Twilio phone number in order to send SMS.
3. Create a `ballerina.conf` file at the same level of `app` directory and update the credentials and the phone numbers
as follows. Make sure to add the the phone numbers with country code.
```
ACCESS_TOKEN=""
CLIENT_ID=""
CLIENT_SECRET=""
REFRESH_TOKEN=""

ACCOUNT_SID=""
AUTH_TOKEN=""
FROM_MOBILE=""
TO_MOBILE=""
```

4. Now you are done with configurations.
