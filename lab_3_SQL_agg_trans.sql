SELECT * FROM film;

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
#Hint: Look for floor and round functions.

SELECT MAX(length) FROM film AS max_duration;
# The max movie length is 18 minutes.
SELECT MIN(length) FROM film AS min_duration; 
# The min movie length is 46 minutes.
SELECT ROUND(AVG(length),0) FROM film AS average_movie_duration;
# The average movie length is 46 minutes.

#2.1 Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
#Hint: use a conditional expression.


SELECT DATEDIFF(MAX(rental_date),MIN(rental_date))
FROM rental;
# The company has been operating for 266 days.

SELECT *, 
MONTHNAME(rental_date) as month,
DAYNAME(rental_date) as day
from rental
LIMIT 20;

SELECT *,
MONTHNAME(rental_date) as month,
DAYNAME(rental_date) as day,
IF (DAYNAME(rental_date)="Sunday" or "Monday", "weekend", "weekday") as day_type
from rental;

#You need to ensure that customers can easily access information about the movie collection. 
#To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, 
#replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
#Please note that even if there are currently no null values in the rental duration column, the query should still 
#be written to handle such cases in the future. Hint: Look for the IFNULL() function.

SELECT * from film;

SELECT title, 
IFNULL(rental_duration, 'Not Available') as rental_duration
from film
order by title ASC;

#Bonus: The marketing team for the movie rental company now needs to create a personalized email 
#campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, 
#along with the first 3 characters of their email address, so that you can address them by their first name and 
#use their email address to send personalized recommendations. The results should be ordered by last name in ascending 
#order to make it easier to use the data.

SELECT * FROM customer;

SELECT *,
CONCAT(first_name, last_name) as full_name,
LEFT(email, 3) as first_3_email
FROM customer
ORDER BY last_name ASC;

#Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
#1.1 The total number of films that have been released.
#1.2 The number of films for each rating.
#1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
#This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT COUNT(*) FROM film;
#1001 movies have been released.

SELECT rating, COUNT(*) 
FROM film
GROUP BY rating;
#PG=194, G=178, NC-17=210, PG-13=223, R=196.

SELECT rating, COUNT(*) 
FROM film
GROUP BY rating
ORDER BY rating DESC;

#Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT * FROM film;

SELECT 
ROUND(AVG(length),2) as avg_duration, 
rating
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT ROUND(AVG(length),2) as avg_duration, rating
FROM film
GROUP BY rating
HAVING avg_duration>120
ORDER BY rating DESC;
#Only PG-13 movies have an average duration of more than 2 hours.

# Bonus: determine which last names are not repeated in the table actor.
SELECT * FROM actor;
#There are 121 unique last names in the actor table.
SELECT DISTINCT last_name from actor;
