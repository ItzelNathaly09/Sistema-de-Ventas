using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Categoria
    {
        //Esto lo hizo Froy
        private CD_Categoria objcd_Categoria = new CD_Categoria();

        public List<Categoria> Listar()
        {
            return objcd_Categoria.Listar();
        }

        //Esto lo hizo Froy
        public int Registrar(Categoria obj, out string Mensaje)
        {
            Mensaje = string.Empty;
            if (obj.Descripcion == "")
            {
                Mensaje += "Es necesario la descripcion de la Categoria\n";
            }

            if (Mensaje != string.Empty)
            {
                return 0;
            }
            else
            {
                return objcd_Categoria.Registrar(obj, out Mensaje);
            }


        }

        public bool Editar(Categoria obj, out string Mensaje)
        {
            // mas reglas definidas para el metodo Editar by hugod
            Mensaje = string.Empty;
            if (obj.Descripcion == "")
            {
                Mensaje += "Es necesario la descripcion de la Categoria\n";
            }

            if (Mensaje != string.Empty)
            {
                return false;
            }
            else
            {
                return objcd_Categoria.Editar(obj, out Mensaje);
            }

        }

        public bool Eliminar(Categoria obj, out string Mensaje)
        {
            return objcd_Categoria.Eliminar(obj, out Mensaje);
        }
    }
}
