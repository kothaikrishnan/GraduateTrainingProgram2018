-- ProblemSet2, August 21 2018
-- Submission by <kothai.krishnan@accenture.com> 

1.Write a valid SQL statement that calculates the total weight of all corn cobs that were picked from the garden:

select sum(picked.weight) as total_weight_corn from picked picked 
inner join plant plant on picked.plantfk=plant.plantid where plant.name='Corn';

2.For some reason Erin has change his location for picking the tomato to North. Write the corresponding query.

update picked set locationFK=(select locationid from location where name='North') 
where gardenerFK=(select gardenerid from gardener where name='Erin')and  plantFK=(select plantid from plant where name='Tomato');

3.Insert a new column 'Exper' of type Number (30) to the 'gardener' table which stores Experience of the of person.
How will you modify this to varchar2(30).

alter table gardener add column exper Number(30);
alter table gardener modify column (exper varchar2(30));

4.Write a query to find the plant name which required seeds less than 20 which plant on 14-APR

select name from plant plant inner join planted planted on plant.plantid=planted.plantFK where seeds<20 and date1='14-APR-2012';


5.List the amount of sunlight and water to all plants with names that start with letter 'c' or letter 'r'.

select sunlight,water,name from plant where name like 'C%' or name like 'R%';

6.Write a valid SQL statement that displays the plant name and the total amount of seed required for each plant that were plant in the
garden. The output should be in descending order of plant name.

select name,sum(seeds) from plant plant inner join planted planted on plantid=plantFK group by name order by name desc;

7.Write a valid SQL statement that calculates the average number of items produced per seed planted for each plant type:
( (Average Number of Items = Total Amount Picked / Total Seeds Planted.)

select name,(sum(amount)/sum(seeds)) as avg_no_of_items from picked picked
inner join planted planted on picked.plantFK=planted.plantFK inner join plant plant on plant.plantid=picked.plantFK group by name;

8.Write a valid SQL statement that would produce a result set like the following:

 name |  name  |    date    | amount 
------|--------|------------|-------- 
 Tim  | Radish | 2012-07-16 |     23 
 Tim  | Carrot | 2012-08-18 |     28 

select gardener.name,plant.name,picked.date1,picked.amount from gardener gardener 
inner join picked  picked on gardener.gardenerid=picked.gardenerFK 
inner join plant plant on plant.plantid=picked.plantFK where gardener.name='Tim' and (plant.name='Carrot' or plant.name='Radish')
order by picked.amount;

9.Find out persons who picked from the same location as he/she planted.

select distinct(gardener.name) from gardener gardener inner join planted planted on gardener.gardenerid=planted.gardenerFK 
inner join picked picked on picked.gardenerFK=gardener.gardenerid where planted.locationFK=picked.locationFK;


