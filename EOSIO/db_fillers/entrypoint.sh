#!/bin/bash
export PGHOST=eosio-postgres
export PGPASSWORD=eosio-dbpass
export PGUSER=postgres
export PGDATABASE=postgres
EOSIO_HISTORY_EP=""
ADDITIONAL_PARAMS=""

for PARAM in "$@"
do
    FLAG=`echo $PARAM | cut -f1 -d=`
    VALUE=`echo $PARAM | cut -f2 -d=`
    case $FLAG  in
        --db-host)
            export PGHOST=$VALUE
            ;;
        --db-password)
            export PGPASSOWRD=$VALUE
            ;;
        --db-user)
            export PGUSER=$VALUE
            ;;
        --db-database)
            export PGDATABASE=$VALUE
            ;;
        --eosio-history-ep)
            EOSIO_HISTORY_EP=$VALUE
            ;;
        *)
            ADDITIONAL_PARAMS="$PARAM $ADDITIONAL_PARAMS"
    esac
done

echo "Start PostgreSQL filler"

fill-pg --fill-connect-to $EOSIO_HISTORY_EP $ADDITIONAL_PARAMS
