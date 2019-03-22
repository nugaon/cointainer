#!/bin/bash

docker run -v /home/ubuntu/bitcoin:/home/ubuntu/bitcoin --rm -it -d -p 18332:18332 nemesgyadam/bitcoin-core -rpcallowip=172.17.0.0/16 -rpcauth='nemes:762008f3357fb7ed19864d632f62701e$19685dea44164627fd3277feeac445e2ef52002b816441ad531b92db9fd5232e'

