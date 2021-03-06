BEGIN;
--
-- Create model User
--
CREATE TABLE "users_user" ("id" bigserial NOT NULL PRIMARY KEY, "password" varchar(128) NOT NULL, "last_login" timestamp with time zone NULL, "employee_number" varchar(4) NOT NULL UNIQUE, "name" varchar(100) NULL, "role" varchar(10) NOT NULL, "is_active" boolean NOT NULL, "is_staff" boolean NOT NULL, "is_superuser" boolean NOT NULL);
CREATE TABLE "users_user_groups" ("id" bigserial NOT NULL PRIMARY KEY, "user_id" bigint NOT NULL, "group_id" integer NOT NULL);
CREATE TABLE "users_user_user_permissions" ("id" bigserial NOT NULL PRIMARY KEY, "user_id" bigint NOT NULL, "permission_id" integer NOT NULL);
CREATE INDEX "users_user_employee_number_9649c248_like" ON "users_user" ("employee_number" varchar_pattern_ops);
ALTER TABLE "users_user_groups" ADD CONSTRAINT "users_user_groups_user_id_group_id_b88eab82_uniq" UNIQUE ("user_id", "group_id");
ALTER TABLE "users_user_groups" ADD CONSTRAINT "users_user_groups_user_id_5f6f5a90_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "users_user_groups" ADD CONSTRAINT "users_user_groups_group_id_9afc8d0e_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "users_user_groups_user_id_5f6f5a90" ON "users_user_groups" ("user_id");
CREATE INDEX "users_user_groups_group_id_9afc8d0e" ON "users_user_groups" ("group_id");
ALTER TABLE "users_user_user_permissions" ADD CONSTRAINT "users_user_user_permissions_user_id_permission_id_43338c45_uniq" UNIQUE ("user_id", "permission_id");
ALTER TABLE "users_user_user_permissions" ADD CONSTRAINT "users_user_user_permissions_user_id_20aca447_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "users_user_user_permissions" ADD CONSTRAINT "users_user_user_perm_permission_id_0b93982e_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "users_user_user_permissions_user_id_20aca447" ON "users_user_user_permissions" ("user_id");
CREATE INDEX "users_user_user_permissions_permission_id_0b93982e" ON "users_user_user_permissions" ("permission_id");
COMMIT;
BEGIN;
--
-- Create model Table
--
CREATE TABLE "restaurant_table" ("id" bigserial NOT NULL PRIMARY KEY, "number" integer NOT NULL UNIQUE, "num_of_seats" integer NOT NULL);
--
-- Create model Reservation
--
CREATE TABLE "restaurant_reservation" ("id" bigserial NOT NULL PRIMARY KEY, "start_time" timestamp with time zone NOT NULL, "end_time" timestamp with time zone NOT NULL, "table_id" bigint NOT NULL);
ALTER TABLE "restaurant_reservation" ADD CONSTRAINT "restaurant_reservation_table_id_0c19b7a0_fk_restaurant_table_id" FOREIGN KEY ("table_id") REFERENCES "restaurant_table" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "restaurant_reservation_table_id_0c19b7a0" ON "restaurant_reservation" ("table_id");
COMMIT;
