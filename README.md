# Perx Technologies "Loyalty program practical example" challenge for backend interview

>  Interview challenge

## Description

The description of the challenge can be viewed [here](https://github.com/PerxTech/backend-interview).

## Project requirements

You are expected to create a git repository (in github or equivalent) and share the repository details with us. The way you manage your commits is up to you, but we would like to have the opportunity to see how is your workflow like. Your code will be evaluated more on the quality than on completing the scope. Our production environment is a high volume environment, we are required to maintain data integrity and performance throughout. Please provide appropriate tests.

## Assumptions!!!

- Requirements did not say anything about when the services starts. I choose a fixed date - 01.01.2020.
- Requirements did not specify how the users and/or purchases should be created. So, I used faker gem to generate 10 users and 450 purchases.
- All users and all the purchases are made on or after this date.
- The requirements did not specify how the user should became level 1 or 2, so I choose that this is a different subscription level and generated randomly users with level 1 and level 2.
- In "Issuing Rewards Rules" the requirements says: "If the end user accumulates 100 points in one calendar month they are given a Free Coffee reward". It does not say if the 100 point should be consumed or not, so I choose not to consume the point, but just add the rewards.
- In the same section for level 2 users the requirements says: "A 5% Cash Rebate reward is given to all users who have 10 or more transactions that have an amount > $100". It does not say what happens if the users have another 10 transaction with amount for more than $100. I choose to continuously give the rewards for each 10 purchases with $100 or more.
- In the section "Loyalty Rules" in the requirements for level 2 users it says: "Loyalty tiers are calculated on the highest points in the last 2 cycles". I opened a [issue](https://github.com/PerxTech/backend-interview/issues) on the very first day, asking a clarifying question - What is a cycle? The issue have not been answered by today 09.10.2022. So, I can't implement this requirement. Anyway, if I assumed that the cycle is 1 year my project should work fine till the end of the year.

## Live demo

THe site is deployed using [Railway](https://railway.app/) services. [Live demo](https://perxtech-backend-interview-production.up.railway.app/users)

## Built With

- Languages: Ruby
- Framework: Ruby on Rails
- Database: PostgreSQL
- Styling: Tailwind CSS
## Usage

Run the following commands:</br>
`git clone https://github.com/Hombre2014/prexTech-backend-interview.git`</br>
`cd prexTech-backend-interview`</br>
`bundle install`</br>
`rails s`</br>
Open a browser and go to: `https://localhost:3000` to view the app.

## Database setup

To start with clean database use:

`cd prexTech-backend-interview`</br>
`rails db:drop db:create db:migrate`

## Testing

`cd prexTech-backend-interview`</br>
run `rspec`

## Author

👤 **Yuriy Chamkoriyski**

- GitHub: [@Hombre2014](https://github.com/Hombre2014)
- Twitter: [@Chamkoriyski](https://twitter.com/Chamkoriyski)
- LinkedIn: [axebit](https://linkedin.com/in/axebit)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Hombre2014/prexTech-backend-interview/issues).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](./license.md) licensed.
