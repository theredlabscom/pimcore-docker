docker exec -u www-data pimcore-web rm .placeholder
docker exec -u www-data pimcore-web composer create-project pimcore/skeleton=1.3.0 .
docker exec -u www-data pimcore-web vendor/bin/pimcore-install --admin-username=admin --admin-password=Admin@1234 --mysql-host-socket=pimcore-mysql --mysql-username=pimcore --mysql-password=pimcore --mysql-database=pimcore --no-interaction
docker exec -u www-data pimcore-web composer require coreshop/core-shop
docker exec -u www-data pimcore-web bin/console pimcore:bundle:enable CoreShopCoreBundle
docker exec -u www-data pimcore-web bin/console coreshop:install