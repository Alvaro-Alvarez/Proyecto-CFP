using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Profesor : Persona
    {
        public void Corregido(Entidades.Profesor p_objEntProfesor, int p_IdMateria, int p_IdCurso, int p_IdSede)
        {
            Conexion.conn.Open();

            MySqlCommand sql = new MySqlCommand("Corrigido", Conexion.conn);
            sql.CommandType = CommandType.StoredProcedure;
            sql.Parameters.AddWithValue("@IdPersona", p_objEntProfesor.ID);
            sql.Parameters.AddWithValue("@IdMateria", p_IdMateria);
            sql.Parameters.AddWithValue("@IdCurso", p_IdCurso);
            sql.Parameters.AddWithValue("@IdSede", p_IdSede);
            sql.ExecuteNonQuery();



            Conexion.conn.Close();

        }
        public DataTable MostrarMateriasCorregidas(int p_idsede,int p_idcurso)
        {
            Conexion.conn.Open();
            DataTable dt = new DataTable();
            MySqlDataAdapter r = new MySqlDataAdapter("MostrarCorregido", Conexion.conn);
            r.SelectCommand.CommandType = CommandType.StoredProcedure;
            r.SelectCommand.Parameters.Add("@IdSede", p_idsede);
            r.SelectCommand.Parameters.Add("@IdCurso", p_idcurso);
            


            // poblar el datatable dt
            r.Fill(dt);
            Conexion.conn.Close();
            return dt;

        }
    }
}
