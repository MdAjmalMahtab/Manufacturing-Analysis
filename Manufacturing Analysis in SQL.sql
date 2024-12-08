create database Manufacturing;
use Manufacturing;
select * from manufacturing_data;
alter table manufacturing_data change column `ï»¿Buyer` Buyer varchar(200);

# 1.Manufactured Qty
select sum(`Manufactured Qty`) as Total_Manufactured_Qty from manufacturing_data;

# 2.Rejected Qty
select sum(`Rejected Qty`)as Total_Rejected_Qty from manufacturing_data;

# 3.Processed quantity
select sum(`Processed Qty`)as Total_Processed_Qty from manufacturing_data;

# 4.Wastage percentage
select concat(Round((sum(`Rejected Qty`)/sum(`Processed Qty`))*100,2),"%") as `Wastage_%` from manufacturing_data;

# 5.Emp wise Rejected Qty
select `Emp Name`,sum(`Rejected Qty`) as Emp_Rejected_Qty 
from manufacturing_data group by 1 having sum(`Rejected Qty`)!=0 order by 2 desc;

# 6. Machine wise Rejection Qty
select `Machine Name`,sum(`Rejected Qty`) as Machine_Rejected_Qty 
from manufacturing_data group by 1 having sum(`Rejected Qty`)!=0 order by 2 desc;

# 7. Production Comparison trend
select distinct `Fiscal Date`,Total_Produced_Qty, Total, 
concat(Round((Total_Produced_Qty/Total)*100,2),"%") as `%_of_Total` from
(select `Fiscal Date`, sum(`Produced Qty`) over () as Total,
sum(`Produced Qty`) over (partition by `Fiscal Date`) as Total_Produced_Qty
from manufacturing_data) as X
order by `%_of_Total` desc;

# 8. Manufactured Vs Rejected Qty
select sum(`Manufactured Qty`) as Total_Manufactured_Qty,
sum(`Rejected Qty`)as Total_Rejected_Qty from manufacturing_data;

# 9.Dept wise manuf qty vs Rej Qty
select `Department Name`,sum(`Manufactured Qty`) as Total_Manufactured_Qty,
sum(`Rejected Qty`)as Total_Rejected_Qty 
from manufacturing_data group by 1 order by 3 desc;

# 10. Delivery Status Vs Manufactured, Rejected & Processed Qty
select `Delivery Period`,sum(`Manufactured Qty`) as Total_Manufactured_Qty,
sum(`Processed Qty`)as Total_Processed_Qty ,
sum(`Rejected Qty`)as Total_Rejected_Qty from manufacturing_data
group by 1 order by 2 desc;

# 11. Buyer Vs Manufactured and Rejected Qty
select Buyer, sum(`Manufactured Qty`) as Total_Manufactured_Qty,
sum(`Rejected Qty`)as Total_Rejected_Qty from manufacturing_data
group by 1 order by 3 desc;

# 12. Operation name Vs Manufactured, Rejected & Processed Qty
select `Operation Name`,sum(`Manufactured Qty`) as Total_Manufactured_Qty,
sum(`Processed Qty`)as Total_Processed_Qty ,
sum(`Rejected Qty`)as Total_Rejected_Qty
from manufacturing_data group by 1 order by 4 desc;