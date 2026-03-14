/* Comandos de visualizacion */
select IdCliente,Documento,NombreCompleto,Correo,Telefono,Estado from CLIENTE


/* Procedimientos */
--Procedimiento para guardar una categoria
create PROC SP_RegistrarCliente(
@Documento varchar(50),
@NombreCompleto varchar(50),
@Correo varchar(50),
@Telefono varchar(50),
@Estado bit,
@Resultado int output,
@Mensaje varchar(500) output
)as
begin
	SET @Resultado = 0
	DECLARE @IDPERSONA INT
	IF NOT EXISTS (SELECT * FROM CLIENTE WHERE Documento = @Documento)
	begin
		insert into CLIENTE(Documento, NombreCompleto,Correo,Telefono,Estado) values (@Documento,@NombreCompleto, @Correo,@Telefono,@Estado)
		set @Resultado = SCOPE_IDENTITY()
	end
	ELSE
		set @Mensaje = 'EL numero de usuario ya existe'
end

go




--Procedimiento para editar una categoria
Create PROC SP_ModificarCliente(
@IdCliente int,
@Documento varchar(50),
@NombreCompleto varchar(50),
@Correo varchar(50),
@Telefono varchar(50),
@Estado bit, 
@Resultado int output,
@Mensaje varchar(500) output
)as
begin
	SET @Resultado = 1
	DECLARE @IDPERSONA INT
	IF NOT EXISTS (SELECT * FROM CLIENTE WHERE Documento = @Documento and IdCliente != @IdCliente)
	begin
		update CLIENTE set
		Documento = @Documento,
		NombreCompleto = @NombreCompleto,
		Correo = @NombreCompleto,
		Telefono = @Telefono,
		Estado = @Estado
		where IdCliente = @IdCliente
	end
	ELSE
	begin
		set @Resultado = 0
		set @Mensaje = 'El numero de usuario ya existe'
	end
end
