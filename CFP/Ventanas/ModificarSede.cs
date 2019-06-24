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
    public partial class ModificarSede : Form
    {
        private Datos.Sede objDatosSede = new Datos.Sede();
        private Entidades.Sede objEntSede = new Entidades.Sede();
        
        public ModificarSede()
        {
            InitializeComponent();
        }
        private void TraerSede(){
        // enlazo al comboBox
        cboIdSede.DataSource = objDatosSede.TraerTodos();
            // campo/alias a  mostrar
            cboIdSede.DisplayMember = "nombre_sede";
            // campo/alias a guardar
            cboIdSede.ValueMember = "id_sede";
            this.cboIdSede.SelectedIndexChanged += new System.EventHandler(this.cboIdSede_SelectedIndexChanged);

        }
        private void btnAgregar_Click(object sender, EventArgs e)
        {
            
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            objEntSede.Nombre=txtNombre.Text;
            objEntSede.Domicilio = txtDomicilio.Text;
            objEntSede.Observacion = txtObservacion.Text;


            objDatosSede.Modificar(objEntSede);
            TraerSede();
        }

        private void cboIdSede_SelectedIndexChanged(object sender, EventArgs e)
        {

            btnModificar.Enabled = false;
             objEntSede.Id= Convert.ToInt32(cboIdSede.SelectedValue);
            objEntSede = objDatosSede.TraerUno(objEntSede.Id);
            txtNombre.Text = objEntSede.Nombre;
           txtDomicilio.Text= objEntSede.Domicilio;
            txtObservacion.Text= objEntSede.Observacion;

        }

        private void ModificarSede_Load(object sender, EventArgs e)
        {
            
            TraerSede();
            btnModificar.Enabled = false;
            
        }

        private void cboIdSede_Leave(object sender, EventArgs e)
        {
            btnModificar.Enabled = true;
        }
    }
}
