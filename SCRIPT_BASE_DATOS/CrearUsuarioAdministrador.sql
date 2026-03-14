ALTER DATABASE DBSISTEMA_VENTA SET READ_ONLY WITH ROLLBACK IMMEDIATE;

ALTER DATABASE DBSISTEMA_VENTA SET READ_WRITE;

SELECT name,
is_read_only
FROM sys.databases
WHERE name = 'DBSISTEMA_VENTA';

select * from usuario

select * from DETALLE_COMPRA

select * from rol

select * from PERMISO

select p.IdRol,p.NombreMenu from PERMISO p
inner join ROL r on r.IdRol = p.IdRol
inner join USUARIO u on u.IdRol = r.IdRol
where u.IdUsuario = 2

select u.Idusuario, u.Documento, u.NombreCompleto, u.Correo, u.Clave, u.Estado, r.IdRol, r.Descripcion from usuario u
inner join rol r on r.IdRol = u.IdRol

update usuario set estado = 0 where idusuario = 2

insert into USUARIO(Documento, NombreCompleto,Correo,Clave,IdRol,Estado)
values
('20', 'EMPLEADO', '@GMAIL.COM', '456', 2, 1)

select * from rol

insert into rol (Descripcion)
values('ADMINISTRADOR')

insert into rol (Descripcion)
values('EMPLEADO')

insert into USUARIO(Documento, NombreCompleto,Correo,Clave,IdRol,Estado)
values

('101010', 'ADMIN', '@GMAIL.COM', '123', 1, 1)

DELETE FROM Usuario;

DBCC CHECKIDENT ('Usuario', RESEED, 3);

--DBCC CHECKIDENT ('PERMISO', RESEED, 0);

--delete from PERMISO;


delete from PERMISO
where IdRol = 1;

insert into PERMISO(IdRol,NombreMenu) values
(1,'menuusuarios'),
(1,'menumantenedor'),
(1,'menuventas'),
(1,'menucompras'),
(1,'menuclientes'),
(1,'menuproveedores'),
(1,'menureportes'),
(1,'menuacercade')

insert into PERMISO(IdRol,NombreMenu) values
(2,'menuventas'),
(2,'menucompras'),
(2,'menuclientes'),
(2,'menuproveedores'),
(2,'menuacercade')

--delete from Rol where IdRol = 4;
---- Cambiar los permisos del empleado al nuevo IdRol (2)
--update PERMISO set IdRol = 2 where IdRol = 4;

---- Cambiar los usuarios del empleado al nuevo IdRol (2)
--update USUARIO set IdRol = 2 where IdRol = 4;

---- Ahora actualizamos el IdRol en la tabla Rol
--update Rol set IdRol = 2 where IdRol = 4;

---- Reiniciar el contador ROL
--DBCC CHECKIDENT ('Rol', RESEED, 1);

