using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    //Esto lo hizo Itzel
    public class CN_Compra
    {
        private CD_Compra objcd_compra = new CD_Compra();

        public int ObtenerCorrelativo()
        {
            return objcd_compra.ObtenerCorrelativo();
        }

        public bool Registrar(Compra obj, DataTable DetalleCompra,out string Mensaje)
        {

            return objcd_compra.Registrar(obj, DetalleCompra, out Mensaje);
        }
        public Compra ObtenerCompra(string NumeroDocumento)
        {
            Compra oCompra = objcd_compra.ObtenerCompra(NumeroDocumento);

            if (oCompra.IdCompra != 0)
            {
                List<Detalle_Compra> oListaDetalle = objcd_compra.ObtenerDetalleCompra(oCompra.IdCompra);

                oCompra.oDetalleCompra = oListaDetalle;
            }
            return oCompra;
        }

    }
}
