[< Back to Assignment](../README.md)

## Users (Ruby on Rails)
This service returns summary metric information about a user.

### Users Endpoint

**Host Endpoint:** `http://localhost:8000/summary/<id>`

**Docker Network Endpoint:** `http://dashboard-api:8000/summary/<id>`

**Method:** GET

**Description:** Retrieve a users summary of key metrics.

### Example Responses

**Success NON ADMIN**
```json
{
  "summary": {
    "user": {
      "full_name": <string>
    },
    "subscription": {
      "price_cents": <int>,
      "days_to_renew": <int>
    },
    "events": {
      "meeting_count": <int>,
      "next_meeting": {
        "id": <int>,
        "name": <int>,
        "duration": <int>,
        "date": <string>,
        "attendees": <int>
      }
    }
  }
}
```
**Success ADMIN**
```json
{
  "summary": {
    "user": {
      "full_name": <string>
    },
    "subscription": {
      "price_cents": <int>,
      "days_to_renew": <int>
    },
    "events": {
      "meeting_count": <int>,
      "next_meeting": {
        "id": <int>,
        "name": <int>,
        "duration": <int>,
        "date": <string>,
        "attendees": <int>
      }
    },
    "users_summary": [
      {
        "first_name": <string>,
        "last_name": <string>,
        "position": <string>
      }
    ]
  }
}
```
**Error**
```json
{
    "message": <error message>
}
```

### Response Codes

| Status Code | Description      |
| ----------- | ---------------- |
| 200         | OK               |
| 404         | Record not Found |
