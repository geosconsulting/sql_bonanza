SELECT pg_size_pretty( pg_database_size( current_database() ) ) As human_size
, pg_database_size( current_database() ) As raw_size;