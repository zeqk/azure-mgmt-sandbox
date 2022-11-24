## Restore

```bash
/usr/local/pgsql-14/pg_restore \
    --host "....postgres.database.azure.com" \
    --port "5432" --username "dbadmin" --no-password \
    --dbname "psqldb-..." \
    --section=pre-data --section=data --section=post-data --no-owner \
    --verbose  \
    "/var/lib/pgadmin/storage/user_e-mail.com/db.dump.out"
```

Grant permissions

```sql
GRANT pg_read_all_data TO webapi;
GRANT pg_write_all_data TO webapi;
```