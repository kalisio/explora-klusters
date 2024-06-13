# chirpstack deployment on loradata kluster

This is the documentation of the loradata cluster. It's a cluster to display sensors values owned by Kalisio team.

## keycloak

The realm configured is `chirpstack`. 
A realm role `mongo_express` is configured to allow/disallow user to mongo express application.
Two client are defined `k-keycloack-chirpstack` and `oauth2-proxy`.

## troubleshooting

For chirpstack server you can use the kubernetes logs. For mongo use the mongoexpress url: https://mongo-express.loradata.kalisio.xyz/