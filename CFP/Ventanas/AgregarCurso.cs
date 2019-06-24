using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Ventanas
{
    public partial class AgregarCurso : Form
    {
        public AgregarCurso()
        {
            InitializeComponent();
        }
        private List<string> LSedeSeleccionado = new List<string>();
        private Entidades.Curso objEntCurso = new Entidades.Curso();
        private Datos.Curso objDatosCurso = new Datos.Curso();
        private Datos.Sede objDatosSede = new Datos.Sede();
        private void MostrarSedes(){
            clbSede.DataSource = objDatosSede.TraerTodos();
            // campo/alias a  mostrar
            clbSede.DisplayMember = "nombre_sede";
            
            // campo/alias a guardar
            clbSede.ValueMember = "id_sede";

            
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {


            

            MessageBox.Show(Convert.ToString(clbSede.CheckedIndices[0]));

            /*
            if(txtNombre.TextLength>0)
            {
                objEntCurso.Nombre = txtNombre.Text;
                objEntCurso.Observacion = txtobservacion.Text;
                objDatosCurso.Agregar(objEntCurso);


            }
            else
            {

                MessageBox.Show("Llene todos los campos");
            }
            */
        }

        private void AgregarCurso_Load(object sender, EventArgs e)
        {
            LSedeSeleccionado.Clear();
            MostrarSedes();
           
        }

        private void clbSede_SelectedIndexChanged(object sender, EventArgs e)
        {
            

        }

        private void clbSede_ItemCheck(object sender, ItemCheckEventArgs e)
        {
            
           MessageBox.Show(clbSede.SelectedValue.ToString());
            
            
            LSedeSeleccionado.RemoveAt(clbSede.SelectedValue);
            LSedeSeleccionado.Add(clbSede.SelectedValue.ToString());

        }
    }
}
