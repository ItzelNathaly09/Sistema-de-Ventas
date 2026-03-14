using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaPresentacion
{
    public static class ColorFont
    {
        public static void CambiarColorDeLabels(Control.ControlCollection controles, Color color)
        {
            foreach (Control control in controles)
            {
                // Opción 1: Si el control es una Label
                if (control is Label)
                {
                    control.ForeColor = color;
                }
                // Opción 2: Si es un DataGridView
                else if (control is DataGridView)
                {
                    // Convertimos el 'control' genérico a un 'DataGridView'
                    DataGridView dgv = (DataGridView)control;

                    // 1. Establece el color de fuente para las CELDAS
                    dgv.DefaultCellStyle.ForeColor = color;

                    // 2. Establece el color de fuente para las CABECERAS (Columnas)
                    dgv.ColumnHeadersDefaultCellStyle.ForeColor = color;

                    // 3. (Recomendado) Establece el color para la cabecera de la fila
                    dgv.RowHeadersDefaultCellStyle.ForeColor = color;
                }

                // Parte Recursiva: Busca controles dentro de otros (como Paneles)
                if (control.HasChildren)
                {
                    CambiarColorDeLabels(control.Controls, color);
                }
            }
        }
    }
}
