
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

# create client
set @address = "";
set @postal_code = "";
set @suite_number = "";
set @user_name = "";
set @pass_word = "";

#given by system
set @cid = "";

insert into client_addresses
values (address,postal_code);

insert into clients
values (cid,address,suite_number);

insert into login_cust
values(user_name,pass_word,cid);

#get list of cids
select client_id
from clients;
