using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace guicafeteria
{
    public partial class FrmSeleccionarEmpleado : Form
    {
        private readonly string conexion = Properties.Settings.Default.BD_CafeteriaConnectionString;

        public int IdEmpleado { get; private set; }
        public string NombreEmpleado { get; private set; }

        public FrmSeleccionarEmpleado()
        {
            InitializeComponent();
        }

        private void FrmSeleccionarEmpleado_Load(object sender, EventArgs e)
        {
            CargarEmpleados();
        }

        private void CargarEmpleados()
        {
            try
            {
                using (SqlConnection cn = new SqlConnection(conexion))
                {
                    string consulta =
                        "SELECT id_empleado, nombres + ' ' + apellidos + ' - ' + cargo AS empleado " +
                        "FROM EMPLEADO " +
                        "WHERE estado = 'Activo' " +
                        "ORDER BY cargo, nombres, apellidos";

                    SqlDataAdapter da = new SqlDataAdapter(consulta, cn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    cboEmpleado.DataSource = dt;
                    cboEmpleado.DisplayMember = "empleado";
                    cboEmpleado.ValueMember = "id_empleado";
                    cboEmpleado.SelectedIndex = -1;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudieron cargar los empleados.\n" + ex.Message,
                    "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                btnAceptar.Enabled = false;
            }
        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            if (cboEmpleado.SelectedIndex < 0 || cboEmpleado.SelectedValue == null)
            {
                MessageBox.Show("Seleccione el empleado que atendio el pedido.",
                    "Dato obligatorio", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cboEmpleado.Focus();
                return;
            }

            IdEmpleado = Convert.ToInt32(cboEmpleado.SelectedValue);
            NombreEmpleado = cboEmpleado.Text;
            DialogResult = DialogResult.OK;
            Close();
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }
    }
}
