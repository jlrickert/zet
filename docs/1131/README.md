# Automating Keycloak setup with Terraform

Automating identity and access management with `Keycloak` using `Terraform`
makes deployments repeatable, auditable, and easier to move between
environments. This note explains how to use the `Terraform` Keycloak provider to
provision realms, clients, roles, and users, and how to keep those
configurations in version control and CI pipelines. See [`Terraform`](../1134)
and [`Keycloak`](../1133) for background and provider details.
