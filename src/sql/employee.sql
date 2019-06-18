#check assigned task, which will be a list of packages
create view emp_packages AS
	select trucks.package_id as id, workers.worker_id
	from workers natural join truck_drivers natural join trucks natural join stored_packages
	union 
    select incoming_packages.package_id as id, workers.worker_id
    from workers natural join warehouse_workers natural join incoming_packages;
    
#check assigned equipment
create view emp_equip as
	select truck_drivers.truck_id as id, workers.worker_id
    from workers natural join truck_drivers
    union 
    select forklift_drivers.forklift_id as id, workers.worker_id
    from workers natural join forklift_drivers;

#check assigned warehouse
create view emp_work_at AS
	select works_at.warehouse_id as id, workers.worker_id
	from workers natural join works_at;

#remove package from incoming and move to stored_packages
set @var = 2;

insert into stored_packages
values (null, var, null);
delete from incoming_package where package_id = var;

#remove package from stored_package after it has been delivered 
set @var = 2;

delete from stored_packages where package_id = var;
