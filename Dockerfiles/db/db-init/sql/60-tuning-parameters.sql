ALTER SYSTEM SET port TO 5432;

ALTER SYSTEM SET shared_buffers TO '384MB';

ALTER SYSTEM SET wal_level TO 'minimal';

ALTER SYSTEM SET max_wal_senders TO 0;