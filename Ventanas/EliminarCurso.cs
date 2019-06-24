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
    public partial class EliminarCurso : Form
    {
        private Datos.Curso objDatosCurso = new Datos.Curso();
        private Datos.Materia objDatosMateria = new Datos.Materia();
        private Entidades.Curso objEntCurso = new Entidades.Curso();
        public EliminarCurso()
        {
            InitializeComponent();
        }

        private void TraerMaterias()
        {
            lsbMaterias.DataSource = objDatosMateria.TraerTodo(objEntCurso.Id, "materias");
            lsbMaterias.DisplayMember = "nombre_materia";
            lsbMaterias.ValueMember = "id_materia";
            lblMateria.Show();
            lsbMaterias.Show();

        }
        private void TraerCurso()
        {
            // enlazo al comboBox
            cboCurso.DataSource = objDatosCurso.TraerTodos("cursos");
            // campo/alias a  mostrar
            cboCurso.DisplayMember = "nombre_curso";
            // campo/alias a guardar
            cboCurso.ValueMember = "id_curso";
            this.cboCurso.SelectedIndexChanged += new System.EventHandler(this.cboCurso_SelectedIndexChanged);
            cboCurso.SelectedIndex = -1;

        }
      

        private void EliminarSede_Load(object sender, EventArgs e)
        {

           
    }

        private void cboSede_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            objDatosCurso.Eliminar(objEntCurso.Id);
            TraerCurso();
            lblMateria.Hide();
            lsbMaterias.Hide();
            x.Enabled =false;
        }

        private void cboCurso_SelectedIndexChanged(object sender, EventArgs e)
        {
            objEntCurso.Id = Convert.ToInt32(cboCurso.SelectedValue);
            objEntCurso = objDatosCurso.TraerUno(objEntCurso.Id);
            x.Enabled = true;

            lblObs.Text = objEntCurso.Observacion;
            TraerMaterias();
           

        }

        private void EliminarCurso_Load(object sender, EventArgs e)
        {
            TraerCurso();
          
        }
    }
}
