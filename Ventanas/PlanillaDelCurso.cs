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
    public partial class PlanillaDelCurso : Form
    {
        private MenuPrincipal menu;

        public PlanillaDelCurso(MenuPrincipal p_menu)
        {
            menu = p_menu;
            InitializeComponent();
        }
        private Entidades.Sede objEntSede = new Entidades.Sede();
        private Datos.Sede objDatosSede = new Datos.Sede();
        private Entidades.Curso objEntCurso = new Entidades.Curso();
        private Datos.Curso objDatosCurso = new Datos.Curso();
        private Datos.Profesor objDatosProfesor = new Datos.Profesor();
        private Entidades.Profesor objEntProfesor = new Entidades.Profesor();
        private Datos.Alumno objDatosAlumno = new Datos.Alumno();
        private Entidades.Alumno objEntAlumno = new Entidades.Alumno();
        private Entidades.Materia objEntMateria = new Entidades.Materia();
        private Datos.Materia objDatosMateria = new Datos.Materia();


        private void TraerMateria()
        {

            cboMateria.DataSource = objDatosMateria.TraerTodo(objEntCurso.Id, "materias");
            
            cboMateria.DisplayMember = "nombre_materia";
            cboMateria.ValueMember = "id_materia";
            cboMateria.SelectedIndex = -1;
            this.cboMateria.SelectedIndexChanged += new System.EventHandler(this.cboMateria_SelectedIndexChanged);
            


        }


        private void TraerSede(){

            cboSede.DataSource = objDatosSede.TraerTodos("sedes");
            cboSede.DisplayMember = "nombre_sede";
            cboSede.ValueMember = "id_sede";
            cboSede.SelectedIndex = -1;
            this.cboSede.SelectedIndexChanged += new System.EventHandler(this.cboSede_SelectedIndexChanged);
           
        }
        private void TraerCurso()
        {
            
            cboCurso.DataSource = objDatosCurso.CursoDisponibleXSede(objEntSede.Id);
            cboCurso.DisplayMember = "nombre_curso";
            cboCurso.ValueMember = "id_curso";
            cboCurso.SelectedIndex = -1;
            this.cboCurso.SelectedIndexChanged += new System.EventHandler(this.cboCurso_SelectedIndexChanged);
            
        }


        private void btnAgregar_Click(object sender, EventArgs e)
        {

           
        }

        private void AMDAlumno_Load(object sender, EventArgs e)
        {
            TraerSede();
            cboSede.SelectedIndex = -1;
            cboMateria.Enabled = false;
            cboCurso.Enabled = true;
            dgwLista.Hide();
            dgvProfesor.Hide();
         }

        private void cboSede_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            objEntSede.Id = Convert.ToInt32(cboSede.SelectedValue);
            TraerCurso();
            dgwLista.Hide();
            dgvProfesor.Hide();
            cboCurso.Enabled = true;
            cboMateria.Enabled = false;
        }

        private void cboCurso_SelectedIndexChanged(object sender, EventArgs e)
        {
            objEntCurso.Id = Convert.ToInt32(cboCurso.SelectedValue);
            dgwLista.DataSource = objDatosAlumno.MostrarNotas(objEntCurso.Id,objEntSede.Id,0);
            dgvProfesor.DataSource = objDatosProfesor.MostrarMateriasCorregidas(objEntSede.Id,objEntCurso.Id);
            TraerMateria();
            cboMateria.Enabled = true;
            dgwLista.Show();
            dgvProfesor.Show();
            
        }

        private void btnVolver_Click(object sender, EventArgs e)
        {

            this.Close();
            menu.Show();
        }

        private void dgwAlumnos_CellClick(object sender, DataGridViewCellEventArgs e)
        {


        }

        private void AMDAlumno_FormClosing(object sender, FormClosingEventArgs e)
        {
            menu.Show();
        }

        private void txtDni_Leave(object sender, EventArgs e)
        {
            
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
          
        }

        private void cboMateria_SelectedIndexChanged(object sender, EventArgs e)
        {
            objEntMateria.Id=Convert.ToInt32(cboMateria.SelectedValue);
            dgwLista.DataSource = objDatosAlumno.MostrarNotas(objEntCurso.Id, objEntSede.Id,objEntMateria.Id);
        }

       
    }
}
