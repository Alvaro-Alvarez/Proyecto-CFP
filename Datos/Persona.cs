using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Datos
{
   public class Persona
    {


        public void Agregar(Entidades.Persona p_persona,string p_tipo,int p_idsede,int p_idcurso)
        {
           try
             
            {
                Conexion.conn.Open();
                MySqlCommand sql = new MySqlCommand("AgregarPersonas", Conexion.conn);
                sql.CommandType = CommandType.StoredProcedure;
                sql.Parameters.AddWithValue("@nom", p_persona.Nombre);
                sql.Parameters.AddWithValue("@ape", p_persona.Apellido);
                sql.Parameters.AddWithValue("@dn", p_persona.Dni);
                sql.Parameters.AddWithValue("@sex", p_persona.Sexo);
                sql.Parameters.AddWithValue("@tel", p_persona.telefono);
                sql.Parameters.AddWithValue("@dom", p_persona.Domicilio);
                sql.Parameters.AddWithValue("@cor", p_persona.Correo);
                sql.Parameters.AddWithValue("@fecha", p_persona.Fechadenac);
                sql.Parameters.AddWithValue("@loc", p_persona.Localidad);
                sql.Parameters.AddWithValue("@tipo",p_tipo);
                sql.Parameters.AddWithValue("@IdSede",p_idsede);
                sql.Parameters.AddWithValue("@IdCurso", p_idcurso);

                sql.ExecuteNonQuery();
                MessageBox.Show("El alumno se ha agregado", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
                Conexion.conn.Close();
            }
            catch (Exception e)
            {
                MessageBox.Show("Error: "+e, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
               

            }
        


        }

        public void Modificar(Entidades.Persona p_persona, int p_idsede, int p_idcurso)
        {
            try
             
            {
                Conexion.conn.Open();
                MySqlCommand sql = new MySqlCommand("ActualizarPersona", Conexion.conn);
                sql.CommandType = CommandType.StoredProcedure;
                sql.Parameters.AddWithValue("@IdPersona", p_persona.ID);
                sql.Parameters.AddWithValue("@nom", p_persona.Nombre);
                sql.Parameters.AddWithValue("@ape", p_persona.Apellido);
                sql.Parameters.AddWithValue("@dn", p_persona.Dni);
                sql.Parameters.AddWithValue("@sex", p_persona.Sexo);
                sql.Parameters.AddWithValue("@tel", p_persona.telefono);
                sql.Parameters.AddWithValue("@dom", p_persona.Domicilio);
                sql.Parameters.AddWithValue("@cor", p_persona.Correo);
                sql.Parameters.AddWithValue("@fecha", p_persona.Fechadenac);
                sql.Parameters.AddWithValue("@loc", p_persona.Localidad);
                
               
                

                sql.ExecuteNonQuery();
                MessageBox.Show("El alumno se ha Modificado", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
                Conexion.conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Se fue la Conexion ", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

            }
            


        }
        public void Eliminar(int p_Id,int p_id_sede,int p_id_curso)
        {
            Conexion.conn.Open();
            MySqlCommand sql = new MySqlCommand("DesactivarPersona", Conexion.conn);
            sql.CommandType = CommandType.StoredProcedure;

            sql.Parameters.AddWithValue("@Id", p_Id);
            sql.Parameters.AddWithValue("@IdSede",p_id_sede);
            sql.Parameters.AddWithValue("@IdCurso", p_id_curso);
            sql.ExecuteNonQuery();
            MessageBox.Show("La El Alumno Fue Eliminada", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);


            Conexion.conn.Close();
        }









        public DataTable TraerTodos(int p_idcurso, int p_idsede,string p_tipo)
        {
            Conexion.conn.Open();
            DataTable dt = new DataTable();
            MySqlDataAdapter r = new MySqlDataAdapter("TraerPersona", Conexion.conn);
            r.SelectCommand.CommandType = CommandType.StoredProcedure;
            r.SelectCommand.Parameters.Add("@IdCurso", p_idcurso);//aca ponemos el id del usuario conectado
            r.SelectCommand.Parameters.Add("@IdSede", p_idsede);
            r.SelectCommand.Parameters.Add("@Tpersona",p_tipo);


            // poblar el datatable dt
            r.Fill(dt);
            Conexion.conn.Close();
            return dt;

        }

        public DataTable MostrarNotas(int p_idcurso, int p_idsede,int p_idmateria)
        {


            Conexion.conn.Open();
            DataTable dt = new DataTable();
            MySqlDataAdapter r = new MySqlDataAdapter("MostrarNotas", Conexion.conn);
            r.SelectCommand.CommandType = CommandType.StoredProcedure;
            r.SelectCommand.Parameters.Add("@IdCurso", p_idcurso);//aca ponemos el id del usuario conectado
            r.SelectCommand.Parameters.Add("@IdSede", p_idsede);
            r.SelectCommand.Parameters.Add("@IdMAteria",p_idmateria);


            // poblar el datatable dt
            r.Fill(dt);
            Conexion.conn.Close();
            return dt;














        }
    }
}
