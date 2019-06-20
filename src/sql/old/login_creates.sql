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