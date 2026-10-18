using System;
using System.Windows.Forms;

namespace guicafeteria
{
    public partial class FrmLoginEncargado : Form
    {
        public string ContrasenaIngresada
        {
            get { return txtDni.Text.Trim(); }
        }

        public FrmLoginEncargado()
        {
            InitializeComponent();
        }

        private void btnIngresar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDni.Text))
            {
                MessageBox.Show("Ingrese la contraseña del encargado.", "Validacion",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtDni.Focus();
                return;
            }

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
