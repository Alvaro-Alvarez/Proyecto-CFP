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
    public partial class EliminarMateria : Form
    {
        private Datos.Materia objDatosMateria = new Datos.Materia();
        private Entidades.Materia objEntMateria = new Entidades.Materia();

        private Datos.Curso objDatosCurso = new Datos.Curso();
        private Entidades.Curso objEntCurso = new Entidades.Curso();
        public EliminarMateria()
        {
            InitializeComponent();
        }

        private void TraerMateria(int p_idcurso)
        {
            // enlazo al comboBox
            cboMateria.DataSource = objDatosMateria.TraerTodo(p_idcurso,"materias");
            // campo/alias a  mostrar
            cboMateria.DisplayMember = "nombre_materia";
            // campo/alias a guardar
            cboMateria.ValueMember = "id_materia";
            this.cboMateria.SelectedIndexChanged += new System.EventHandler(this.cboMateria_SelectedIndexChanged);
            cboMateria.SelectedIndex = -1;


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
            btnEliminar.Enabled = false;
            TraerCurso();
            
        }

      

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            objDatosMateria.Eliminar(objEntMateria.Id);
            TraerMateria(objEntCurso.Id);
            btnEliminar.Enabled = false;
        }

        private void cboCurso_SelectedIndexChanged(object sender, EventArgs e)
        {
            objEntCurso.Id = Convert.ToInt32(cboCurso.SelectedValue);

            TraerMateria(objEntCurso.Id);
            


            lblObs.Text = objEntMateria.Observacion;
        }

        private void cboMateria_SelectedIndexChanged(object sender, EventArgs e)
        {

            objEntMateria=objDatosMateria.TraerUno(Convert.ToInt32(cboMateria.SelectedValue),objEntMateria);
            lblObs.Text = objEntMateria.Observacion;
            btnEliminar.Enabled = true;
           
        }
    }
}
