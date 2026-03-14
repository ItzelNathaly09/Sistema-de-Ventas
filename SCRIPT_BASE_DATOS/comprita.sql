select * from COMPRA where NumeroDocumento = '00001'
select * from DETALLE_COMPRA where IdCompra = 1

select c.IdCompra,
u.NombreCompleto,
pr.Documento,pr.RazonSocial,
c.TipoDocumento,c.NumeroDocumento,c.MontoTotal,convert(char(10),c.FechaRegistro,103)[FechaRegistro]
from COMPRA c
inner join USUARIO u on u.IdUsuario = c.IdUsuario
inner join PROVEEDOR pr on pr.IdProveedor = c.IdProveedor
where c.NumeroDocumento = '00001'

select p.Nombre,dc.PrecioCompra,dc.Cantidad,dc.MontoTotal
from DETALLE_COMPRA dc
inner join PRODUCTO p on p.IdProducto = dc.IdProducto
where dc.IdCompra = 1

/* Procesos para registrar una compra By Hugo*/
DROP TYPE IF EXISTS dbo.EDetalle_compra;
GO

CREATE TYPE [dbo].[EDetalle_compra] AS TABLE (
	[IdProducto] int NULL,
	[PrecioCompra] decimal (18,2) null,
	[PrecioVenta] decimal (18,2) null,
	[Cantidad] int null,
	[MontoTotal] decimal (18,2) null
)

GO

create procedure sp_RegistrarCompra(
@IdUsuario int,
@IdProveedor int,
@TipoDocumento varchar(500),
@NumeroDocumento varchar(500),
@MontoTotal decimal (18,2),
@DetalleCompra [EDetalle_Compra] readonly,
@Resultado bit output,
@Mensaje varchar(500) output
)

as
begin
	begin try
		declare @idcompra int = 0
		set @Resultado =1
		set @Mensaje = ''

		begin transaction registro
			
		insert into COMPRA (IdUsuario, IdProveedor, TipoDocumento, NumeroDocumento, MontoTotal)
		values (@IdUsuario,@IdProveedor, @TipoDocumento, @NumeroDocumento, @MontoTotal)


		set @idcompra = SCOPE_IDENTITY()

		insert into DETALLE_COMPRA (IdCompra, IdProducto, PrecioCompra, PrecioVenta, Cantidad, MontoTotal)
		select @idcompra,IdProducto, PrecioCompra, PrecioVenta, Cantidad, MontoTotal from @DetalleCompra

		/*update PRODUCTO set Stock = 1 where IdProducto = 1*/

		Update pet set p.Stock = p.Stock + dc.Cantidad,
		p.PrecioCompra = dc.PrecioCompra,
		p.PrecioVenta = dc.PrecioVenta
		from PRODUCTO p
		inner join @DetalleCompra dc on dc.IdProducto= p.IdProducto 

		commit transaction registro


	end try
	begin catch
		set @Resultado = 0
		set @Mensaje = ERROR_MESSAGE()
		rollback transaction registro
	end catch


end



/* Procesos para registrar una compra By Hugo*/
DROP PROCEDURE IF EXISTS sp_RegistrarCompra;
GO
DROP TYPE IF EXISTS dbo.EDetalle_compra;
GO



CREATE TYPE [dbo].[EDetalle_compra] AS TABLE (
	[IdProducto] int NULL,
	[PrecioCompra] decimal (18,2) null,
	[PrecioVenta] decimal (18,2) null,
	[Cantidad] int null,
	[MontoTotal] decimal (18,2) null
)

GO

create procedure sp_RegistrarCompra(
@IdUsuario int,
@IdProveedor int,
@TipoDocumento varchar(500),
@NumeroDocumento varchar(500),
@MontoTotal decimal (18,2),
@DetalleCompra [EDetalle_Compra] readonly,
@Resultado bit output,
@Mensaje varchar(500) output
)

as
begin
	begin try
			declare @idcompra int = 0
			set @Resultado =1
			set @Mensaje = ''

			begin transaction registro
			
			insert into COMPRA (IdUsuario, IdProveedor, TipoDocumento, NumeroDocumento, MontoTotal)
			values (@IdUsuario,@IdProveedor, @TipoDocumento, @NumeroDocumento, @MontoTotal)


			set @idcompra = SCOPE_IDENTITY()

			insert into DETALLE_COMPRA (IdCompra, IdProducto, PrecioCompra, PrecioVenta, Cantidad, MontoTotal)
			select @idcompra,IdProducto, PrecioCompra, PrecioVenta, Cantidad, MontoTotal from @DetalleCompra

			update PRODUCTO set Stock = 1 where IdProducto = 1

			UPDATE p
				SET p.Stock = p.Stock + dc.Cantidad,
				p.PrecioCompra = dc.PrecioCompra,
				p.PrecioVenta = dc.PrecioVenta
				FROM PRODUCTO p
				INNER JOIN @DetalleCompra dc ON p.IdProducto = dc.IdProducto;


			commit transaction registro


		end try
		begin catch
			set @Resultado = 0
			set @Mensaje = ERROR_MESSAGE()
			rollback transaction registro
		end catch


	end