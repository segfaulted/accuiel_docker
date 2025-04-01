
CREATE ROLE interpreter WITH LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT NOREPLICATION NOBYPASSRLS CONNECTION
LIMIT -1 PASSWORD 'int0807int';


ALTER DATABASE interpreter OWNER TO interpreter;

\c interpreter;

DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') LOOP
        EXECUTE 'ALTER TABLE public.' || quote_ident(r.tablename) || ' OWNER TO interpreter;';
    END LOOP;
END $$;


CREATE ROLE statistics WITH LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT NOREPLICATION NOBYPASSRLS CONNECTION
LIMIT -1 PASSWORD 'stat0807stat';


ALTER DATABASE statistics OWNER TO statistics;

\c statistics;

 DO $$ 
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') LOOP
        EXECUTE 'ALTER TABLE public.' || quote_ident(r.tablename) || ' OWNER TO statistics;';
    END LOOP;
END $$;


SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'statistics'
    AND pid <> pg_backend_pid();


CREATE DATABASE statistics_old WITH OWNER = postgres TEMPLATE = statistics ENCODING = 'UTF8' LOCALE_PROVIDER = 'libc' CONNECTION
LIMIT = -1 IS_TEMPLATE = False;

CREATE ROLE statistics_old WITH LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT NOREPLICATION NOBYPASSRLS CONNECTION
LIMIT -1 PASSWORD 'stat0807stat';

\c statistics_old
GRANT EXECUTE ON FUNCTION public.armor(bytea) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.armor(bytea, text[], text[]) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.crypt(text, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.dearmor(text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.decrypt(bytea, bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.decrypt_iv(bytea, bytea, bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.digest(bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.digest(text, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.encrypt(bytea, bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.encrypt_iv(bytea, bytea, bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.gen_random_bytes(integer) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.gen_random_uuid() TO statistics_old;

GRANT EXECUTE ON FUNCTION public.gen_salt(text, integer) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.gen_salt(text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.hmac(text, text, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.hmac(bytea, bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_armor_headers(text, OUT key text, OUT value text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_key_id(bytea) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_pub_decrypt(bytea, bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_pub_decrypt(bytea, bytea) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_pub_decrypt(bytea, bytea, text, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_pub_encrypt(text, bytea) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_pub_encrypt(text, bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_sym_decrypt(bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_sym_decrypt(bytea, text, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_sym_decrypt_bytea(bytea, text, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_sym_decrypt_bytea(bytea, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_sym_encrypt(text, text, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_sym_encrypt(text, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_sym_encrypt_bytea(bytea, text, text) TO statistics_old;

GRANT EXECUTE ON FUNCTION public.pgp_sym_encrypt_bytea(bytea, text) TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.auth_group_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.auth_group_permissions_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.auth_permission_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.auth_user_groups_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.auth_user_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.auth_user_user_permissions_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.base_auditlog_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.django_admin_log_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.django_content_type_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.django_migrations_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.fltp_statistics_participant_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.fltp_statistics_participantevaluationanswers_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.fltp_statistics_professioncode_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.fltp_statistics_registration_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.fltp_statistics_supervisorevaluationanswers_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_client_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_department_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_departmentkind_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_diagnostic_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_diagnosticentry_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_entry_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_entry_professionals_consulted_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_entrydepartment_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_healthprofessional_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_location_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_locationkind_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_service_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_servicekind_id_seq TO statistics_old;

GRANT
SELECT, USAGE ON SEQUENCE public.interpreter_usedservices_id_seq TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.auth_group TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.auth_group_permissions TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.auth_permission TO statistics_old;

GRANT
ALL ON TABLE public.auth_user TO statistics_old;

GRANT
ALL ON TABLE public.auth_user_groups TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.auth_user_user_permissions TO statistics_old;

GRANT
ALL ON TABLE public.base_auditlog TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.django_admin_log TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.django_content_type TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.django_migrations TO statistics_old;

GRANT ALL ON TABLE public.django_session TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.fltp_statistics_participant TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.fltp_statistics_participantevaluationanswers TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.fltp_statistics_professioncode TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.fltp_statistics_registration TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.fltp_statistics_supervisorevaluationanswers TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_client TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_department TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_departmentkind TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_diagnostic TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_diagnosticentry TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_entry TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_entry_professionals_consulted TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_entrydepartment TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_healthprofessional TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_location TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_locationkind TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_service TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_servicekind TO statistics_old;

GRANT
SELECT, TRIGGER ON TABLE public.interpreter_usedservices TO statistics_old;



\c statistics;
DELETE FROM django_migrations WHERE app = 'interpreter';
DELETE FROM django_content_type WHERE app_label='interpreter';

DROP TABLE IF EXISTS interpreter_client CASCADE;
DROP TABLE IF EXISTS interpreter_department CASCADE;
DROP TABLE IF EXISTS interpreter_departmentkind CASCADE;
DROP TABLE IF EXISTS interpreter_diagnostic CASCADE;
DROP TABLE IF EXISTS interpreter_diagnosticentry CASCADE;
DROP TABLE IF EXISTS interpreter_entry CASCADE;
DROP TABLE IF EXISTS interpreter_entry_professionals_consulted CASCADE;
DROP TABLE IF EXISTS interpreter_entrydepartment CASCADE;
DROP TABLE IF EXISTS interpreter_healthprofessional CASCADE;
DROP TABLE IF EXISTS interpreter_location CASCADE;
DROP TABLE IF EXISTS interpreter_locationkind CASCADE;
DROP TABLE IF EXISTS interpreter_service CASCADE;
DROP TABLE IF EXISTS interpreter_servicekind CASCADE;
DROP TABLE IF EXISTS interpreter_usedservices CASCADE;

\c interpreter;

DELETE FROM django_migrations WHERE app = 'fltp_statistics';
DELETE FROM django_content_type WHERE app_label='fltp_statistics';

DELETE FROM interpreter_locationkind WHERE active=false;
DELETE FROM interpreter_diagnostic WHERE active=false;

DROP TABLE IF EXISTS fltp_statistics_participant CASCADE;
DROP TABLE IF EXISTS fltp_statistics_participantevaluationanswers CASCADE;
DROP TABLE IF EXISTS fltp_statistics_professioncode CASCADE;
DROP TABLE IF EXISTS fltp_statistics_registration CASCADE;
DROP TABLE IF EXISTS fltp_statistics_supervisorevaluationanswers CASCADE;
