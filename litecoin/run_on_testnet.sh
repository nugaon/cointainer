docker run -v /home/ubuntu/.litecoin:/home/ubuntu/.litecoin -d -p 19332:19332 --rm --name litecoin-core-testnet nemesgyadam/litecoin-core -testnet -printtoconsole  -rpcallowip=172.17.0.0/16 -rpcauth='nemes:762008f3357fb7ed19864d632f62701e$19685dea44164627fd3277feeac445e2ef52002b816441ad531b92db9fd5232e'

