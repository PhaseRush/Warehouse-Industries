
#track shipment 
create view cust_track as
	SELECT stored_packages.package_id as id, arrival_date, delivery_date FROM stored_packages
	LEFT JOIN incoming_packages ON stored_packages.package_id = incoming_packages.package_id
	UNION
	SELECT incoming_packages.package_id as id, arrival_date, delivery_date FROM stored_packages
	RIGHT JOIN incoming_packages ON stored_packages.package_id = incoming_packages.package_id;

#add package

#this var has to be kept tracked by variables
set @var = 1;
set @cid = 1;

# these have to be inputed by the customer 
set @size = "medium";
set @weight = 1;

insert into packages
values (var, cid, size, weight);
