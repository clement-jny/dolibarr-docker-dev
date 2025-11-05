# Parameters
v ?=
p ?=

# Main Dolibarr
get-dolibarr:
	bash scripts/get-dolibarr.sh $(v)

# Test Dolibarr
up-test-dolibarr:
	bash scripts/create-test-dolibarr.sh $(v) $(p)
	docker compose -f test/test-$(v)-$(p).yml up -d
down-test-dolibarr:
	docker compose -f test/test-$(v)-$(p).yml down
	rm -f test/test-$(v)-$(p).yml
