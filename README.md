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

Il est possible de consulter tous les produits disponibles dans la boutique.

Lorsqu'un visiteur souhaite effectuer une commande, il doit :
* soit se créer un compte utilisateur
* soit s'identifier avec un compte utilisateur existant

Un compte utilisateur est obligatoire pour passer une commande et consulter ses commandes, il n'est pas obligatoire pour consulter la liste des produits disponibles.

Une commande confirmée comporte au minimum 1 produit et a un montant total supérieur à 0.

* Concernant les comptes utilisateurs :
    * Un compte utilisateur nécessite un nom d'utilisateur (username) et un mot de passe (password) de longueur minimale de 10 caractères et d'un maximum 20 caractères, comportant au minimum une lettre minuscule, une lettre majuscule, un chiffre et un caractère spécial.
    * Le compte utilisateur doit comporter un pseudo, il ne peut être ni nul, ni vide.
    * Le nom d'utilisateur ne peut être ni nul, ni vide. Il est unique parmi tous les utilisateurs.
    * Le mot de passe ne peut être ni nul, ni vide. Il doit être obligatoirement hashé avec bcrypt.
    * La suppression d'un utilisateur n'entraine pas la suppression de ses commandes.

* Concernant les produits :
    * Le nom du produit ne peut être ni nul, ni vide.
    * Le prix ne peut pas être nul et doit être supérieur ou égal à 0.
    * La quantité en stock ne peut pas être nulle et doit être supérieure ou égale à 0.
    * La suppression d'un produit n'entraine pas la suppression des commandes dans lequel figure le produit.
    * Un produit peut figurer dans plusieurs commandes.

* Concernant les commandes :
    * Chaque commande est associée à un et un seul compte utilisateur existant.
    * Un utilisateur peut ou non être associé à une commande. Un utilisateur peut passer plusieurs commandes.
    * Le montant total de la commande ne peut être nul et doit être supérieur à 0.
    * La quantité totale commandée ne peut être nulle et doit être supérieure à 0.
    * La suppression d'une commande ne supprime pas le compte utilisateur associé.

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