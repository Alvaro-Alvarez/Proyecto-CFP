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
    public class Sede
       
    {

        private Entidades.Sede objEntSede=new Entidades.Sede();
        
        public void Agregar(Entidades.Sede p_sede)
        {
            try
            {
                Conexion.conn.Open();
                MySqlCommand sql = new MySqlCommand("AgregarSede", Conexion.conn);
                sql.CommandType = CommandType.StoredProcedure;
                sql.Parameters.AddWithValue("@nom", p_sede.Nombre);
                sql.Parameters.AddWithValue("@dom", p_sede.Domicilio);
                sql.ExecuteNonQuery();
                MessageBox.Show("La Sede Fue Agregada", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
                Conexion.conn.Close();
            }
            catch(Exception e)
            {
                MessageBox.Show("Se fue la Conexion", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

            }


            }
      
        public DataTable TraerTodos()
        {
            
            DataTable dt = new DataTable();
            MySqlDataAdapter r = new MySqlDataAdapter("TraerTodo",Conexion.conn);


            // poblar el datatable dt
            r.Fill(dt);
            Conexion.conn.Close();
            return dt;
        }



        public Entidades.Sede TraerUno(int p_id){
            Conexion.conn.Open();
            MySqlCommand sql = new MySqlCommand("TraerUno", Conexion.conn);
            sql.CommandType = CommandType.StoredProcedure;
            sql.Parameters.AddWithValue("@IdSede", p_id);
            MySqlDataReader r = sql.ExecuteReader();
            if (r.Read())
            {

                objEntSede.Id = Convert.ToInt32(r["id_sede"]);
                objEntSede.Nombre = Convert.ToString(r["nombre_sede"]);
                objEntSede.Domicilio = Convert.ToString(r["domicilio"]);
                objEntSede.Observacion = Convert.ToString(r["observacion"]);

                
            }

            Conexion.conn.Close();
            return objEntSede;


            }

        public void Modificar(Entidades.Sede p_sede){
            Conexion.conn.Open();
            MySqlCommand sql = new MySqlCommand("ActualizarSede",Conexion.conn);
            sql.CommandType = CommandType.StoredProcedure;
            sql.Parameters.AddWithValue("@nom", p_sede.Nombre);
            sql.Parameters.AddWithValue("@dom", p_sede.Domicilio);
            sql.Parameters.AddWithValue("@obs", p_sede.Observacion);
            sql.Parameters.AddWithValue("@IdSede",p_sede.Id);
            sql.ExecuteNonQuery();
            MessageBox.Show("La Sede Fue Modificada", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);


            Conexion.conn.Close();
            }


        public void Eliminar(Entidades.Sede p_sede)
        {
            Conexion.conn.Open();
            MySqlCommand sql = new MySqlCommand("DesactivarSede", Conexion.conn);
            sql.CommandType = CommandType.StoredProcedure;
            
            sql.Parameters.AddWithValue("@IdSede", p_sede.Id);
            sql.ExecuteNonQuery();
            MessageBox.Show("La Sede Fue Eliminada", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);


            Conexion.conn.Close();
        }

















    }




}



    
