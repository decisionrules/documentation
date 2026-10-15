# Emergency 2FA Reset

## Resetting Two-Factor Authentication

If you lose access to your authenticator app and no other Environment Manager can reset your two-factor authentication, a database administrator can update your account directly in the database.

Locate the affected user's document in the **`Users`** collection and apply the following changes:

1. Remove the **`totpSecretId`** field.
2. Remove the **`totpLastAcceptedTimeStep`** field.
3. Increment **`securityRevision`** by **1** to invalidate sessions issued under the previous revision.

Apply these changes to the affected user only. Do not delete the user document.
