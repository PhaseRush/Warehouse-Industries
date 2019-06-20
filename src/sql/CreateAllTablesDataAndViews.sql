create table worker_addresses
(
    address     varchar(100) primary key,
    postal_code varchar(6)
);
create table client_addresses
(
    address     varchar(100) primary key,
    postal_code varchar(6)
);


create table clients
(
    client_id int primary key,
    address   varchar(100),
    suite_num varchar(6),

    foreign key (address) references client_addresses (address) on delete cascade
);

create table workers
(
    worker_id     int primary key,
    address       varchar(100) not null,
    suite_num     varchar(6)   default 'none',
    working_hours varchar(100) default 'standard mon-fri 9-5',

    foreign key (address) references worker_addresses (address) on delete cascade
);

create table packages
(
    package_id     int primary key,
    client_id      int  not null,
    package_size   varchar(50) default 'medium',
    package_weight int         default 10,
    delivery_date  date not null,

    foreign key (client_id) references clients (client_id) on delete cascade
);


create table stored_packages
(
    storage_id    int,
    package_id    int not null,
    delivery_date date,

    primary key (storage_id, package_id),
    foreign key (package_id) references packages (package_id) on delete cascade
);

create table incoming_packages
(
    event_id     int,
    package_id   int,
    arrival_date date,

    primary key (event_id, package_id),
    foreign key (package_id) references packages (package_id) on delete cascade
);

create table warehouses
(
    warehouse_id     int primary key,
    plan_id          int,
    address          varchar(100),
    capacity         int        default 1000,
    date_updated     date       default 20000101,
    has_cold_storage varchar(1) default '0'
);

create table stores
(
    warehouse_id int not null,
    package_id   int primary key,

    foreign key (warehouse_id) references warehouses (warehouse_id) on delete cascade,
    foreign key (package_id) references packages (package_id) on delete cascade
);


create table trucks
(
    truck_id   int primary key,
    capacity   int not null,
    departed   varchar(1),
    package_id int not null,
    storage_id int not null,

    foreign key (storage_id, package_id) references stored_packages (storage_id, package_id) on delete cascade

);

create table truck_drivers
(
    worker_id int primary key,
    truck_id  int not null,

    foreign key (worker_id) references workers (worker_id) on delete cascade,
    foreign key (truck_id) references trucks (truck_id) on delete cascade
);


create table warehouse_workers
(
    worker_id    int primary key,
    warehouse_id int not null,
    storage_id   int not null,
    package_id   int not null,

    foreign key (worker_id) references workers (worker_id) on delete cascade,
    foreign key (warehouse_id) references warehouses (warehouse_id) on delete cascade,
    foreign key (storage_id, package_id) references stored_packages (storage_id, package_id) on delete cascade
);

create table forklift_models
(
    model_id      int primary key,
    forklift_size varchar(50)
);
create table forklifts
(
    forklift_id    int primary key,
    date_purchased date default 20000101 not null,
    model_id       int                   not null,
    foreign key (model_id) references forklift_models (model_id) on delete cascade
);


create table forklift_houses
(
    forklift_id  int primary key,
    warehouse_id int not null,

    foreign key (forklift_id) references forklifts (forklift_id) on delete cascade,
    foreign key (warehouse_id) references warehouses (warehouse_id) on delete cascade
);


create table forklift_drivers
(
    worker_id   int not null,
    forklift_id int not null,

    primary key (worker_id, forklift_id),
    foreign key (worker_id) references workers (worker_id) on delete cascade,
    foreign key (forklift_id) references forklifts (forklift_id) on delete cascade
);


create table truck_houses
(
    warehouse_id int not null,
    truck_id     int primary key,

    foreign key (warehouse_id) references warehouses (warehouse_id) on delete cascade,
    foreign key (truck_id) references trucks (truck_id) on delete cascade
);


create table works_at
(
    worker_id    int primary key,
    warehouse_id int not null,

    foreign key (worker_id) references workers (worker_id) on delete cascade,
    foreign key (warehouse_id) references warehouses (warehouse_id) on delete cascade
);

create table login_cust
(
    username  varchar(100) not null,
    pass_word varchar(100) not null,
    client_id int          not null,
    primary key (username, pass_word),
    foreign key (client_id) references clients (client_id) on delete cascade
);

create table login_worker
(
    username  varchar(100) not null,
    pass_word varchar(100) not null,
    worker_id int          not null,
    primary key (username, pass_word),
    foreign key (worker_id) references workers (worker_id) on delete cascade
);

create table login_man
(
    username   varchar(100) not null,
    pass_word  varchar(100) not null,
    manager_id int          not null,

    primary key (username, pass_word),
    foreign key (manager_id) references managers (manager_id) on delete cascade
);

