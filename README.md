# Best Available Seat

# Problem
Write a solution to return the best seat (closest to the front & middle) given a list of open seats. Rows follow alphabetical order with "a" being the first row. Columns follow numerical order from left to right.

The list of open seats, number of rows and columns (seats) is based on a JSON input.

```json
{
    "venue": {
        "layout": {
            "rows": 10,
            "columns": 50
        }
    },
    "seats": {
        "a1": {
            "id": "a1",
            "row": "a",
            "column": 1,
            "status": "AVAILABLE"
        },
        "b5": {
            "id": "b5",
            "row": "b",
            "column": 5,
            "status": "AVAILABLE"
        },
        "h7": {
            "id": "h7",
            "row": "h",
            "column": 7,
            "status": "AVAILABLE"
        }
    }
}
```

The solution should find the best open seat (closest to the front & middle) given the input JSON and number of requested seats. Imagine a concert, people want to be as close as possible to the stage.

For example, for a venue with 10 rows and 12 columns with all seats open, the best seat would be A6.

If a group of seats is requested, the algorithm needs to find the best open group of seats together. In the example above, for 3 seats, it would be A5, A6, and A7.

For 5 columns and 2 requested seats the best open seats - assuming the first row A is fully occupied and the second row B is fully open, would be B2 and B3.


# Solution

To solve this problem, I created this Rails API and a React client to visualize it. The API follows the JSON API standard for its responses.


## Installing the project
```
$ bundle install
```

## Setting up the DB (You need to have installed Postgres). This command also will populate with a test Venue.
```
$ bundle exec rake db:setup
```

## Running the API

We should run it in the port 3001, if we want to visualize it in the React app.

```
$ rails s -p 3001
``` 

## Running tests
```
$ bundle exec rspec
```

## API Endpoints


### GET /venues
> It returns a list of venues.

#### REQUIRED PARAMETERS

#### OPTIONAL PARAMETERS

#### REQUEST EXAMPLE (Without params)
``` /api/v1/venues```

#### RESPONSE EXAMPLE
```
{
    "data": [
        {
            "id": "1",
            "type": "venue",
            "attributes": {
                "rows": 2,
                "columns": 5,
                "available_seats": [
                    "a1",
                    "a2",
                    "a3",
                    "a4",
                    "a5",
                    "b1",
                    "b2",
                    "b3",
                    "b4",
                    "b5"
                ]
            }
        },
        ...
    ]
}
```

### GET /venues/:id
> It retrieves information about an specific Venue.

#### REQUEST EXAMPLE
``` GET api/v1/venues/1```

#### REQUIRED PARAMETERS
|Name|Value|Description|
|-------|-------|-------|
|id|Integer| Venue ID.|

#### RESPONSE EXAMPLE
```json
{
    "data": {
        "id": "1",
        "type": "venue",
        "attributes": {
            "rows": 2,
            "columns": 5,
            "available_seats": [
                "a1",
                "a2",
                "a3",
                "a4",
                "a5",
                "b1",
                "b2",
                "b3",
                "b4",
                "b5"
            ]
        }
    }
}
```

### POST /venues
> It creates a new Venue.

#### REQUEST EXAMPLE
``` POST /api/v1/venues```

### BODY EXAMPLE
```json
{ "venue" : {"rows": 2, "columns": 5} }
```

#### RESPONSE EXAMPLE
```json
{
    "data": {
        "id": "2",
        "type": "venue",
        "attributes": {
            "rows": 2,
            "columns": 5,
            "available_seats": [
                "a1",
                "a2",
                "a3",
                "a4",
                "a5",
                "b1",
                "b2",
                "b3",
                "b4",
                "b5"
            ]
        }
    }
}
```

### POST /venues/import
> It creates a new venue from a JSON settings file. The file also indicates the availability of seats.

#### REQUEST EXAMPLE
``` POST /api/v1/venues/import```

### BODY EXAMPLE
```json
{
    "venue": {
        "layout": {
            "rows": 10,
            "columns": 50
        }
    },
    "seats": {
        "a1": {
            "id": "a1",
            "row": "a",
            "column": 1,
            "status": "AVAILABLE"
        },
        "b5": {
            "id": "b5",
            "row": "b",
            "column": 5,
            "status": "AVAILABLE"
        },
        "h7": {
            "id": "h7",
            "row": "h",
            "column": 7,
            "status": "AVAILABLE"
        }
    }
}
```

#### RESPONSE EXAMPLE
```json
{
    "data": {
        "id": "3",
        "type": "venue",
        "attributes": {
            "rows": 10,
            "columns": 50,
            "available_seats": [
                "a1",
                "a2",
                "a3",
                
            ]
        }
    }
}
```


### POST /venues/:id/select_seat
> It selects a seat in a Venue. Making it unavailable.

#### REQUEST EXAMPLE
``` POST /api/v1/venues/1/select_seat```

### BODY EXAMPLE
```json
{ "row": "a", "column": 2 }
```

#### RESPONSE EXAMPLE
```json
{
    "data": {
        "id": "6",
        "type": "seat",
        "attributes": {
            "id": "b1",
            "row": 1,
            "row_char": "a",
            "column": 2,
            "status": "NOT AVAILABLE"
        }
    }
}
```


### GET /venues/:id/best_seat
> It selects a seat in a Venue. Making it unavailable.

#### REQUEST EXAMPLE
``` GET /api/v1/venues/1/best_seat```

### BODY EXAMPLE

#### RESPONSE EXAMPLE
```json
{
    "data": {
        "id": "6",
        "type": "seat",
        "attributes": {
            "id": "b1",
            "row": 1,
            "row_char": "a",
            "column": 2,
            "status": "AVAILABLE"
        }
    }
}
```

