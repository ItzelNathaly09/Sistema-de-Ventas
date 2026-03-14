

select * from USUARIO



go


CREATE OR ALTER PROC SP_EDITARUSUARIO(
@IdUsuario int,
@Documento varchar(50),
@NombreCompleto varchar(100),
@Correo varchar(100),
@Clave varchar(100),
@IdRol int,
@Estado bit,
@Respuesta bit output,
@Mensaje varchar(500) output
)
as
begin
	set @Respuesta = 0
	set @Mensaje = ''

	if not exists(select * from USUARIO where Documento = @Documento and idusuario != @IdUsuario)
	begin
		update usuario set
		Documento=@Documento,
		NombreCompleto = @NombreCompleto,
		Correo =@Correo,
		Clave =@Clave,
		IdRol =@IdRol,
		Estado = @Estado
		where IdUsuario = @IdUsuario

		set @Respuesta = 1
		
	end
	else
		set @Mensaje = 'No se puede repetir el documento para más de un usuario'

end



declare @respuesta bit
declare @mensaje varchar(500)

exec SP_EDITARUSUARIO 3, '123','pruebas 2','test@gmail.com','456',2,1,@respuesta output, @mensaje output
select @respuesta 
select @mensaje



select * from USUARIO
