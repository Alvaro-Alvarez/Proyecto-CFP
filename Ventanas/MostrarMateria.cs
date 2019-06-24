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
    public partial class MostrarMateria : Form
    {
        public MostrarMateria()
        {
            InitializeComponent();
        }

        private Datos.Curso objDatosCurso = new Datos.Curso();
        private Entidades.Curso objEntCurso = new Entidades.Curso();
        private Datos.Materia objDatosMateria = new Datos.Materia();

        private void TraerCursos()
        {
            // enlazo al comboBox
            cboCurso.DataSource = objDatosCurso.TraerTodos("cursos");
            // campo/alias a  mostrar
            cboCurso.DisplayMember = "nombre_curso";
            // campo/alias a guardar
            cboCurso.ValueMember = "id_curso";
            this.cboCurso.SelectedIndexChanged += new System.EventHandler(this.cboCurso_SelectedIndexChanged);
            
        }


        

        private void MostrarSedes_Load(object sender, EventArgs e)
        {
            TraerCursos();
            cboCurso.SelectedIndex = -1;

        }

        private void cboCurso_SelectedIndexChanged(object sender, EventArgs e)
        {
            objEntCurso.Id = Convert.ToInt32(cboCurso.SelectedValue);
            dgvMateria.DataSource= objDatosMateria.TraerTodo(objEntCurso.Id,"LMaterias");
            if (dgvMateria.RowCount == 0)
            {
                MessageBox.Show("No hay nada de materias","Aviso"); dgvMateria.Hide();
            }
            else
            {
                dgvMateria.Show();
            }
        }
    }
}
