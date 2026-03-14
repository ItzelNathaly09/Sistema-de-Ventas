/* Categorias */
select IdCategoria,Descripcion,Estado from CATEGORIA

select * from CATEGORIA

--DELETE FROM CATEGORIA;

DBCC CHECKIDENT ('CATEGORIA', RESEED, 0);

Insert  into CATEGORIA(Descripcion,Estado) Values('Lacteos',1)
Insert  into CATEGORIA(Descripcion,Estado) Values('Embutidos',1)
Insert  into CATEGORIA(Descripcion,Estado) Values('Enlatados',1)

--Esto lo hizo Itzel
Update CATEGORIA set Estado = 1

/* Procedimientos */
--Procedimiento para guardar una categoria
create PROC SP_RegistrarCategoria(
@Descripcion varchar(50),
@Estado int,
@Resultado int output,
@Mensaje varchar(500) output
)as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
	begin
		insert into CATEGORIA(Descripcion, Estado) values (@Descripcion,@Estado)
		set @Resultado = SCOPE_IDENTITY()
	end
	ELSE
		set @Mensaje = 'No se puede repetir la descripcion de una categoria'
end

go




--Procedimiento para editar una categoria
Create PROC SP_EditarCategoria(
@IdCategoria int,
@Descripcion varchar(50),
@Estado int,
@Resultado bit output,
@Mensaje varchar(500) output
)as
begin
	SET @Resultado = 1
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion and IdCategoria != @IdCategoria)
		update CATEGORIA set
		Descripcion = @Descripcion,
		Estado = @Estado
		where IdCategoria = @IdCategoria
	ELSE
	begin
		set @Resultado = 0
		set @Mensaje = 'No se puede repetir la descripcion de una categoria'
	end
end

go

--Procedimiento para eliminar una categoria
CREATE PROC SP_EliminarCategoria(
@IdCategoria int,
@Estado int,
@Resultado bit output,
@Mensaje varchar(500) output
)as
begin
	SET @Resultado = 1
	IF NOT EXISTS (
		select * from CATEGORIA c
		inner join PRODUCTO p on p.IdCategoria = c.IdCategoria
		where c.IdCategoria = @IdCategoria
	)
	begin
		delete top(1) from CATEGORIA where IdCategoria = @IdCategoria
	end
	ELSE
	begin
		set @Resultado = 0
		set @Mensaje = 'La categoria se encuentra relacionada a un producto'
	end
end

go
--Comprobar que se guarden los productos en la base de datos by Hugo


