#! /bin/bash

helm delete $(helm list | grep -e  epresso-shop-product-catalog   -e espresso-shop-reviews    -e espresso-shop-web   -e postgres -e redis | awk '{print $1}' 
)

kubectl  delete pvc data-postgresql-ha-postgresql-0     \
            data-postgresql-ha-postgresql-1      \
            data-postgresql-ha-postgresql-2     \
            data-redis-ha-server-0  \
            data-redis-ha-server-1  \
            data-redis-ha-server-2  -n s4

kubectl get all 