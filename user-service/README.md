[< Back to Assignment](../README.md)

## Users (Ruby on Rails)
This service stores information about a user.

### Users Endpoint

**Host Endpoint:** `http://localhost:8000/users/<id>`

**Docker Network Endpoint:** `http://user-service:8000/users/<id>`

**Method:** GET

**Description:** Retrieve a specific user record, also used as a proxy for authorization if a user record can't be found.

### Example Responses

**Success**
```json
{
    "id": <int>,
    "first_name": <string>,
    "last_name": <string>,
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

**Host Endpoint:** `http://localhost:8000/users/`

**Docker Network Endpoint:** `http://user-service:8000/users/`

**Method:** GET

**Description:** ADMIN ONLY Retrieve an array of user details records including names and job titles.

### Example Responses

**Success**
```json
{ "users":
        [
          { "id":1,
            "first_name": <string>,
            "last_name": <string>,
            "position": <string>}
          },
        ]
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
