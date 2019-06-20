#Create a view of incoming package including the package and event id
create view incomingpackage AS
	SELECT p.package_size, p.package_weight, i.arrival_date, i.package_id, i.event_id
	FROM packages p
	right outer join incoming_packages i on p.package_id = i.package_id;

# see a specific package with a given event id and package id
set @eid = 1;
set @inpid = 1;

SELECT package_size, package_weight, arrival_date
FROM incomingpackage
WHERE event_id = eid AND package_id = inpid;

#Create a view of outgoing package
create view outgoingpackage AS
	SELECT p.package_size, p.package_weight, p.arrival_date, s.package_id, s.storage_id
    FROM packages p
    RIGHT OUTER JOIN stored_packages s 
		ON p.package_id = s.package_id
    INNER JOIN trucks t 
		ON p.package_id = t.package_id
        WHERE t.departed = 1;
        
# see a specific outgoing package with a given storage id and package id
set @sid = 1;
set @outpid = 1;

SELECT package_size, package_weight, arrival_date
FROM outgoingpackage
WHERE package_id = outpid AND sid = storage_id;

#Create a view of the combined worker ISA relationship, 
#if truck_id is not null then a worker is truck driver,
#if package_id is not null then a worker is a warehouse worker
create view combinedworker AS
	SELECT w.worker_id, d.truck_id, ww.package_id #wtf is t
    FROM workers w
	LEFT OUTER JOIN truck_drivers d
		ON w.worker_id = d.worker_id
	LEFT OUTER JOIN warehouse_workers ww
		ON w.worker_id = ww.worker_id;

# see the role of a given worker from worker id (check if a column is not null)
set @wid = 1;

SELECT worker_id, truck_id, package_id
FROM combined worker;

# Update a warehouse worker's role (updates worker because package_id is foreign key)
set @role = "";
set @workerid = "";

UPDATE warehouse_workers
SET package_id = role
WHERE worker_id = workerid;

# Update a truck driver's role (Updates worker because truck_id is foreign key
set @truckrole = "";
set @truckworkerid = "";

UPDATE truck_drivers
SET truck_id = truckrole
WHERE employee_id = truckworkerid;

# Adds a truck driver
set @workerid = 1;
set @truckid = 1;
set @address = "";
set @postalcode = "";
set @suite = "";
set @hours = "";

insert into workers
values(workerid, address, suite, hours);

insert into truck_drivers
values (workerid, truckid);

insert into worker_addresses
values (address, postalcode);

# Adds a warehouse worker
set @workerid = 1;
set @address = "";
set @postalcode = "";
set @suite = "";
set @hours = "";
set @storageid = 1;
set @packageid = 1;
set @warehouseid = 1;

insert into workers
values(workerid, address, suite, hours);

insert into warehouse_workers
values (workerid, warehouseid, storageid, packageid);

insert into worker_addresses
values (address, postalcode);

# Manager can see which items are currently sitting in the warehouse
CREATE VIEW storedpackages AS
#Info on capacity of warehouse
	SELECT s.package_id, w.capacity
    FROM warehouses w
    LEFT JOIN stores s ON
		h.warehouse_id = s.warehouse_id
	LEFT JOIN stored_packages p ON
		p.package_id = s.package_id
	#client_id is null when there is no delivery date
	WHERE s.delivery_date IS NULL
    ORDER BY w.warehouse_id;

# Finds how filled a truck is
CREATE VIEW filledcap AS
	SELECT t.truck_id, t.capacity-t.package_weight AS remaining_cap
    FROM trucks t;

#Returns workers that drive all forklifts
select w.worker_id 
from workers w
where not exists
(select * from  forklifts f
where not exists 
(select fd.forklift_id 
from forklift_drivers fd
where w.worker_id = fd.worker_id and fd.forklift_id = f.forklift_id));

# Returns the client_id's of those who have ordered something in the last week
CREATE VIEW weeklyclients AS
	SELECT client_id, package_id
    FROM packages
    WHERE delivery_date >= curdate() - INTERVAL DAYOFWEEK(curdate()) + 6 DAY
    AND delivery_date < curdate() - INTERVAL DAYOFWEEK(curdate()) - 1 DAY
    ORDER BY client_id;
    
SELECT COUNT(client_id), package_id
FROM weeklyclients
GROUP BY client_id;

#Returns the package_id's from a given client
set @clientid = 1;
    
SELECT package_id
FROM weeklyclients
WHERE clientid = client_id;

