# Ballerina Reminder App

This app will fetch the Google Tasks set by you and schedule the SMS notifications reminding that there is a task
scheduled. This project is based on ballerina [GTasks connector[(https://central.ballerina.io/chanakal/gtasks) and
[Twilio connector](https://central.ballerina.io/wso2/twilio).

## How to Configure

1. First, you need to have a [Google](https://accounts.google.com/SignUp?hl=en-GB) account and a
[Twilio](https://www.twilio.com/try-twilio) account obtain credentials.

---

### How to obtain Google OAuth2.0 Credentials

1. Visit [Google API Console](https://console.developers.google.com), click **Create Project**, and follow the wizard
to create a new project.
2. Go to **Dashboard**, click on **ENABLE APIS AND SERVICES** and select the **Google Task** API and click **ENABLE**.
3. Go to **Credentials → OAuth consent screen**, enter a product name to be shown to users, and click **Save**.
4. On the **Credentials** tab, click **Create credentials** and select **OAuth _Client ID_**.
5. Select an application type, enter a name for the application, and specify a redirect URI.
- NOTE: Enter https://developers.google.com/oauthplayground if you want to use
[OAuth 2.0 playground](https://developers.google.com/oauthplayground)
to receive the _Authorization Code_ and obtain the access token and _Refresh Token_.
6. Click **Create**. Your _Client ID_ and _Client Secret_ appear.
7. In a separate browser window or tab, visit [OAuth 2.0 playground](https://developers.google.com/oauthplayground).
8. Click the ⚙️ icon (Settings) at the top right corner and tick **Use your own OAuth credentials**.
9. Paste the obtained _Client ID_ and _Client Secret_ there.
10. At the left side of the window, select the required Google Task API scopes, and then click **Authorize APIs**.
11. When you receive your _Authorization Code_, click **Exchange _Authorization Code_ for tokens** to obtain the _Refresh Token_
and access token.

### How to obtain Twilio Credentials

1. Login to the Twilio account created.
2. Go to **Products** tab --> **Programmable SMS** and select **Continue**.
3. Give a name for the project and click *Continue**. Skip the **Custom Project** step.
4. In the **Dashboard**, you can see the **Project Info** tab with **ACCOUNT SID**. Click on the tab and obtain the
**ACCOUNT SID** and **AUTH TOKEN**.

- Now you have obtained all the credentials you want.

---

2. Go to **Programmable SMS** at Twilio account and get a Twilio phone number in order to send SMS.
3. Create a `ballerina.conf` file at the same level of `app` directory and update the credentials and the phone numbers
as follows. Make sure to add the the phone numbers with country code.
```config
ACCESS_TOKEN=""
CLIENT_ID=""
CLIENT_SECRET=""
REFRESH_TOKEN=""

ACCOUNT_SID=""
AUTH_TOKEN=""
FROM_MOBILE=""
TO_MOBILE=""
```

- Now you are done with configurations.

## How to Start

1. Create a task at the Google Tasks in following format.
```
Notify Me /1
```

2. Run the app executing following command from the project level.
```bash
$ ballerina run app -c ballerina.conf
```
You can see the output something similar to following and the SMS will be sent received in 1 minute.
```bash
2018-08-11 09:59:18,133 INFO  [app:0.0.0] - Picked: Notify Me /1
2018-08-11 09:59:18,139 INFO  [app:0.0.0] - Scheduling appointment
2018-08-11 09:59:19,048 INFO  [app:0.0.0] - Scheduled appointment and mark the task as scheduled
2018-08-11 10:00:01,021 INFO  [app:0.0.0] - Triggered the task
2018-08-11 10:00:01,024 INFO  [app:0.0.0] - SMS Sending FROM: +1234567890 TO: +94771234567
2018-08-11 10:00:02,607 INFO  [app:0.0.0] - SMS ID: SMf836b45741gy46fd8b68ca62c4c840a1 STATUS: queued
2018-08-11 10:00:02,608 INFO  [app:0.0.0] - Cancelling the appointment
```

You are done !
