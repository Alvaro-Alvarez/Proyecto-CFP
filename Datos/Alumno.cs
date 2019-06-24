using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Alumno : Persona
    {


        public void AMNota(Entidades.Alumno p_objEntAlumno, int p_IdMateria, int p_IdCurso, int p_IdSede) {


         
                Conexion.conn.Open();

                MySqlCommand sql = new MySqlCommand("AgregarNota", Conexion.conn);
                sql.CommandType = CommandType.StoredProcedure;
                sql.Parameters.AddWithValue("@IdPersona", p_objEntAlumno.ID);
                sql.Parameters.AddWithValue("@IdMateria", p_IdMateria);
                sql.Parameters.AddWithValue("@IdCurso", p_IdCurso);
                sql.Parameters.AddWithValue("@IdSede", p_IdSede);
                sql.Parameters.AddWithValue("@anota", p_objEntAlumno.Nota);
                sql.ExecuteNonQuery();



                Conexion.conn.Close();
            
       




          }
             public string TraerUnaNota(Entidades.Alumno p_objEntAlumno, int p_IdMateria, int p_IdCurso, int p_IdSede)
             {

            string valor;
            Conexion.conn.Open();
            MySqlCommand sql = new MySqlCommand("TraerUnaNota", Conexion.conn);
            sql.CommandType = CommandType.StoredProcedure;
            sql.Parameters.AddWithValue("@IdPersona", p_objEntAlumno.ID);
            sql.Parameters.AddWithValue("@IdMateria", p_IdMateria);
            sql.Parameters.AddWithValue("@IdCurso", p_IdCurso);
            sql.Parameters.AddWithValue("@IdSede", p_IdSede);
            MySqlDataReader r = sql.ExecuteReader();
           
            if (r.Read())
            {

                
                valor=Convert.ToString(r["nota"]);
                


            }
            else
            {
                
                valor= "-";
            }
            Conexion.conn.Close();
            return valor;
            


        




          
        }














    }
}
