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
    public partial class PlanillaDelProfesor : Form
    {
        private MenuPrincipal menu;

        public PlanillaDelProfesor(MenuPrincipal p_menu)
        {
            menu = p_menu;
            InitializeComponent();
        }
        private Entidades.Sede objEntSede = new Entidades.Sede();
        private Datos.Sede objDatosSede = new Datos.Sede();
        private Entidades.Curso objEntCurso = new Entidades.Curso();
        private Datos.Curso objDatosCurso = new Datos.Curso();
        private Datos.Materia objDatosMateria = new Datos.Materia();
        private Entidades.Materia objEntMateria = new Entidades.Materia();
        private Datos.Profesor objDatosProfesor = new Datos.Profesor();
        private Entidades.Profesor objEntProfesor = new Entidades.Profesor();
        private Datos.Alumno objDatosAlumno = new Datos.Alumno();
        private Entidades.Alumno objEntAlumno = new Entidades.Alumno();
      

      
            
 




    private void CargarProfesor(){
        
}


        private void TraerSede(){

            cboSede.DataSource = objDatosSede.TraerTodos("sedes");
            cboSede.DisplayMember = "nombre_sede";
            cboSede.ValueMember = "id_sede";
            this.cboSede.SelectedIndexChanged += new System.EventHandler(this.cboSede_SelectedIndexChanged);
            
            LsbMateria.Hide();

        }
        private void TraerCurso()
        {
            
            cboCurso.DataSource = objDatosCurso.CursoDisponibleXSede(objEntSede.Id);
            cboCurso.DisplayMember = "nombre_curso";
            cboCurso.ValueMember = "id_curso";
            LsbMateria.Show();
            this.cboCurso.SelectedIndexChanged += new System.EventHandler(this.cboCurso_SelectedIndexChanged);
        }
        private void TraerMateria()
        {
             LsbMateria.DataSource = objDatosMateria.TraerTodo(objEntCurso.Id,"materias");
            LsbMateria.DisplayMember = "nombre_materia";
            LsbMateria.ValueMember = "id_materia";

            this.LsbMateria.SelectedIndexChanged += new System.EventHandler(this.LsbMateria_SelectedIndexChanged);

        }


        private void btnAgregar_Click(object sender, EventArgs e)
        {
       
            
        
        }

        private void AMDAlumno_Load(object sender, EventArgs e)
        {
            TraerSede();
            cboSede.SelectedIndex = -1;
            dgwProfesor.DataSource=objDatosProfesor.TraerTodos(0,0,"profesor");
            dgwAlumno.Hide();
           
            dgwProfesor.Columns[0].Visible = false;
            dgwProfesor.Columns[3].Visible = false;
            dgwProfesor.Columns[4].Visible = false;
            dgwProfesor.Columns[5].Visible = false;
            dgwProfesor.Columns[6].Visible = false;
            dgwProfesor.Columns[7].Visible = false;
            dgwProfesor.Columns[8].Visible = false;
            dgwProfesor.Columns[9].Visible = false;
            cboSede.Text = "<Seleccione La Sede>";
            dgwAlumno.Hide();
          


        }

        private void cboSede_SelectedIndexChanged(object sender, EventArgs e)
        {

            
            objEntSede.Id = Convert.ToInt32(cboSede.SelectedValue);
            TraerCurso();
            cboCurso.SelectedIndex = -1;
           
            
            dgwProfesor.DataSource = null;
            dgwProfesor.DataSource = objDatosProfesor.TraerTodos(0,objEntSede.Id,"profesor");
            dgwProfesor.Columns[0].Visible = false;
            dgwProfesor.Columns[3].Visible = false;
            dgwProfesor.Columns[4].Visible = false;
            dgwProfesor.Columns[5].Visible = false;
            dgwProfesor.Columns[6].Visible = false;
            dgwProfesor.Columns[7].Visible = false;
            dgwProfesor.Columns[8].Visible = false;
            dgwProfesor.Columns[9].Visible = false;

            dgwAlumno.Hide();
            cboCurso.Enabled = true;
            tbl1.Hide();
            btnAgregarModificar.Hide();
            


        }

        private void cboCurso_SelectedIndexChanged(object sender, EventArgs e)
        {

            dgwAlumno.Show();
            objEntCurso.Id = Convert.ToInt32(cboCurso.SelectedValue);
            dgwProfesor.DataSource = objDatosProfesor.TraerTodos(objEntCurso.Id, objEntSede.Id,"profesor");
            TraerMateria();
            LsbMateria.SelectedIndex = -1;

            LsbMateria.Enabled = false;


            dgwProfesor.Columns[0].Visible = false;
            dgwProfesor.Columns[3].Visible = false;
            dgwProfesor.Columns[4].Visible = false;
            dgwProfesor.Columns[5].Visible = false;
            dgwProfesor.Columns[6].Visible = false;
            dgwProfesor.Columns[7].Visible = false;
            dgwProfesor.Columns[8].Visible = false;
            dgwProfesor.Columns[9].Visible = false;

            dgwAlumno.DataSource = objDatosProfesor.TraerTodos(objEntCurso.Id, objEntSede.Id, "Alumno");
            dgwAlumno.Columns[0].Visible = false;
            dgwAlumno.Columns[3].Visible = false;
            dgwAlumno.Columns[4].Visible = false;
            dgwAlumno.Columns[5].Visible = false;
            dgwAlumno.Columns[6].Visible = false;
            dgwAlumno.Columns[7].Visible = false;
            dgwAlumno.Columns[8].Visible = false;
            dgwAlumno.Columns[9].Visible = false;
            dgwProfesor.ClearSelection();
            dgwAlumno.ClearSelection();
            tbl1.Hide();
            btnAgregarModificar.Hide();
            dgwAlumno.Enabled = false;



        }

        private void btnVolver_Click(object sender, EventArgs e)
        {

            this.Close();
            menu.Show();
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
            if (txtNota.TextLength > 0) { 
            if (Convert.ToInt16(txtNota.Text) >= 0 && Convert.ToInt16(txtNota.Text) <= 10)
            {
                try
                {
                    objEntAlumno.Nota = Convert.ToInt32(txtNota.Text);

                    objDatosAlumno.AMNota(objEntAlumno, objEntMateria.Id, objEntCurso.Id, objEntSede.Id);
                    objDatosProfesor.Corregido(objEntProfesor, objEntMateria.Id, objEntCurso.Id, objEntSede.Id);
                    MessageBox.Show("Nota Ingresada");
                }
                catch (Exception ex)
                {

                }
            }
            else
            {
                MessageBox.Show("El formato de la nota es invalida.");
            }
        }
            else
            {
                MessageBox.Show("Ingrese un valor.");
            }

        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
           
        }

        private void dgwAlumno_CellClick(object sender, DataGridViewCellEventArgs e)
        {

            objEntAlumno.ID = Convert.ToInt32(dgwAlumno.CurrentRow.Cells[0].Value.ToString());
            LsbMateria.Enabled = true;
            LsbMateria.SelectedIndex = -1;
            tbl1.Hide();
            btnAgregarModificar.Hide();


        }

        private void dgwProfesor_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            objEntProfesor.ID = Convert.ToInt32(dgwProfesor.CurrentRow.Cells[0].Value.ToString());
            tbl1.Hide();
            btnAgregarModificar.Hide();
            LsbMateria.Enabled = false;
            dgwAlumno.Enabled = true;
            dgwAlumno.ClearSelection();


        }



        private void LsbMateria_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            objEntMateria.Id = Convert.ToInt32(LsbMateria.SelectedValue);
            txtNota.Text=objDatosAlumno.TraerUnaNota(objEntAlumno, objEntMateria.Id, objEntCurso.Id, objEntSede.Id);
            tbl1.Show();
            btnAgregarModificar.Show();
            
        }

        private void txtNota_Click(object sender, EventArgs e)
        {
            txtNota.Clear();
        }

        private void txtNota_KeyPress(object sender, KeyPressEventArgs e)
        {
            Restricciones.Numeros(sender,e);
        }
    }
}
