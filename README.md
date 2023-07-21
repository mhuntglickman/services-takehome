# Engineering Take Home Exercise

Welcome to the Calendly Take Home assignment! This execise will focus on a Service Oriented Architecture (SOA) exercise.

You'll be asked to interact with a collection of docker containers that are able to communicate with each other. First, you'll create a dashboard API that aggregates information from each service. Second, you'll update one of the services to improve the functionality of the system as a whole. Finally, you'll incorporate the improved functionality back into the dashboard API. When you're done, you'll submit your work as a pull request, which will be submitted to the engineers that make up your technical interview panel. During the interview you'll be asked to describe your approach and discuss other changes or additions you could make to the system.

# Getting Started

Clone a copy of this repo locally and run the following command from the project root:
```sh
docker compose up --build
```

Access the "Summary Dashboard" by visiting this URL in a browser: 
 - [http://localhost:8000/summary/1](http://localhost:8000/summary/1)

# Services

[Billing Service](billing-service/README.md)

[Calendar Service](calendar-service/README.md)

[User Service](user-service/README.md)

[Dashboard API](dashboard-api/README.md)

# Assignment

You'll receive this repo as a fork in GitHub. As you work through the assignment we ask that you follow a similar process to how you normally interact with GitHub. At the bare minimum we expect three commits (one for each part) so that reviewers can see your progress. Feel free to include additional commits, comments, and unit tests to reflect how you would approach your day to day work.

## Part 1 - Create a Dashboard API Endpoint

Your task is to collect data from the three existing services and present it in a unified format for consumption by a Dashboard. The output of part 1 should be a JSON response which is visible when you access the [Summary Dashboard](http://localhost:8000/summary/1) for a given user. 

These are the key metrics you need to calculate:
* The users full name
* The count of meetings they've held in the last 7 days
* The name, date, and details of their next meeting
* The cost of their subscription
* The number of days until their subscription renews

In addition to building the API please document your new endpoint in the README of the Dashboard API subfolder. The document's audience is other engineers who will reference it to build the future UI portion of the Dashboard.

## Part 2 - Update an Existing Service

Choose one of the existing services to and add the functionality described below. Pick whichever language you're most comfortable with - now is not the time for heroics. Our team is ready and willing to discuss solutions in any of the services.

> **Note:** Depending on how you add your new endpoint you may need to update the nginx.conf to make it accessible to the host system.

### Python Assignment

Update the Billing Service to have a new endpoint that calculates the total yearly cost of a users subscription.

### Ruby Assignment

Update the User Service to have a new endpoint for admins that returns a list of all users and their position in the company.

### Node Assignment

Update the Calendar Service to have a new endpoint that accepts a start and end date as url parameters and filters events to be inclusive of the two dates.

## Part 3 - Update the Dahsboard API

Include your new feature in the response for the Dashboard API.

## Final Submission

Create a PR in the forked repository and fill out the description with an overview of your changes. Email a link to the PR to your recruiter.
