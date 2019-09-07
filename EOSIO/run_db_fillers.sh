
NET=""
while true; do
    echo "Which blockchain net would you like to join?"
    echo "1) privatenet"
    echo "2) testnet"
    echo "3) mainnet"
    read -p "[1-3] " NET
    case $NET in
        1 )
            NET="privatenet"; echo "DB filler will start on ${NET}"; break;;
        2 )
            NET="testnet"; echo "DB filler will start on ${NET}"; break;;
        3 )
            NET="mainnet"; echo "DB filler will start on ${NET}"; break;;
        * ) echo "Please answer 1, 2 or 3";;
    esac
done
DOCKER_NETWORK="eosio-${NET}-network"
docker network create $DOCKER_NETWORK || true
docker network connect $DOCKER_NETWORK eosio-${NET}

DB_PASS="eosio-dbpass"
START_POSTGRE=""
while true; do
    read -p "Would you like to load a PostgreSQL for the eosio's state history plugin? [Y / n] " START_POSTGRE
    case $START_POSTGRE in
        [Yy]* | "")
            echo "Start PostgreSQL server with root user 'postgres' and password '${DB_PASS}'"
            docker run --network $DOCKER_NETWORK --name eosio-postgres -e POSTGRES_PASSWORD=$DB_PASS -d -p 127.0.0.1:5432:5432 postgres
            echo "Wait for a while until the service initializes"
            sleep 8
            break
            ;;
        [Nn]* ) break;;
        * ) echo "Please answer y or n.";;
    esac
done

echo "Start DB filler container..."
docker run --network ${DOCKER_NETWORK} --name eosio-db-fillers -d cointainer/eosio-db-fillers --eosio-history-ep=eosio-${NET}:8080 $@
echo "If it doesn't work and you try first, add '--fpg-create' flag at the script call"
