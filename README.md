# Brief "Création BDD PostgreSQL pour la plateforme e-commerce "AuBonDeal"

Brief réalisé dans le cadre de la formation "Développeur .Net" avec Simplon & M2I en novembre 2023.

## Objectif

Création d'une base de données PostgreSQL à partir d'un diagramme Merise

## Contexte

Vous êtes sur le point de contribuer à la création de "AuBonDeal", une plateforme de commerce en ligne.

Votre mission Consiste à :

* Analyser le Modèle Conceptuel de Données (MCD) et le Modèle Logique de Données (MLD) qui vous sont fournis pour bien comprendre la structure de la base de données nécessaire.

* Traduire ces modèles en une base de données relationnelle fonctionnelle en utilisant le langage SQL. Cela inclut la définition des tables, des relations, des clés primaires et étrangères, ainsi que des contraintes d'intégrité.

* Assurer que la base de données est conçue pour gérer efficacement les opérations CRUD, avec une attention particulière portée à la sécurité et à la performance.

## Livrables

### MPD

[Le dump PostgreSQL](./dump.sql)

### Sources

[Schéma](./source_schema.sql)

[Données de test](./source_test_data.sql)

### Règles de gestion

* Concernant les utilisateurs :
    * Le pseudo ne peut ni être nul, ni vide
    * Le nom d'utilisateur ne peut ni être nul, ni vide. Il est unique dans la table
    * Le mot de passe ne peut ni être nul, ni vide. Il doit être obligatoirement hashé avec bcrypt.
    * La suppression d'un utilisateur n'entraine pas la suppression de ses commandes.

* Concernant les produits :
    * Le nom ne peut ni être nul, ni vide.
    * Le prix ne peut pas être nul et doit être supérieur ou égal à 0.
    * La quantité en stock ne peut pas être nulle et doit être supérieure à 0.
    * La suppression d'un produit n'entraine pas la suppression des commandes dans lequel figure le produit.

* Concernant les commandes :
    * Chaque commande est associée à un et un seul utilisateur existant.
    * Un utilisateur peut ou non être associé à une commande.
    * Le montant total de la commande ne peut être nul et doit être supérieur ou égal à 0.
    * La quantité totale commandée ne peut être nulle et doit être supérieure ou égal à 0.

### RBAC (Role-Based Access Control)

* Le rôle ``STORE_MANAGER`` gère l'ensemble de la base de données, il peut être considéré comme un "super role"
* Le rôle ``STORE_USERS`` gère uniquement les données relatives aux utilisateurs
* Le rôle ``STORE_PRODUCTS`` gère uniquement les données relatives aux produits
* Le rôle ``STORE_ORDERS`` gère uniquement les données relatives aux commandes

#### Tableau de correspondance rôle / privilège

| Privilège | Rôle STORE_MANAGER | Rôle STORE_USERS | Rôle STORE_PRODUCTS | Rôle STORE_ORDERS |
|---|:---:|:---:|:---:|:---:|
| LOGIN | X | X | X | X |
| CREATE TABLE | X |  |  |  |
| ALTER TABLE | X |  |  |  |
| DROP TABLE | X |  |  |  |
| SELECT | X<br>(sur toutes les tables) | X<br>(sur toutes les tables) | X<br>(sur toutes les tables) | X<br>(sur toutes les tables) |
| INSERT, UPDATE, DELETE | X<br>(sur toutes les tables) | X<br>(uniquement sur la table users) | X<br>(uniquement sur la table products) | X<br>(uniquement sur les tables orders et products_orders)

#### Création des rôles

Les requêtes SQL permettant de créer les rôles et définir les permissions sont disponibles dans le fichier [roles.sql](./roles.sql).

### Qu'est-ce que la méthode MERISE ?

<span style="color:red; font-weight: bold;">TODO</span>