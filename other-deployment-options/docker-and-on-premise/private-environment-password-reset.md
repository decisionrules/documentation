---
description: >-
  This page describes how to reset a password on a private environment in case
  you cannot access the Password Recovery Email.
---

# Private Environment Password Reset

In the rare occasion when a user in a private environment needs to reset their password and cannot access their mailbox (or the email cannot be delivered), it is possible to use these steps to reset the password without access to the email.

You will need:

* The email address of the account whose password you want to reset
* Read access to the database

## Password Reset Steps

### Find User in DB

Go to Users collection and look up the account by the email, e.g. `{email:"john.doe@abcd.com"}`. Then copy the document Object ID, e.g. `690odfeea7d8e4290ef70fdf`. This is the user ID of the account.

### Send a Password Recovery Request

The second step is exactly the same as in the regular scenario. Go to the app Login page and click the FORGOTTEN PASSWORD link. It will take you to the Password Recovery page. Here, enter the email address of the respective account and send it.

### Read Password Recovery Token from DB

Go to the PasswordResets collection in the DB and look up the corresponding password reset request by searching for the above-obtained user ID, e.g. `{userId:ObjectId('690odfeea7d8e4290ef70fdf')}`. You should find one or more documents. If there are many, consider only the one with the greatest `expiresIn` attribute. Identify the document and copy its `_id`. This is your password recovery token.

### Reset the Password

Finally, you need to assemble a link that will allow you to set a new password. It should look like this:

`https://decisionrules.yourdomain.com/auth/reset?token=_id`

Let's break it down:

`https://decisionrules.yourdomain.com` — The URL of your DecisionRules client application

`_id` — The password recovery token from the previous step

Once you assemble the URL, open it in the browser. It should take you to the Password Reset page, where you can set the password.

