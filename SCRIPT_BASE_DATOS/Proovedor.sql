-- Proveedores
--Procedimientos proveedores
create PROC SP_RegistrarProveedor(
@Documento varchar(50),
@RazonSocial varchar(50),
@Correo varchar(50),
@Telefono varchar(50),
@Estado bit,
@Resultado int output,
@Mensaje varchar(500) output
)as
begin
	SET @Resultado = 0
	DECLARE @IDPERSONA INT
	IF NOT EXISTS (SELECT * FROM PROVEEDOR WHERE Documento = @Documento)
	begin
		insert into PROVEEDOR(Documento,RazonSocial,Correo,Telefono,Estado) values (
		@Documento,@RazonSocial,@Correo,@Telefono,@Estado)

		set @Resultado = SCOPE_IDENTITY()
	end
	ELSE
		set @Mensaje = 'El numero de proveedor ya existe'
end

go

alter PROC sp_ModificarProveedor(
@IdProveedor int,
@Documento varchar(50),
@RazonSocial varchar(50),
@Correo varchar(50),
@Telefono varchar(50),
@Estado bit,
@Resultado bit output,
@Mensaje varchar(500) output
)
as
begin
	SET @Resultado = 1
	Declare @IDPERSONA int
	IF NOT EXISTS (SELECT * FROM PROVEEDOR WHERE Documento = @Documento and IdProveedor != @IdProveedor)
	begin
			update PROVEEDOR set
			Documento = @Documento,
			RazonSocial = @RazonSocial,
			Correo = @Correo,
			Telefono = @Telefono,
			Estado = @Estado
			where IdProveedor = @IdProveedor
	end
	ELSE
	begin
		SET @Resultado = 0
		SET @Mensaje = 'El número de documenento ya existe'
	end
end

go 

create PROC sp_EliminarProveedor(
@IdProveedor int,
@Resultado bit output,
@Mensaje varchar(500) output
)
as
begin
	SET @Resultado = 1
	IF NOT EXISTS (
		select * from PROVEEDOR p
		inner join COMPRA c on p.IdProveedor = c.IdProveedor
		where p.IdProveedor = @IdProveedor
	)
	begin
		delete top(1) from PROVEEDOR where IdProveedor = @IdProveedor
	end
	else
	begin
		set @Resultado = 0
		set @Mensaje = 'El proveedor se encuentra relacionado a una compra'
	end
end

--Comandos para ver/modificar las tablas
select IdProveedor, Documento, RazonSocial, Correo, Telefono, Estado from PROVEEDOR





