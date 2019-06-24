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
    public partial class MenuPrincipal : Form
    {
        public MenuPrincipal()
        {
            InitializeComponent();
        }

        private void darBajaToolStripMenuItem1_Click(object sender, EventArgs e)
        {

        }

        private void agregarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AgregarSede frmAgregarSede = new AgregarSede();
            frmAgregarSede.MdiParent = this;
            frmAgregarSede.Show();

        }

        private void MenuPrincipal_Load(object sender, EventArgs e)
        {
            Bienvenido frmB = new Bienvenido();
            frmB.MdiParent = this;
            frmB.Show();
        }

        private void listaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MostrarSedes fr = new MostrarSedes();
            fr.MdiParent = this;
            fr.Show();
        }

        private void modificarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ModificarSede fr = new ModificarSede();
            fr.MdiParent = this;
            fr.Show();
        }

        private void quitarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            EliminarSede fr = new EliminarSede();
            fr.MdiParent = this;
            fr.Show();
        }

        private void agregarCursoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AgregarCurso fr = new AgregarCurso();
            fr.MdiParent = this;
            fr.Show();
        }
    }
}