insert into worker_addresses
values ('str1', 'aaaaaa');
insert into worker_addresses
values ('str2', 'aaaaab');
insert into worker_addresses
values ('str3', 'aaaaac');
insert into worker_addresses
values ('str4', 'aaaaad');
insert into worker_addresses
values ('str5', 'aaaaae');

insert into client_addresses
values ('str1', 'aaaaaa');
insert into client_addresses
values ('str2', 'aaaaab');
insert into client_addresses
values ('str3', 'aaaaac');
insert into client_addresses
values ('str4', 'aaaaad');
insert into client_addresses
values ('str5', 'aaaaae');


insert into clients
values (1, 'str1', 'x86');
insert into clients
values (2, 'str1', '44');
insert into clients
values (3, 'str2', 'b12');
insert into clients
values (4, 'str2', 'a12');
insert into clients
values (5, 'str4', '001');



insert into workers
values (1, 'str1', '01', DEFAULT);
insert into workers
values (2, 'str2', '16', DEFAULT);
insert into workers
values (3, 'str3', 'b09', DEFAULT);
insert into workers
values (4, 'str3', '02', DEFAULT);
insert into workers
values (5, 'str4', '01', 'mon-thurs 12-12');
insert into workers
values (6, 'str5', 't1', 'mon-thurs 12-12');
insert into workers
values (7, 'str1', 't2', 'sat-sun 0-12');
insert into workers
values (8, 'str4', 't3', 'mon-thurs 12-12');
insert into workers
values (9, 'str3', 't4', 'sat-sun 0-12');
insert into workers
values (10, 'str3', 't5', 'mon-thurs 12-12');


insert into packages
values (1, 1, DEFAULT, DEFAULT);
insert into packages
values (2, 1, DEFAULT, DEFAULT);
insert into packages
values (3, 1, 'huge', 10000);
insert into packages
values (4, 2, 'huge', 10000);
insert into packages
values (5, 3, 'huge', 10000);
insert into packages
values (6, 4, 'huge', 10000);
insert into packages
values (7, 4, 'huge', 10000);
insert into packages
values (8, 4, 'huge', 10000);
insert into packages
values (9, 4, 'huge', 10000);
insert into packages
values (10, 4, 'huge', 10000);


insert into stored_packages
values (1, 6, null);
insert into stored_packages
values (2, 7, null);
insert into stored_packages
values (3, 8, null);
insert into stored_packages
values (4, 9, null);
insert into stored_packages
values (5, 10, 20200220);


insert into incoming_packages
values (1, 1, 20190524);
insert into incoming_packages
values (2, 2, 20190824);
insert into incoming_packages
values (3, 3, 20190724);
insert into incoming_packages
values (4, 4, 20190624);
insert into incoming_packages
values (5, 5, 20190616);


insert into warehouses
values (1, 1, '123 gills st.', 1000, DEFAULT, '0');
insert into warehouses
values (2, 2, '1234 gills st.', DEFAULT, DEFAULT, '0');
insert into warehouses
values (3, 17, '12 mack ave.', 1000, DEFAULT, '0');
insert into warehouses
values (4, 9, 'other creative street name', 123123, DEFAULT, '0');
insert into warehouses
values (5, 2, 'get me out st.', DEFAULT, 20160412, '0');



insert into stores
values (1, 6);
insert into stores
values (2, 7);
insert into stores
values (3, 8);
insert into stores
values (3, 9);
insert into stores
values (3, 10);


insert into trucks
values (1, 12000, '0', 6, 1);
insert into trucks
values (2, 12000, '1', 7, 2);
insert into trucks
values (5, 12000, '0', 8, 3);
insert into trucks
values (3, 12000, '1', 9, 4);
insert into trucks
values (4, 12000, '0', 10, 5);


insert into truck_drivers
values (6, 1);
insert into truck_drivers
values (7, 5);
insert into truck_drivers
values (8, 4);
insert into truck_drivers
values (9, 3);
insert into truck_drivers
values (10, 2);


insert into warehouse_workers
values (1, 5, 1, 1);
insert into warehouse_workers
values (2, 5, 2, 2);
insert into warehouse_workers
values (3, 4, 4, 4);
insert into warehouse_workers
values (4, 4, 3, 3);
insert into warehouse_workers
values (5, 2, 3, 3);

insert into forklift_models
values (1, 'small');
insert into forklift_models
values (2, 'medium');
insert into forklift_models
values (3, 'large');
insert into forklift_models
values (4, 'small');
insert into forklift_models
values (5, 'large');


