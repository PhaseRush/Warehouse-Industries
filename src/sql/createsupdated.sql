
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
   client_id      int not null,
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
   model_id int 												     not null,
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
   foreign key (worker_id) references workers (worker_id) on delete cascade ,
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

