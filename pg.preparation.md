## Lecture 1

One instance of a PostgreSQL server serves a cluster of databases.

The server of the database cannot work under root. Usually, the user "postgres" is used.

It's better to activate the control sum.

To know the current settings of my cluster, I just need to run pg_config --configure.



## Lecture 2

To check the documentation, run the following commands in bash:
```
man psql
psql --help
```

To check all available commands, use `\?`.  
To check all available variables, use `\? variables`.  
To check the current settings for `\pset`, simply run it without arguments.  
To run shell commands, use `\! command`.

To set up an environment variable, use `\setenv TEST Hello`.  
To set up a PostgreSQL variable, use `\set TEST Hello`.  
To check the value of a variable, use `\echo :TEST`.  
To unset a variable, use `\unset TEST`.

To set a PostgreSQL variable from a select statement, use `select now() as curr_time \gset`.The row must be only one, with any number of columns.  
To check all variables, use `\set` without any parameters.


## Lecture 3

To check the main configuration file, use `show config_file`.  
To reload this file, use either `pg_ctl reload` or `select pg_reload_conf()`.

To read the contents of the configuration files, use the view `pg_file_settings`.

There is a second configuration file, `postgresql.auto.conf`, which can be used with `alter system set PARAMS to VARIABLE`.  
To check the current value, use:
- `show SETTING_NAME`
- `SELECT current_setting(SETTING_NAME)`.

To change settings for the current session, use:
- `SET PARAM to VARIABLE`
- `SELECT set_config(PARAM, VARIABLE, bool)`.

To change the setting for a single transaction, use:
- `SET LOCAL PARAM TO VARIABLE`
- `SELECT set_config(PARAM, VARIABLE, true)`.
