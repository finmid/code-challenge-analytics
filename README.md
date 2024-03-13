# Objective

Provide code to create reports on a different financial indicators from given data sources.
Solution must include example reports generated from provided test data.

# Brief

We have a company which processes miscelanious transactions for a few major clients.
Company pays out each transaction through the bank partner.
Revenue earned on every transaction company processes, it is not deducte from actual payment but just tracked with every transaction for reference.

Your task is to build part of reporting pipeline to be executed on a daily basis for company financial performance.

## Postgres Database

Database contains granular transaction information.
You are free to use [scripts](./input-data/data) to bootstrap your own fresh database.
Alternatively, using [docker-compose](https://www.docker.com/products/docker-desktop/) inside [input-data](./input-data) folder you can run
```shell
docker compose up
```
This will start a fresh postgres instance with all the data available.
You can connect to it on localhost:5432 with login `postgres` and password `finmid`

### Table `exchange_rates`

|column         | type         | description                            |
|---------------|--------------|----------------------------------------|
|date           | DATE         | Date of the currency conversion        |
|sell_currency  | TEXT         | ISO code of currency to buy            |
|buy_currency   | TEXT         | ISO code of selling currency           |
|rate           | DECIMAL      | at which rate currency will be bought  |

### Table `transactions`

|column          | type         | description                                                                                                                      |
|----------------|--------------|----------------------------------------------------------------------------------------------------------------------------------|
|id              | UUID         | unique identifier of the transaction                                                                                             |
|booked_time     | TIMESTAMPZ   | Timestamp when transaction have been processed                                                                                   |
|client_name     | TEXT         | Name of the client to which this transaction belongs. For simplicity this is not an ID column but rather some name of the client |
|revenue         | DECIMAL      | How much revenue this transaction brings. Always in currency of transaction                                                      |
|currency        | TEXT         | Currency of this transaction                                                                                                     |

### Table `line_items`

|column          | type         | description                                                                                                                       |
|----------------|--------------|-----------------------------------------------------------------------------------------------------------------------------------|
|id              | UUID         | unique identifier of the line item                                                                                                |
|transaction_id  | UUID         | which transaction this line item belongs to                                                                                       |
|details         | JSONB        | flexible JSON object describing line item details, for instance `total_price`, `quantity`, `name` fields could be present in here |

## CSV export
[CSV export](./input-data/bank_export.csv) of partner bank report.

Structure of CSV file is the following
|column          | description                                         |
|----------------|-----------------------------------------------------|
|currency        | Currency for current account                        |
|date            | ISO-8601 date - i.e. YYYY-MM-DD                     |
|amount          | Amount of money spent for a given day               |

# Tasks

## Part 1

Using database tables provide following repots

* Revenue per month per client - report how much revenue in EUR earned for each client every month.

* Transaction distribution - analyse basket size of transactions to give insights on amounts spent by customer over time. 

## Part 2

It appears there is are bug in our systems - not all transactions go through the partner bank as expected.

Given CSV export of daily volumes from our bank partner and same Postgres database try to identify:

* Which days have mismatches of data.
* Potential transactions which might be missing from bank account export.

# Requirements

* You are free to use any tech stack you like for the job, however sources of data are predefined (i.e. postgres and CSV file)
* Solution should be documented - i.e. people can replicate the workflow and generate new reports themselves.
* All necessary code to use the solution should be provided.
* Bonus points for any kind of visualisation of the data you can provide.
