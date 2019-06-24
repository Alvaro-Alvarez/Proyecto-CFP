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
    public partial class AgregarMateria : Form
    {
        public AgregarMateria()
        {
            InitializeComponent();
        }
        private Datos.Curso objDatosCurso =new Datos.Curso();
        private Datos.Materia objDatosMateria = new Datos.Materia();
        private Entidades.Curso objEntCurso = new Entidades.Curso();
        private Entidades.Materia objEntMateria = new Entidades.Materia();
        private void TraerCursos()
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

        private void btnAgregar_Click_1(object sender, EventArgs e)
        {

        }

        private void cboCurso_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnAgregar.Enabled = false;
            txtMateria.Enabled = true;
            txtObservacion.Enabled = true;
            objEntCurso.Id = Convert.ToInt16(cboCurso.SelectedValue);
           
            
        }

        private void AgregarMateria_Load(object sender, EventArgs e)
        {
            TraerCursos();
            
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            objEntMateria.Nombre = txtMateria.Text;
            objEntMateria.Observacion = txtObservacion.Text;
            objDatosMateria.Agregar(objEntMateria,objEntCurso);
            txtMateria.Clear();
            txtObservacion.Clear();
            btnAgregar.Enabled = false;


        }

        private void txtObservacion_TextChanged(object sender, EventArgs e)
        {
            if (txtMateria.TextLength > 1)
            {
                btnAgregar.Enabled = true;
            }
            else
            {
                btnAgregar.Enabled = false;
            }
                
        }

        private void txtMateria_TextChanged(object sender, EventArgs e)
        {
            if (txtMateria.TextLength > 1)
            {
                btnAgregar.Enabled = true;
            }
            else
            {
                btnAgregar.Enabled = false;
            }
        }
    }
}
