using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Data;
using System.Windows.Forms;

namespace Datos
{
    public class Curso
    {
        private Entidades.Sede objEntSede = new Entidades.Sede();

        public void Agregar(Entidades.Curso p_curso)
        {
            try
            {
                Conexion.conn.Open();
                MySqlCommand sql = new MySqlCommand("AgregarCurso", Conexion.conn);
                sql.CommandType = CommandType.StoredProcedure;
                sql.Parameters.AddWithValue("@nom", p_curso.Nombre);
                sql.Parameters.AddWithValue("@obs", p_curso.Observacion);
                sql.ExecuteNonQuery();
                MessageBox.Show("El Curso fue Agregada", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
                Conexion.conn.Close();
            }
            catch (Exception e)
            {
                MessageBox.Show("Se fue la Conexion", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

            }


        }
    }
}
