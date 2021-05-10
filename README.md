# Nested Resource Routing Lab

## Learning Goals

- Create nested routes
- Use params in nested routes

## Introduction

In this lab, we'll continue working on our Craigslist-style marketplace API, and
build out some nested routes to give users easier access to our data.

```txt
User -< Item
```

Get the lab set up by running:

```sh
bundle install
rails db:migrate db:seed
```

There is seed data in place so you can test your solution out in Postman. You
can also run `learn test` to run the tests.

## Instructions

Handle the following requests and return the appropriate JSON data in the
response.

### Show all items for a user

```txt
GET /users/:user_id/items
```

Example Response:

```json
[
  {
    "id": 1,
    "name": "Non-stick pan",
    "description": "Sticks a bit",
    "price": 10,
    "user_id": 1
  },
  {
    "id": 1,
    "name": "Ceramic plant pots",
    "description": "Plants not included",
    "price": 31,
    "user_id": 1
  }
]
```

### Show one item matching the ID

```txt
GET /users/:user_id/items/:id
```

Example Response:

```json
{
  "id": 1,
  "name": "Non-stick pan",
  "description": "Sticks a bit",
  "price": 10,
  "user_id": 1,
  "user": {
    "id": 1,
    "username": "Dwayne",
    "city": "Los Angeles"
  }
}
```

### Create a new item that belongs to a user

```txt
POST /users/:user_id/items
```

Example Request Body:

```json
{
  "name": "Garden gnomes",
  "description": "No refunds",
  "price": 23
}
```

Example Response:

```json
{
  "id": 2,
  "name": "Garden gnomes",
  "description": "No refunds",
  "price": 23,
  "user_id": 1
}
```

## Resources

- [Routing: Nested Resources](https://guides.rubyonrails.org/routing.html#nested-resources)
