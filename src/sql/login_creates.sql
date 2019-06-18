create table login_cust
(
   username    varchar(100) primary key not null,
   pass_word   varchar(100) primary key not null,
   client_id   int not null,

   foreign key (client_id) references clients (client_id) on delete cascade
);

create table login_worker
(
   username    varchar(100) primary key not null,
   pass_word   varchar(100) primary key not null,
   worker_id   int not null,

   foreign key (worker_id) references workers (worker_id) on delete cascade
);

create table login_man
(
   username    varchar(100) primary key not null,
   pass_word   varchar(100) primary key not null,
   manager_id  int not null,

   foreign key (manager_id) references managers (manager_id) on delete cascade
);