
test-redshift:
	dbt deps
	dbt seed --target redshift
	dbt run --target redshift --full-refresh
	dbt test --target redshift

test-postgres:
	dbt deps
	dbt seed --target postgres
	dbt run --target postgres --full-refresh
	dbt test --target postgres

clean:
	dbt clean
