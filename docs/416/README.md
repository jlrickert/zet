# AWS Cognito

## Domain model

```ts
type UserPool = {
  // A unique identifier
  id: string;
  // Name of the user pool
  name: string;

  // List of client applications
  clients: ClientApplication[];

  // List of users registered to the pool
  user: User[];

  // Security policy settings for the user pool
  policies: Policy[];
};

type ClientApplication = {
  // A unique identifier
  id: string;

  // Name of the client application
  name: string;

  // A secret key used to authenticat the client application
  secret: string;

  // Scopes defining the acdcess levels of the client application
  allowedOAuthScopes: string[];
};

type User = {
  id: string;
  name: string;
  // A unique identifier for a user within a user pool.
  id: string;
  // The username assigned to the user.
  username: string;

  // The email address associated with the user.
  email: string;
  // The password set by the user.
  password: string;

  // Access and refresh tokens issued to the user for authentication and authorization.
  tokens: any;

  // Additional attributes associated with the user (e.g., phone number, address).
  attributes: { [key: string]: string };
};
```

## See also

- [AWS Services](../391)

## Meta

    tags: #aws