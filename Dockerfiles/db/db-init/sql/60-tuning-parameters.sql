ALTER SYSTEM SET port TO 5432;
ALTER SYSTEM SET wal_level TO 'minimal';
ALTER SYSTEM SET max_wal_senders TO 0;
ALTER SYSTEM SET effective_cache_size TO '375MB';
ALTER SYSTEM SET shared_buffers TO '125MB';
ALTER SYSTEM SET work_mem TO '4MB'; -- (valeur par défaut pour pas trop descendre)
ALTER SYSTEM SET maintenance_work_mem TO '64MB'; -- (valeur par défaut pour pas trop descendre)