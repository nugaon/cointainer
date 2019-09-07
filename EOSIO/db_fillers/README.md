# Description
If you run PostgreSQL container by the `run_db_fillers.sh` script from this parent folder, the default db password will be
> eosio-dbpass

# CLI connection

Connect to the PostgreSQL console by
> docker exec -ti eosio-postgres psql -U postgres -W

When it asks for password type 'eosio-dbpass' (by default). To print out the all tables of the state_history_plugin enter to the psql CLI
> select table_name from information_schema.tables where table_schema = 'chain';

# fill-pg option list
By run the `run_db_fillers.sh` you can pass to options of the `fill-pg`. The possible flags are
```text
Command Line Options for fill_pg_plugin:
  --fpg-drop                            Drop (delete) schema and tables
  --fpg-create                          Create schema and tables

Config Options for fill_plugin:
  -f [ --fill-connect-to ] arg (=localhost:8080)
                                        State-history endpoint to connect to
                                        (nodeos)
  -t [ --fill-trim ]                    Trim history before irreversible

Command Line Options for fill_plugin:
  -k [ --fill-skip-to ] arg             Skip blocks before [arg]
  -x [ --fill-stop ] arg                Stop before block [arg]

Config Options for pg_plugin:
  --pg-schema arg (=chain)              Database schema

Application Config Options:
  --plugin arg                          Plugin(s) to enable, may be specified
                                        multiple times

Application Command Line Options:
  -h [ --help ]                         Print this help message and exit.
  -v [ --version ]                      Print version information.
  --print-default-config                Print default configuration template
  -d [ --data-dir ] arg                 Directory containing program runtime
                                        data
  --config-dir arg                      Directory containing configuration
                                        files such as config.ini
  -c [ --config ] arg (=config.ini)     Configuration file name relative to
                                        config-dir
  -l [ --logconf ] arg (=logging.json)  Logging configuration file name/path
                                        for library users
```

# References
- [state_history_plugin github repo](https://github.com/EOSIO/history-tools)
- [EOSIO's related documentation about state_history_plugin](https://developers.eos.io/eosio-nodeos/docs/monitoring-with-state-history)
