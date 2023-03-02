# Mystery lunch app

At the beginning of each month, every employee is randomly selected to have lunch with another employee of a different department.

1. Employees management
  -  Departments: operations, sales, marketing, risk, management, finance, HR, development and data
  -  The employee deletion should only disable the employee for future mystery lunches
  - When an employee is created, he/she should join an existing mystery pair (2 people mystery lunch)
  -  When an employee is deleted:
      -  This employee had one mystery partner: the remaining employee should join
      another existing mystery pair (3 people mystery lunch)
      - This employee had two mystery partners: nothing should be done

2. Mystery partners selection
  - The selection should be automatically performed on 1st day of each month
  - Two employees should not be selected to be partners if they were partners in the last 3 months
  - When the number of employees is odd, the remaining employee should join an existing mystery pair (2 people mystery lunch). The department of these three employees should be different.

## Technologies
  * Ruby
  * Git
  * Rspec
  * Sidekiq
  * redis-server
  * Postgres

## Setup
- Ensure you have [ruby](https://rvm.io/rvm/install) installed on your device and also [redis](https://phoenixnap.com/kb/install-redis-on-mac) for background processes

  ```
   Ruby = 3.0.0
  ```

  Clone this repository and cd into the clone specific folder and run the following command 
  accordingly

  ```
   bundle install
  ```

  ```
   rails db:create 
  ```

  ```
   rails db:migrate
   rails db:seed
  ```

  After to run server

  ```
  rails s
  ```

  ```
  redis-server
  ```

  ```
   sidekiq
  ```

## Test 
To run all test
```
bundle exec rspec 
```

and to run a specific test 
 ```
 rspec 'relative path to file'
 ```

### What to Add:

- UI