insert into forklifts
values (1, 20181212, 1);
insert into forklifts
values (2, 20181212, 1);
insert into forklifts
values (3, DEFAULT, 1);
insert into forklifts
values (4, 20121212, 2);
insert into forklifts
values (5, 20180212, 3);
insert into forklifts
values (6, 20180312, 3);
insert into forklifts
values (7, 20001112, 3);


insert into forklift_houses
values (1, 1);
insert into forklift_houses
values (2, 2);
insert into forklift_houses
values (3, 3);
insert into forklift_houses
values (4, 3);
insert into forklift_houses
values (5, 4);
insert into forklift_houses
values (6, 5);
insert into forklift_houses
values (7, 5);


insert into forklift_drivers
values (1, 1);
insert into forklift_drivers
values (2, 2);
insert into forklift_drivers
values (3, 3);
insert into forklift_drivers
values (4, 4);
insert into forklift_drivers
values (7, 5);



insert into truck_houses
values (1, 1);
insert into truck_houses
values (1, 2);
insert into truck_houses
values (1, 3);
insert into truck_houses
values (1, 4);
insert into truck_houses
values (2, 5);



insert into works_at
values (1, 1);
insert into works_at
values (2, 2);
insert into works_at
values (3, 3);
insert into works_at
values (4, 3);
insert into works_at
values (5, 3);

insert into managers
values (1, 2);
insert into managers
values (2, 1);
insert into managers
values (3, 4);
insert into managers
values (4, 3);
insert into managers
values (5, 5);

#special additions for division statement
insert into forklift_drivers
values (10, 1);
insert into forklift_drivers
values (10, 2);
insert into forklift_drivers
values (10, 4);
insert into forklift_drivers
values (10, 3);
insert into forklift_drivers
values (10, 5);
insert into forklift_drivers
values (10, 6);
insert into forklift_drivers
values (10, 7);

insert into login_cust
values ('aaaa', '1111', 1);
insert into login_cust
values ('HomerSimpson', 'doh', 2);
insert into login_cust
values ('username', 'password', 3);

insert into login_worker
values ('bbbb', '2222', 1);

insert into login_man
values ('MontyBurns', 'excellent', 1)

create view emp_packages AS
    select trucks.package_id as id, workers.worker_id
    from workers
             natural join truck_drivers
             natural join trucks
             natural join stored_packages
    union
    select incoming_packages.package_id as id, workers.worker_id
    from workers
             natural join warehouse_workers
             natural join incoming_packages;

#check assigned equipment
create view emp_equip as
    select truck_drivers.truck_id as id, workers.worker_id
    from workers
             natural join truck_drivers
    union
    select forklift_drivers.forklift_id as id, workers.worker_id
    from workers
             natural join forklift_drivers;

#check assigned warehouse
create view emp_work_at AS
select works_at.warehouse_id as id, workers.worker_id
from workers
         natural join works_at;

create view cust_track as
    SELECT stored_packages.package_id as id, arrival_date, delivery_date
    FROM stored_packages
             LEFT JOIN incoming_packages ON stored_packages.package_id = incoming_packages.package_id
    UNION
    SELECT incoming_packages.package_id as id, arrival_date, delivery_date
    FROM stored_packages
             RIGHT JOIN incoming_packages ON stored_packages.package_id = incoming_packages.package_id;

create view incomingpackage AS
SELECT p.package_size, p.package_weight, i.arrival_date, i.package_id, i.event_id
FROM packages p
         right outer join incoming_packages i on p.package_id = i.package_id;

#Create a view of outgoing package
create view outgoingpackage AS
SELECT p.package_size, p.package_weight, p.arrival_date, s.package_id, s.storage_id
FROM packages p
         RIGHT OUTER JOIN stored_packages s
                          ON p.package_id = s.package_id
         INNER JOIN trucks t
                    ON p.package_id = t.package_id
WHERE t.departed = 1;

#Create a view of the combined worker ISA relationship, 
#if truck_id is not null then a worker is truck driver,
#if package_id is not null then a worker is a warehouse worker
create view combinedworker AS
SELECT w.worker_id, t.truck_id, ww.package_id
FROM worker w
         LEFT OUTER JOIN truck_driver d
                         ON w.worker_id = d.worker_id
         LEFT OUTER JOIN warehouse_workers ww
                         ON w.worker_id = ww.worker_id;

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
SELECT t.truck_id, t.capacity - t.package_weight AS remaining_cap
FROM trucks t;

# Returns the client_id's of those who have ordered something in the last week
CREATE VIEW weeklyclients AS
SELECT client_id, package_id
FROM packages
WHERE delivery_date >= curdate() - INTERVAL DAYOFWEEK(curdate()) + 6 DAY
  AND delivery_date < curdate() - INTERVAL DAYOFWEEK(curdate()) - 1 DAY
ORDER BY client_id;
