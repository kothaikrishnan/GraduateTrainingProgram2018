


1.Find the titles of all movies directed by Steven Spielberg. (1 point possible)

select title from Movie where director='Steven Spielberg';

2.Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. (1 point possible)

select distinct(year) from Movie m inner join Rating r on m.mID=r.mID where stars=4 or stars=5 order by year;

3.Find the titles of all movies that have no ratings. (1 point possible)

select mID,title from Movie where mID not in(select m.mID from Movie m inner join Rating r on m.mID=r.mID);

4.Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. (1 point possible)

select rev.name from Reviewer rev inner join Rating r on rev.rID=r.rID where r.ratingDate is NULL;

5.Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. (1 point possible)

select rev.name,m.title,r.stars,r.ratingDate from movie m inner join Rating r on m.mID=r.mID inner join Reviewer rev on rev.rID=r.rID order by rev.name,m.title,r.stars;

6.For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. (1 point possible)

select rev.name,m.title from Reviewer rev inner join Rating r1 on r1.rID=rev.rID 
inner join Rating r2 on r2.rID=rev.rID and r2.mID=r1.mID 
inner join movie m on m.mID=r1.mID where r2.ratingDate>r1.ratingDate and r2.stars> r1.stars;

7.For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title. (1 point possible)

select m.title,r.stars from movie m inner join rating r on r.mID=m.mID group by r.mID having max(stars);

8.For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. (1 point possible)

select m.title,max(stars)-min(stars) as 'rating spread' from Movie m inner join Rating r on m.mID=r.mID group by r.mID order by 'rating spread' desc,m.title;

9.Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) (1 point possible)

select (select avg(st) from (select movie.mID, movie.year, avg(rating.stars) as st from rating join movie on movie.mID=rating.mID group by movie.mID) where year<1980) -(select avg(st)from (select movie.mID, movie.year, avg(rating.stars) as st from rating join movie on movie.mID=rating.mID group by movie.mID) where year>1980);


10.Find the names of all reviewers who rated Gone with the Wind. (1 point possible)

select distinct(rev.name) from reviewer rev inner join rating r on rev.rID=r.rID
inner join movie m on m.mID=r.mID where m.title='Gone with the Wind';

11.For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars. (1 point possible)

select rev.name,m.title,count(stars) from Reviewer rev inner join Rating r on r.rID=rev.rID inner join movie m on m.mID=r.mID where rev.name=m.director;

12.Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".) (1 point possible)

select distinct(rev.name),m.title from Reviewer rev inner join Rating r on r.rID=rev.rID inner join movie m on m.mID=r.mID order by rev.name,m.title; 

13.Find the titles of all movies not reviewed by Chris Jackson. (1 point possible)

select title from movie where mID not in(select r.mID from Rating r inner join Reviewer rev on r.rID=rev.rID and rev.name='Chris Jackson');

14.For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order. (1 point possible)

select rev1.name,rev2.name from Rating r1 join Rating r2 on r1.mID=r2.mID join Reviewer rev1 on rev1.rID=r1.rID join Reviewer rev2 on rev2.rID=r2.rID where r1.rID<>r2.rID and r1.rID<r2.rID group by rev1.name,rev2.name;

15.For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars. (1 point possible)

select name,title,min(stars)as no_of_stars from movie m inner join Rating r on m.mID=r.mID inner join Reviewer rev on rev.rID=r.rID group by title;

16.List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order. (1 point possible)

select title,avg(stars) as avg_stars from Movie m inner join Rating r on m.mID=r.mID group by r.mID order by avg_stars desc,title;

17.Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.) (1 point possible)

select name from Reviewer rev inner join Rating r on rev.rID=r.rID group by r.rID having count(stars)>=3;

18.Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) (1 point possible)

select m1.title,m1.director from Movie m1  inner join Movie m2 on m1.director=m2.director and m1.title<>m2.title order by m1.director,m1.title;

select title,director from movie where director in(select director from movie group by director having count(director)>1) order by director,title;

19.Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) (1 point possible)

select title,max(avg1) as highest_rating from(select title,avg(stars) as avg1 from Movie m inner join Rating r on m.mID=r.mID group by title);

20.Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.) (1 point possible)

select title,min(avg1)as lowest_rating from(select title,avg(stars) as avg1 from Movie m inner join Rating r on m.mID=r.mID group by title);

21.For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. (1 point possible)

select title,director,max(stars) from Movie m inner join Rating r on m.mID=r.mID where director is not NULL group by director;
