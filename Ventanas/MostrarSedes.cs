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
    public partial class MostrarSedes : Form
    {
        public MostrarSedes()
        {
            InitializeComponent();
        }

        Datos.Sede objDatosSede = new Datos.Sede();

        private void MostrarSedes_Load(object sender, EventArgs e)
        {
            dgvSedes.DataSource=objDatosSede.TraerTodos();
        }
    }
}
