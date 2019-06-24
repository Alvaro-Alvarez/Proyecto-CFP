using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Windows.Forms;
using System.Data;


namespace Datos
{
    public class Materia
    {
        
        
              public void Agregar(Entidades.Materia p_materia,Entidades.Curso p_curso)
        {
            try
            {
                Conexion.conn.Open();
                MySqlCommand sql = new MySqlCommand("AgregarMateria", Conexion.conn);
                sql.CommandType = CommandType.StoredProcedure;
                sql.Parameters.AddWithValue("@nom", p_materia.Nombre);
                sql.Parameters.AddWithValue("@obs", p_materia.Observacion);
                sql.Parameters.AddWithValue("@IdCurso",p_curso.Id);
                sql.ExecuteNonQuery();
                MessageBox.Show("La Materia fue agregada", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
                Conexion.conn.Close();


            }
            catch (Exception e)
             {
                 
               
             }
        }
                

              public DataTable TraerTodo(int p_IdCurso,string tabla)
        {
               Conexion.conn.Open();
               DataTable dt = new DataTable();
               MySqlDataAdapter r = new MySqlDataAdapter("TraerTodo",Conexion.conn);
               r.SelectCommand.CommandType = CommandType.StoredProcedure;
               r.SelectCommand.Parameters.Add("@tabla",tabla);//aca ponemos el id del usuario conectado
               r.SelectCommand.Parameters.Add("@IdMcurso",p_IdCurso);

            // poblar el datatable dt
            r.Fill(dt);
            Conexion.conn.Close();
            return dt;
        }


 












        public void Eliminar(int p_Id)
              {
                  Conexion.conn.Open();
                  MySqlCommand sql = new MySqlCommand("Desactivar", Conexion.conn);
                  sql.CommandType = CommandType.StoredProcedure;
                  sql.Parameters.AddWithValue("@Tabla", "materias");
                  sql.Parameters.AddWithValue("@Id", p_Id);
                  sql.ExecuteNonQuery();
                  MessageBox.Show("La Materia Fue Eliminada", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);


                  Conexion.conn.Close();
              }

              public Entidades.Materia TraerUno(int p_id,Entidades.Materia p_Materias)
               {
              Conexion.conn.Open();
              MySqlCommand sql = new MySqlCommand("TraerUno", Conexion.conn);
              sql.CommandType = CommandType.StoredProcedure;
              sql.Parameters.AddWithValue("@Id", p_id);
                 sql.Parameters.AddWithValue("@Tabla", "materias");
                 MySqlDataReader r = sql.ExecuteReader();
               if (r.Read())
              {

                 p_Materias.Id = Convert.ToInt32(r["id_materia"]);
                p_Materias.Nombre = Convert.ToString(r["nombre_materia"]);

                p_Materias.Observacion = Convert.ToString(r["observacion"]);


                  }

                  Conexion.conn.Close();
                 return p_Materias;


        }
        public void Modificar(Entidades.Materia p_Materia)
        {
            Conexion.conn.Open();
            MySqlCommand sqll = new MySqlCommand("ActualizarMateria", Conexion.conn);
            sqll.CommandType = CommandType.StoredProcedure;
            sqll.Parameters.AddWithValue("@IdMateria", p_Materia.Id);
            sqll.Parameters.AddWithValue("@nom", p_Materia.Nombre);
            sqll.Parameters.AddWithValue("@obs", p_Materia.Observacion);
         
            sqll.ExecuteNonQuery();
            Conexion.conn.Close();

        }


    }
    }

