-- Table: public.my_dr_input

-- DROP TABLE IF EXISTS public.my_dr_input;

CREATE TABLE IF NOT EXISTS public.my_dr_input
(
    producttype character varying(20) COLLATE pg_catalog."default",
    period character varying(20) COLLATE pg_catalog."default",
    promocode character varying(20) COLLATE pg_catalog."default",
    "row" integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.my_dr_input
    OWNER to postgres;