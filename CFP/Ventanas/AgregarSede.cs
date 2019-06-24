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
    public partial class AgregarSede : Form
    {
        public AgregarSede()
        {
            InitializeComponent();
        }
        private Entidades.Sede objEntSede = new Entidades.Sede();
        private Datos.Sede objDatosSede = new Datos.Sede();
        private void btnAgregar_Click(object sender, EventArgs e)
        {
            if(txtNombre.TextLength>0 && txtDomicilio.TextLength > 0)
            {
                objEntSede.Nombre = txtNombre.Text;
                objEntSede.Domicilio = txtDomicilio.Text;
                objDatosSede.Agregar(objEntSede);


            }
            else
            {

                MessageBox.Show("Llene todos los campos");
            }
        }
    }
}
