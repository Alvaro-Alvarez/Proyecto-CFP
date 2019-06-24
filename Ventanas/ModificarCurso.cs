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
    public partial class ModificarCurso : Form
    {
        private List<string> LSedes = new List<string>();
        private List<string> LSedeSeleccionado = new List<string>();
        private Datos.Sede objDatosSede = new Datos.Sede();
        private Entidades.Sede objEntSede = new Entidades.Sede();
        private Datos.Curso objDatosCurso = new Datos.Curso();
        private Entidades.Curso objEntCurso = new Entidades.Curso();

        public ModificarCurso()
        {
            InitializeComponent();
        }
        private void TraerSede(){
        // enlazo al comboBox
        cboCurso.DataSource = objDatosSede.TraerTodos("Sedes");
            // campo/alias a  mostrar
            cboCurso.DisplayMember = "nombre_sede";
            // campo/alias a guardar
            cboCurso.ValueMember = "id_sede";
            

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
        private void btnAgregar_Click(object sender, EventArgs e)
        {
            
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            objEntCurso.Nombre=txtNombre.Text;
           
            objEntCurso.Observacion = txtObservacion.Text;

           
           objDatosCurso.Modificar(objEntCurso,LSedeSeleccionado);
            MessageBox.Show("El Curso Fue Modificada", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        

     

       

        private void txtNombre_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void cboCurso_SelectedIndexChanged(object sender, EventArgs e)
        {
            clbSede.Enabled = true;
            clbSede.DataSource = null;
            btnModificar.Enabled = false;
            objEntCurso.Id = Convert.ToInt16(cboCurso.SelectedValue);
            objEntCurso = objDatosCurso.TraerUno(objEntCurso.Id);
            txtNombre.Text = objEntCurso.Nombre;
            txtObservacion.Text = objEntCurso.Observacion;
            clbSede.DataSource = objDatosSede.TraerTodos("sedes");
            clbSede.DisplayMember = "nombre_sede";
            clbSede.ValueMember = "id_sede";


            LSedes.Clear();
            LSedes = objDatosCurso.SedesDisponible(objEntCurso.Nombre, LSedes);
            LSedeSeleccionado.Clear();


            for (int i = 0; i < clbSede.Items.Count; i++)
            {
                DataRow r;
                r = ((DataRowView)this.clbSede.Items[i]).Row;
                string val = (r[this.clbSede.ValueMember]).ToString();
                string dis = (r[this.clbSede.DisplayMember]).ToString();
                for (int a = 0; a < LSedes.Count; a++)
                {
                    if (LSedes[a] == dis)
                    {
                        clbSede.SetItemCheckState(i, CheckState.Checked);
                        LSedeSeleccionado.Add(val);
                    }


                    r = null;
                }
            }

             
            



    }


        

        private void cboCurso_Leave(object sender, EventArgs e)
        {
            btnModificar.Enabled = true;
        }

        private void ModificarCurso_Load(object sender, EventArgs e)
        {
            TraerCurso();
            btnModificar.Enabled = false;
            cboCurso.Text = "Seleccione La Sede";
            cboCurso.SelectedIndex = -1;


        }

        private void clbSede_ItemCheck(object sender, ItemCheckEventArgs e)
        {
            
            if (e.NewValue == CheckState.Checked)
            {
                LSedeSeleccionado.Add(clbSede.SelectedValue.ToString());
            }
            if (e.NewValue == CheckState.Unchecked)
            {
                LSedeSeleccionado.Remove(clbSede.SelectedValue.ToString());
            }
        }
    }
}
