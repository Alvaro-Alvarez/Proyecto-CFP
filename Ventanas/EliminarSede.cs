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
    public partial class EliminarSede : Form
    {
        private Datos.Sede objDatosSede = new Datos.Sede();
        private Entidades.Sede objEntSede = new Entidades.Sede();
        public EliminarSede()
        {
            InitializeComponent();
        }

        private void TraerSede()
        {
            // enlazo al comboBox
            cboSede.DataSource = objDatosSede.TraerTodos();
            // campo/alias a  mostrar
            cboSede.DisplayMember = "nombre_sede";
            // campo/alias a guardar
            cboSede.ValueMember = "id_sede";
            this.cboSede.SelectedIndexChanged += new System.EventHandler(this.cboSede_SelectedIndexChanged);

        }
      

        private void EliminarSede_Load(object sender, EventArgs e)
        {
            TraerSede();
    }

        private void cboSede_SelectedIndexChanged(object sender, EventArgs e)
        {
            objEntSede.Id = Convert.ToInt32(cboSede.SelectedValue);
            objEntSede = objDatosSede.TraerUno(objEntSede.Id);
            
            lblDomicilio.Text = objEntSede.Domicilio;
            lblObs.Text = objEntSede.Observacion;
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            objDatosSede.Eliminar(objEntSede);
            TraerSede();
        }
    }
}
