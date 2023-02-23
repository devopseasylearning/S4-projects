#! /bin/bash
helm install  postgresql-ha  postgresql-ha  
helm install redis-ha  redis-ha 
helm install  espresso-shop-reviews espresso-shop-reviews 
helm install epresso-shop-product-catalog espresso-shop-product-catalog 
helm install  espresso-shop-web  espresso-shop-web

kubectl get all
