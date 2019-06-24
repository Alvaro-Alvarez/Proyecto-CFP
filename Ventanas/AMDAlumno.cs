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
    public partial class AMDAlumno : Form
    {
        private MenuPrincipal menu;

        public AMDAlumno(MenuPrincipal p_menu)
        {
            menu = p_menu;
            InitializeComponent();
        }
        private Entidades.Sede objEntSede = new Entidades.Sede();
        private Datos.Sede objDatosSede = new Datos.Sede();
        private Entidades.Curso objEntCurso = new Entidades.Curso();
        private Datos.Curso objDatosCurso = new Datos.Curso();
        private Datos.Alumno objDatosAlumno = new Datos.Alumno();
        private Entidades.Alumno objEntAlumno = new Entidades.Alumno();
        private bool repite;

        private bool DniRepetido(string opcion){
            
        foreach (DataGridViewRow Row in dgwAlumnos.Rows)
                {
                    if(opcion=="agregar"){
                    string Valor = Convert.ToString(Row.Cells["dni"].Value);

                    if (Valor == txtDni.Text)
                    {

                        repite = true;
                        break;
                    }
                    }


                   
            

            }

                
               
                
            return repite;
                }




    private void CargarAlumno(){
            objEntAlumno.Nombre = txtNombre.Text;
            objEntAlumno.Apellido = txtApellido.Text;
            objEntAlumno.Dni = Convert.ToInt32(txtDni.Text);
            objEntAlumno.Sexo =cboSexo.Text;
            objEntAlumno.telefono = Convert.ToInt32(txtTelefono.Text);
            objEntAlumno.Domicilio = txtDomicilio.Text;
            objEntAlumno.Correo = txtElectronico.Text;
            objEntAlumno.Fechadenac = dtpFechaDeNac.Value;
            objEntAlumno.Localidad = cboLocalidad.Text;
}


        private void TraerSede(){

            cboSede.DataSource = objDatosSede.TraerTodos("sedes");
            cboSede.DisplayMember = "nombre_sede";
            cboSede.ValueMember = "id_sede";
            this.cboSede.SelectedIndexChanged += new System.EventHandler(this.cboSede_SelectedIndexChanged);

        }
        private void TraerCurso()
        {
            
            cboCurso.DataSource = objDatosCurso.CursoDisponibleXSede(objEntSede.Id);
            cboCurso.DisplayMember = "nombre_curso";
            cboCurso.ValueMember = "id_curso";
            
            this.cboCurso.SelectedIndexChanged += new System.EventHandler(this.cboCurso_SelectedIndexChanged);
        }


        private void btnAgregar_Click(object sender, EventArgs e)
        {
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            if (txtDni.TextLength > 0 && txtNombre.TextLength > 0 && txtApellido.TextLength > 0)
            {
                if (DniRepetido("agregar") == true)
                {
                    MessageBox.Show("Hay Una Persona con ese dni. Ingrese bien el dni", "Error", MessageBoxButtons.OK,

MessageBoxIcon.Error);
                }
                else
                {



                    CargarAlumno();
                    objDatosAlumno.Agregar(objEntAlumno, "Alumno", objEntSede.Id, objEntCurso.Id);
                    dgwAlumnos.DataSource = objDatosAlumno.TraerTodos(objEntCurso.Id, objEntSede.Id, "alumno");
                    dgwAlumnos.Columns[0].Visible = false;

                }
                }
            
            else
            {

                MessageBox.Show("Llene todos los campos");
            }
        }

        private void AMDAlumno_Load(object sender, EventArgs e)
        {
            MessageBox.Show("A continuacion se mostrara todos los alumno que este en el Sistema","Info");
            TraerSede();
            cboSede.SelectedIndex = -1;
            dgwAlumnos.DataSource =objDatosAlumno.TraerTodos(0,0,"alumno");
            dgwAlumnos.Columns[0].Visible = false;
            dgwAlumnos.ClearSelection();

            btnAgregar.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;


        }

        private void cboSede_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            objEntSede.Id = Convert.ToInt32(cboSede.SelectedValue);
            TraerCurso();
            cboCurso.SelectedIndex = -1;
            dgwAlumnos.DataSource = null;
            dgwAlumnos.DataSource = objDatosAlumno.TraerTodos(0,objEntSede.Id,"alumno");
            dgwAlumnos.Columns[0].Visible = false;
            dgwAlumnos.ClearSelection();
            btnAgregar.Enabled = false;
            tlpFormulario.Enabled = false;
            cboCurso.Enabled = true;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;

        }

        private void cboCurso_SelectedIndexChanged(object sender, EventArgs e)
        {
            objEntCurso.Id = Convert.ToInt32(cboCurso.SelectedValue);
            dgwAlumnos.DataSource = objDatosAlumno.TraerTodos(objEntCurso.Id, objEntSede.Id,"alumno");
            dgwAlumnos.Columns[0].Visible = false;
            dgwAlumnos.ClearSelection();
            tlpFormulario.Enabled =true;
            btnAgregar.Enabled =true;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
        }

        private void btnVolver_Click(object sender, EventArgs e)
        {

            this.Close();
            menu.Show();
        }

        private void dgwAlumnos_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            objEntAlumno.ID = Convert.ToInt32(dgwAlumnos.CurrentRow.Cells[0].Value.ToString());
            txtNombre.Text= dgwAlumnos.CurrentRow.Cells[1].Value.ToString();
            txtApellido.Text = dgwAlumnos.CurrentRow.Cells[2].Value.ToString();
            cboSexo.Text= dgwAlumnos.CurrentRow.Cells[3].Value.ToString();
            txtDni.Text= dgwAlumnos.CurrentRow.Cells[4].Value.ToString();
            txtTelefono.Text= dgwAlumnos.CurrentRow.Cells[5].Value.ToString();
            
            cboLocalidad.Text =dgwAlumnos.CurrentRow.Cells[6].Value.ToString();
            txtDomicilio.Text = dgwAlumnos.CurrentRow.Cells[7].Value.ToString();
            txtElectronico.Text = dgwAlumnos.CurrentRow.Cells[8].Value.ToString();
            dtpFechaDeNac.Value = Convert.ToDateTime(dgwAlumnos.CurrentRow.Cells[9].Value);
            objEntAlumno.Dni = Convert.ToInt32(dgwAlumnos.CurrentRow.Cells[4].Value.ToString());
            if (tlpFormulario.Enabled == true)
            {
                btnModificar.Enabled = true;
                btnEliminar.Enabled = true;
            }

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
            if (DniRepetido("modificar") == true)
            {
                MessageBox.Show("Hay Una Persona con ese dni. Ingrese bien el dni", "Error", MessageBoxButtons.OK,

MessageBoxIcon.Error);
            }
            else
            {
                CargarAlumno();

                objDatosAlumno.Modificar(objEntAlumno, objEntSede.Id, objEntCurso.Id);
                dgwAlumnos.DataSource = objDatosAlumno.TraerTodos(objEntCurso.Id, objEntSede.Id, "alumno");
                dgwAlumnos.Columns[0].Visible = false;
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            objDatosAlumno.Eliminar(objEntAlumno.ID,objEntSede.Id, objEntCurso.Id);
            dgwAlumnos.DataSource = objDatosAlumno.TraerTodos(objEntCurso.Id, objEntSede.Id, "alumno");
            dgwAlumnos.Columns[0].Visible = false;
        }

        private void txtDni_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void txtTelefono_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtDni_KeyPress(object sender, KeyPressEventArgs e)
        {
            Restricciones.Numeros(sender,e);
        }

        private void txtTelefono_KeyPress(object sender, KeyPressEventArgs e)
        {
            Restricciones.Numeros(sender, e);
        }

        private void tlpFormulario_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}
