--
-- note: this script assumes pg_hba.conf is configured correctly
--

-- \connect postgres postgres

drop database if exists hibernate;
drop user if exists hibuser;

CREATE USER hibuser PASSWORD '!h1bUs3r#';

CREATE DATABASE hibernate WITH OWNER = hibuser ENCODING = 'UTF8' TABLESPACE = pg_default;

GRANT ALL PRIVILEGES ON DATABASE hibernate to hibuser;
