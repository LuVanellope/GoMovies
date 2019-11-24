# Movies api

This is a very small example of an API built using the following tools and considerations:
  - Docker
  - RoR 6
  - Test driven development using RSpec

# Dependencies

  This project was built using the following versions:
    - Docker version 18.09.6
    - docker-compose version 1.23.2

# Configuration

  As initial step run the following command to setup the database:

  `sudo docker-compose run web rails db:create db:migrate`

# Tests

  To run the tests run `sudo docker-compose run web bundle exec rspec spec/`

# Run API

  To start the API server run `sudo docker-compose up`

# API Documentation

* POST /movies

  Params
  
  <table>
  <tr>
    <th>Param name</th>
    <th>Required</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>name</td>
    <td>true</td>
    <td>String</td>
    <td>Name of the movie</td>
  </tr>
  <tr>
    <td>description</td>
    <td>true</td>
    <td>String</td>
    <td>Short preview text about the movie</td>
  </tr>
  <tr>
    <td>url_image</td>
    <td>true</td>
    <td>String</td>
    <td>an URL link to the image movie preview</td>
  </tr>
  <tr>
    <td>begin_date</td>
    <td>true</td>
    <td>Date</td>
    <td>The date of the first show day</td>
  </tr>
  <tr>
    <td>end_date</td>
    <td>true</td>
    <td>Date</td>
    <td>The date of the last show day</td>
  </tr>
</table>

 Example:
  
  ```
    curl -XPOST "http://localhost:3000/movies" -H 'Content-Type: application/json' -d '
      {
        "name": "Maleficent: Mistress of Evil",
        "description": "Maleficent travels to a grand old castle to celebrate young Auroras upcoming wedding to Prince Phillip.",
        "url_image": "https://myimages.com/maleficent",
        "begin_date": "2019-11-10",
      "end_date": "2019-11-30"
      }
    '
  ```

  Response:
  ```
    {
      "id":2,
      "name":"Maleficent: Mistress of Evil",
      "description":"Maleficent travels to a grand old castle to celebrate young Auroras upcoming wedding to Prince Phillip.",
      "url_image":"https://myimages.com/maleficent",
      "begin_date":"2019-11-10T00:00:00.000Z",
      "end_date":"2019-11-30T00:00:00.000Z",
      "created_at":"2019-11-24T17:17:15.663Z",
      "updated_at":"2019-11-24T17:17:15.663Z"
    }
  ```

  * POST /reservations

  Params
  
  <table>
  <tr>
    <th>Param name</th>
    <th>Required</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>reservation_date</td>
    <td>true</td>
    <td>Date</td>
    <td>The day of the reservation</td>
  </tr>
  <tr>
    <td>movie_id</td>
    <td>true</td>
    <td>Integer</td>
    <td>The id of the movie for the reservation</td>
  </tr>
  <tr>
    <td>document</td>
    <td>true</td>
    <td>String</td>
    <td>The id of the person who makes the reservation</td>
  </tr>
  <tr>
    <td>email</td>
    <td>true</td>
    <td>String</td>
    <td>The email of the person who makes the reservation</td>
  </tr>
  <tr>
    <td>name</td>
    <td>true</td>
    <td>String</td>
    <td>The name of the person who makes the reservation</td>
  </tr>
  <tr>
    <td>cell_phone</td>
    <td>false</td>
    <td>String</td>
    <td>The phone number of the person who makes the reservation</td>
  </tr>
</table>

  Example:

  ```
    curl -XPOST "http://localhost:3000/reservations" -H 'Content-type: application/json' -d '
      {
        "reservation_date": "2019-10-15",
        "name": "Juanito",
        "document": "12345",
        "email": "juanito@email.com",
        "movie_id": 2
      }
    '
  ```

  Response:
  ```
    {
      "id":1,
      "document":"12345",
      "email":"juanito@email.com",
      "name":"Juanito",
      "cell_phone":"",
      "reservation_date":"2019-10-15",
      "movie_id":2,
      "created_at":"2019-11-24T17:25:19.092Z",
      "updated_at":"2019-11-24T17:25:19.092Z"
    }
  ```

# TODO
  * Add pagination for GET endpoints
  * CI/CD
  * Restful
  * Serializer
