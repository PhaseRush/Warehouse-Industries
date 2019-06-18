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
