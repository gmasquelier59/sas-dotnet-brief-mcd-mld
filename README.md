# Brief "Création BDD PostgreSQL pour la plateforme e-commerce "AuBonDeal"

Brief réalisé dans le cadre de la formation "Développeur .Net" avec Simplon & M2I en novembre 2023.

<img src="./resources/banner.png">

_Image générée par une IA_

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

📄[Le dump PostgreSQL](./dump.sql)

### Sources

📄[Schéma](./sources/schema.sql)

📄[Données de test](./tests/data.sql)

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

* Le rôle ``store_manager`` gère l'ensemble de la base de données, il peut être considéré comme un "_super role_"
* Le rôle ``store_manager_users`` gère uniquement les données relatives aux utilisateurs
* Le rôle ``store_manager_products`` gère uniquement les données relatives aux produits
* Le rôle ``store_manager_orders`` gère uniquement les données relatives aux commandes

#### Tableau de correspondance rôle / privilège

| Privilège | Rôle ``store_manager`` | Rôle ``store_manager_users`` | Rôle ``store_manager_products`` | Rôle ``store_manager_orders`` |
|---|:---:|:---:|:---:|:---:|
| ``LOGIN`` | ✅ | ✅ | ✅ | ✅ |
| ``CREATE TABLE`` | ✅ | ❌ | ❌ | ❌ |
| ``ALTER TABLE`` | ✅ | ❌ | ❌ | ❌ |
| ``DROP TABLE`` | ✅ | ❌ | ❌ | ❌ |
| ``SELECT`` | ✅<br>(sur toutes les tables) | ✅<br>(sur toutes les tables) | ✅<br>(sur toutes les tables) | ✅<br>(sur toutes les tables) |
| ``INSERT``, ``UPDATE``, ``DELETE`` | ✅<br>(sur toutes les tables) | ✅<br>(uniquement sur la table users) | ✅<br>(uniquement sur la table products) | ✅<br>(uniquement sur les tables orders et products_orders)

#### Création des rôles

> [!NOTE]
> Il n'est pas nécessaire de créer les rôles manuellement si [le dump PostgreSQL](./dump.sql) a été importé en totalité.

> [!WARNING]
> Ces requêtes ne peuvent être exécutées que par un rôle disposant du privilège ``CREATEROLE``.

Les requêtes SQL permettant de créer les rôles et définir les permissions sont disponibles dans le fichier 📄[roles.sql](./sources/roles.sql).

### Qu'est-ce que la méthode MERISE ?

> MERISE = Méthode d'Etude et de Réalisation Informatique pour les Systèmes d'Entreprise

Méthode de conception des systèmes d'information créée dans les années 1970 par une équipe de chercheurs (Jean-Louis le Moigne, Hubert Tardieu, Dominique Nancy, Henry Heckenroth, Daniel Pasco, Bernard Espinasse), encore très utilisée aujourd'hui pour la conception des bases de données.

La méthode MERISE propose de considérer quatre niveaux :

#### le niveau conceptuel
Il consiste à concevoir le système d'information indépendamment des choix techniques d'implémentation. Il se concrétise par le Modèle Conceptuel de Données (MCD) et par le Modèle Conceptuel des Traitements (MCT).

#### le niveau organisationnel
Il s'agit ici de définir comment sera organisé le système d'information (définition des postes de travail, accès à la base de données,...). Il se concrétise par le Modèle Organisationne des données (MOD) et le Modèle organisationnel des Traitements (MOT).

#### le niveau logique
Il constitue une étape vers le modèle physique mais il est indépendant du matériel, des langages de programmation et des SGBD. Il permet de préciser comment les données seront stockées. Il se concrétise par le Modèle Logique de données (MLD) et le Modèle logique des Traitements (MLT).

#### le niveau physique
Il permet de définir comment les données seront réellement stockées. C'est à ce niveau qu'on détermine le SGBD utilisé. Il se concrétise par le Modèle physique des Données (MPD) et le Modèle Opérationnel et Physique des Traitements (MOpT).

_Source : https://ma-petite-encyclopedie.org/accueil?lex_item=m%C3%A9thode%20MERISE_