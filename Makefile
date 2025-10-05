# Dolibarr part
v ?=
get-dolibarr:
	bash scripts/get-dolibarr.sh $(v)

p ?=
create-test-dolibarr:
	bash scripts/create-test-dolibarr.sh $(v) $(p)
up-test-dolibarr:
	docker compose -f test/test-$(v)-$(p).yml up -d
down-test-dolibarr:
	docker compose -f test/test-$(v)-$(p).yml down