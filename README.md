# Netflix SQL Data Analysis Project

![Netflix logo](https://github.com/Praveens2912/Netflix_SQL_Project/blob/main/115783-3086x2099-desktop-hd-netflix-background-image.jpg?raw=true)

## Overview
Welcome to my Netflix SQL Data Analysis project. In this project, I've worked on 15 different problems using SQL to explore and analyze the Netflix dataset. Each query focuses on a real-world use case or business insight.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
SELECT 
	type,
	COUNT(*)
	FROM netflix
	group BY 1
```




