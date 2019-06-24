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
    public partial class AMDProfesor : Form
    {
        private MenuPrincipal menu;

        public AMDProfesor(MenuPrincipal p_menu)
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
        private bool repite;

        private bool DniRepetido(){
            
        foreach (DataGridViewRow Row in dgwProfesor.Rows)
                {
                    
                    string Valor = Convert.ToString(Row.Cells["dni"].Value);

                    if (Valor == txtDni.Text)
                    {
                        
                    repite=true;
                    break;

                }
                else
                {
                    repite =false;
                }
                }
            return repite;
                }




    private void CargarProfesor(){
            objEntProfesor.Nombre = txtNombre.Text;
            objEntProfesor.Apellido = txtApellido.Text;
            objEntProfesor.Dni = Convert.ToInt32(txtDni.Text);
            objEntProfesor.Sexo = cboSexo.Text;
            objEntProfesor.telefono = Convert.ToInt32(txtTelefono.Text);
            objEntProfesor.Domicilio = txtDomicilio.Text;
            objEntProfesor.Correo = txtElectronico.Text;
            objEntProfesor.Fechadenac = dtpFechaDeNac.Value;
            objEntProfesor.Localidad = cboLocalidad.Text;
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
                if (DniRepetido() == true)
                {
                    MessageBox.Show("Hay Una Persona con ese dni. Ingrese bien el dni", "Error", MessageBoxButtons.OK,

MessageBoxIcon.Error);
                }
                else
                {



                    CargarProfesor();
                    objDatosProfesor.Agregar(objEntProfesor, "profesor", objEntSede.Id, objEntCurso.Id);
                    dgwProfesor.DataSource = objDatosProfesor.TraerTodos(objEntCurso.Id, objEntSede.Id, "profesor");
                    dgwProfesor.Columns[0].Visible = false;

                }
                }
            
            else
            {

                MessageBox.Show("Llene todos los campos");
            }
        }

        private void AMDAlumno_Load(object sender, EventArgs e)
        {
            TraerSede();
            cboSede.SelectedIndex = -1;
            dgwProfesor.DataSource =objDatosProfesor.TraerTodos(0,0,"profesor");
            dgwProfesor.Columns[0].Visible = false;
            dgwProfesor.ClearSelection();
            btnAgregar.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            MessageBox.Show("A continuacion se mostrara una lista de profesores que estan en el sistema","Info");


        }

        private void cboSede_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            objEntSede.Id = Convert.ToInt32(cboSede.SelectedValue);
            TraerCurso();
            cboCurso.SelectedIndex = -1;
            dgwProfesor.DataSource = null;
            dgwProfesor.DataSource = objDatosProfesor.TraerTodos(0,objEntSede.Id,"profesor");
            dgwProfesor.ClearSelection();
            dgwProfesor.Columns[0].Visible = false;
            btnAgregar.Enabled = false;
            tlpFormulario.Enabled = false;
            cboCurso.Enabled = true;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;

        }

        private void cboCurso_SelectedIndexChanged(object sender, EventArgs e)
        {
            objEntCurso.Id = Convert.ToInt32(cboCurso.SelectedValue);
            dgwProfesor.DataSource = objDatosProfesor.TraerTodos(objEntCurso.Id, objEntSede.Id,"profesor");
            dgwProfesor.Columns[0].Visible = false;
            dgwProfesor.ClearSelection();
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
            objEntProfesor.ID = Convert.ToInt32(dgwProfesor.CurrentRow.Cells[0].Value.ToString());
            txtNombre.Text= dgwProfesor.CurrentRow.Cells[1].Value.ToString();
            txtApellido.Text = dgwProfesor.CurrentRow.Cells[2].Value.ToString();
            cboSexo.Text= dgwProfesor.CurrentRow.Cells[3].Value.ToString();
            txtDni.Text= dgwProfesor.CurrentRow.Cells[4].Value.ToString();
            txtTelefono.Text= dgwProfesor.CurrentRow.Cells[5].Value.ToString();
            
            cboLocalidad.Text =dgwProfesor.CurrentRow.Cells[6].Value.ToString();
            txtDomicilio.Text = dgwProfesor.CurrentRow.Cells[7].Value.ToString();
            txtElectronico.Text = dgwProfesor.CurrentRow.Cells[8].Value.ToString();
            dtpFechaDeNac.Value = Convert.ToDateTime(dgwProfesor.CurrentRow.Cells[9].Value);
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
            if (DniRepetido() == true)
            {
                MessageBox.Show("Hay Una Persona con ese dni. Ingrese bien el dni", "Error", MessageBoxButtons.OK,

MessageBoxIcon.Error);
            }
            else
            {
                CargarProfesor();

                objDatosProfesor.Modificar(objEntProfesor, objEntSede.Id, objEntCurso.Id);
                dgwProfesor.DataSource = objDatosProfesor.TraerTodos(objEntCurso.Id, objEntSede.Id, "profesor");
                dgwProfesor.Columns[0].Visible = false;
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            objDatosProfesor.Eliminar(objEntProfesor.ID,objEntSede.Id, objEntCurso.Id);
            dgwProfesor.DataSource = objDatosProfesor.TraerTodos(objEntCurso.Id, objEntSede.Id, "profesor");
            dgwProfesor.Columns[0].Visible = false;
        }

        private void txtTelefono_KeyPress(object sender, KeyPressEventArgs e)
        {
            Restricciones.Numeros(sender,e);
        }
    }
}
