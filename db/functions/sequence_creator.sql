CREATE SEQUENCE admins_id_seq;
ALTER TABLE public.admins
    ALTER COLUMN id SET DEFAULT nextval('admins_id_seq');
ALTER SEQUENCE admins_id_seq OWNED BY public.admins.id;

CREATE SEQUENCE users_id_seq;
ALTER TABLE public.users
    ALTER COLUMN id SET DEFAULT nextval('users_id_seq');
ALTER SEQUENCE users_id_seq OWNED BY public.users.id;

CREATE SEQUENCE emergency_services_id_seq;
ALTER TABLE public.emergency_services
    ALTER COLUMN id SET DEFAULT nextval('emergency_services_id_seq');
ALTER SEQUENCE emergency_services_id_seq OWNED BY public.emergency_services.id;