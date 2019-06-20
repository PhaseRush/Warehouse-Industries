#login for client
select client_id 
from login_cust
where username = var1 and pass_word = var2;

#login for emps
select worker_id 
from login_worker
where username = var1 and pass_word = var2;

#login for man
select manager_id 
from login_man
where username = var1 and pass_word = var2;

# in case customer forgets password, would require managers to do so probs
select pass_word
from login_cust 
where username = var1;