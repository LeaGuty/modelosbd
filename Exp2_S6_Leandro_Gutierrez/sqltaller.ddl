-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-09-16 22:58:26 CLST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cliente (
    rut_cliente                       VARCHAR2(11) NOT NULL,
    nombres_cliente                   VARCHAR2(255 BYTE) NOT NULL,
    apellidos_cliente                 VARCHAR2(255 BYTE) NOT NULL,
    direccion_region_cliente          VARCHAR2(255 BYTE) NOT NULL,
    direccion_ciudad_cliente          VARCHAR2(255 BYTE) NOT NULL,
    direccion_comuna_cliente          VARCHAR2(255 BYTE) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    direccion_callenumeracion_cliente VARCHAR2(255) NOT NULL,
    email_cliente                     VARCHAR2(255) NOT NULL,
    telefono_cliente                  VARCHAR2(20) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( rut_cliente );

CREATE TABLE orden (
    id_orden            INTEGER NOT NULL,
    fecha_orden         DATE NOT NULL,
    facturado           RAW(2000) NOT NULL,
    observacion         VARCHAR2(1000),
    vehiculo_patente    VARCHAR2(6) NOT NULL,
    cliente_rut_cliente VARCHAR2(11) NOT NULL
);

ALTER TABLE orden ADD CONSTRAINT orden_pk PRIMARY KEY ( id_orden );

CREATE TABLE orden_servicio (
    orden_id_orden       INTEGER NOT NULL,
    servicio_id_servicio INTEGER NOT NULL
);

CREATE TABLE repuesto (
    id_repuesto          INTEGER NOT NULL,
    nombre_respuesto     VARCHAR2(255 BYTE) NOT NULL,
    descripcion_repuesto VARCHAR2(1000) NOT NULL,
    valor_repuesto       INTERVAL DAY(0) TO SECOND(30) NOT NULL
);

ALTER TABLE repuesto ADD CONSTRAINT repuesto_pk PRIMARY KEY ( id_repuesto );

CREATE TABLE seguimiento (
    datetime_estado      DATE NOT NULL,
    servicio_id_servicio INTEGER NOT NULL,
    estado               VARCHAR2(50) NOT NULL,
    observacion          VARCHAR2(1000)
);

ALTER TABLE seguimiento ADD CONSTRAINT seguimiento_pk PRIMARY KEY ( datetime_estado,
                                                                    servicio_id_servicio );

CREATE TABLE servicio (
    id_servicio      INTEGER NOT NULL,
    servivio         VARCHAR2(255 BYTE) NOT NULL,
    valor_manodeobra NUMBER NOT NULL,
    estado_servicio  VARCHAR2(100 BYTE) NOT NULL
);

ALTER TABLE servicio ADD CONSTRAINT servicio_pk PRIMARY KEY ( id_servicio );

CREATE TABLE servicio_repuesto (
    servicio_id_servicio INTEGER NOT NULL,
    cantidad             INTEGER NOT NULL,
    repuesto_id_repuesto INTEGER NOT NULL
);

CREATE UNIQUE INDEX servicio_repuesto__idx ON
    servicio_repuesto (
        repuesto_id_repuesto
    ASC );

CREATE TABLE vehiculo (
    patente                          VARCHAR2(6) NOT NULL,
    color                            VARCHAR2(50) NOT NULL,
    anio                             INTEGER NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    vehiculo_clase_id_vehiculo_clase INTEGER NOT NULL
);

ALTER TABLE vehiculo ADD CONSTRAINT vehiculo_pk PRIMARY KEY ( patente );

CREATE TABLE vehiculo_clase (
    id_vehiculo_clase INTEGER NOT NULL,
    marca             VARCHAR2(50) NOT NULL,
    modelo            VARCHAR2(100) NOT NULL,
    tipo              VARCHAR2(255) NOT NULL
);

ALTER TABLE vehiculo_clase ADD CONSTRAINT vehiculo_clase_pk PRIMARY KEY ( id_vehiculo_clase );

CREATE TABLE vehiculo_repuesto (
    repuesto_id_repuesto             INTEGER NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    vehiculo_clase_id_vehiculo_clase INTEGER NOT NULL
);

ALTER TABLE orden
    ADD CONSTRAINT orden_cliente_fk FOREIGN KEY ( cliente_rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE orden_servicio
    ADD CONSTRAINT orden_servicio_orden_fk FOREIGN KEY ( orden_id_orden )
        REFERENCES orden ( id_orden );

ALTER TABLE orden_servicio
    ADD CONSTRAINT orden_servicio_servicio_fk FOREIGN KEY ( servicio_id_servicio )
        REFERENCES servicio ( id_servicio );

ALTER TABLE orden
    ADD CONSTRAINT orden_vehiculo_fk FOREIGN KEY ( vehiculo_patente )
        REFERENCES vehiculo ( patente );

-- Error - Foreign Key REPUESTO_SERVICIO_REPUESTO_FK has no columns

ALTER TABLE seguimiento
    ADD CONSTRAINT seguimiento_servicio_fk FOREIGN KEY ( servicio_id_servicio )
        REFERENCES servicio ( id_servicio );

ALTER TABLE servicio_repuesto
    ADD CONSTRAINT servicio_repuesto_repuesto_fk FOREIGN KEY ( repuesto_id_repuesto )
        REFERENCES repuesto ( id_repuesto );

ALTER TABLE servicio_repuesto
    ADD CONSTRAINT servicio_repuesto_servicio_fk FOREIGN KEY ( servicio_id_servicio )
        REFERENCES servicio ( id_servicio );

ALTER TABLE vehiculo_repuesto
    ADD CONSTRAINT vehiculo_repuesto_repuesto_fk FOREIGN KEY ( repuesto_id_repuesto )
        REFERENCES repuesto ( id_repuesto );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE vehiculo_repuesto
    ADD CONSTRAINT vehiculo_repuesto_vehiculo_clase_fk FOREIGN KEY ( vehiculo_clase_id_vehiculo_clase )
        REFERENCES vehiculo_clase ( id_vehiculo_clase );

ALTER TABLE vehiculo
    ADD CONSTRAINT vehiculo_vehiculo_clase_fk FOREIGN KEY ( vehiculo_clase_id_vehiculo_clase )
        REFERENCES vehiculo_clase ( id_vehiculo_clase );

CREATE OR REPLACE TRIGGER fkntm_orden BEFORE
    UPDATE OF cliente_rut_cliente, vehiculo_patente ON orden
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table ORDEN is violated');
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             1
-- ALTER TABLE                             17
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   5
-- WARNINGS                                 0
