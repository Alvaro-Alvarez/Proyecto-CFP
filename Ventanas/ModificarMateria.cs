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
    public partial class ModificarMateria : Form
    {
        public ModificarMateria()
        {
            InitializeComponent();
        }

        Datos.Curso objDatosCurso = new Datos.Curso();
        Datos.Materia objDatosMateria = new Datos.Materia();
        Entidades.Curso objEntCurso = new Entidades.Curso();
        Entidades.Materia objEntMateria = new Entidades.Materia();

        private void TraerCursos(){
            cboCurso.DataSource = objDatosCurso.TraerTodos("cursos");
            cboCurso.DisplayMember = "nombre_curso";
            cboCurso.ValueMember = "id_curso";
            this.cboCurso.SelectedIndexChanged += new System.EventHandler(this.cboCurso_SelectedIndexChanged);
       

        }

        private void cboCurso_SelectedIndexChanged(object sender, EventArgs e)
        {
            cboMateria.Enabled = true;
            btnModificar.Enabled= false;
            
            cboMateria.DataSource = objDatosMateria.TraerTodo(Convert.ToInt32(cboCurso.SelectedValue),"materias");
            cboMateria.DisplayMember = "nombre_materia";
            cboMateria.ValueMember = "id_materia";
            
            this.cboMateria.SelectedIndexChanged += new System.EventHandler(this.cboMateria_SelectedIndexChanged);
            cboMateria.SelectedIndex = -1;


        }

        private void ModificarMateria_Load(object sender, EventArgs e)
        {
            TraerCursos();
            cboCurso.SelectedIndex = -1;
        }

        private void cboMateria_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnModificar.Enabled = true;

           objEntMateria.Id = Convert.ToInt32(cboMateria.SelectedValue);
            objEntMateria =objDatosMateria.TraerUno(objEntMateria.Id,objEntMateria);
            
            txtNombre.Text=objEntMateria.Nombre;
            txtObservacion.Text = objEntMateria.Observacion;

        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            objEntMateria.Nombre = txtNombre.Text;
            objEntMateria.Observacion = txtObservacion.Text;
            try
            {
                objDatosMateria.Modificar(objEntMateria);
                MessageBox.Show("La Sede Fue Agregada", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudo hacer la modificacion");
            }
        }
    }
}
