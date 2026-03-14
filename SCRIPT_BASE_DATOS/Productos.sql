select * from PRODUCTO

insert into PRODUCTO (Codigo, Nombre, Descripcion, IdCategoria ) values ('101010','refresco','1litro',4)

select IdProducto,Codigo,Nombre,p.Descripcion,c.IdCategoria,c.Descripcion[DescripcionCategoria],Stock,PrecioCompra,PrecioVenta,p.Estado from PRODUCTO p
INNER JOIN CATEGORIA c ON c.IdCategoria = p.IdCategoria

update PRODUCTO set Estado = 1
--Procedimiento para registrar un producto
--Esto lo hizo Itzel



alter PROC sp_RegistrarProducto(
@Codigo varchar(20),
@Nombre varchar(30),
@Descripcion varchar(30),
@IdCategoria int,
@Estado bit,
@Resultado bit output,
@Mensaje varchar(500) output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM producto WHERE Codigo = @Codigo)
	begin
		insert into producto(Codigo,Nombre,Descripcion,IdCategoria,Estado)values(@Codigo,@Nombre,@Descripcion,@IdCategoria,@Estado)
		set @Resultado = SCOPE_IDENTITY()
	end
	ELSE
	SET @Mensaje = 'Ya existe un producto con el mismo codigo'

end

go
--Esto lo hizo Itzel
--Procedimiento para modificar un producto agregado
alter PROC sp_ModificarProducto(
@IdProducto int,
@Codigo varchar(20),
@Nombre varchar(30),
@Descripcion varchar (30),
@IdCategoria int,
@Estado bit,
@Resultado int output,
@Mensaje varchar(500) output
)
as
begin
	SET @Resultado = 1
	IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE codigo = @Codigo and IdProducto != @IdProducto)

			update PRODUCTO set
			codigo = @Codigo,
			Nombre = @Nombre,
			Descripcion = @Descripcion,
			IdCategoria = @IdCategoria,
			Estado = @Estado
			where IdProducto = @IdProducto
	ELSE
	begin
		SET @Resultado = 0
		SET @Mensaje = 'Ya existe un producto con el mismo codigo'
	end
end
go

--Esto lo hizo Itzel
--Procedimiento para eliminar un producto
alter PROC SP_EliminarProducto(
@IdProducto int,
@Respuesta bit output,
@Mensaje varchar(500) output
)
as
begin
	set @Respuesta=0
	set @Mensaje = ''
	declare @pasoreglas bit =1

	IF EXISTS (SELECT * FROM DETALLE_COMPRA dc
	INNER JOIN PRODUCTO p ON p.IdProducto = dc.IdProducto
	WHERE p.IdProducto = @IdProducto
	)
	BEGIN 
		set @pasoreglas = 0
		set @Respuesta = 0
		set @Mensaje = @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una COMPRA\n'
	END

	IF EXISTS (SELECT * FROM DETALLE_VENTA dv
	INNER JOIN PRODUCTO p ON p.IdProducto = dv.IdProducto
	WHERE p.IdProducto = @IdProducto
	)
	BEGIN
		set @pasoreglas = 0
		set @Respuesta = 0
		set @Mensaje = @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una VENTA\n'
	END

	if (@pasoreglas = 1)
	begin
		delete from PRODUCTO where IdProducto = @IdProducto
		SET @Respuesta = 1
	end
end
go
