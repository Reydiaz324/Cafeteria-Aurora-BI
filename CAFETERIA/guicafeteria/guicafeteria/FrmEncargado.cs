using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace guicafeteria
{
    public partial class FrmEncargado : Form
    {
        private readonly string cadenaConexion = Properties.Settings.Default.BD_CafeteriaConnectionString;

        public FrmEncargado()
        {
            InitializeComponent();
        }

        private void FrmEncargado_Load(object sender, EventArgs e)
        {
            CargarResumenGeneral();
            CargarComboBoxProductos();
            CargarProductosMasVendidos();
        }

        private void CargarResumenGeneral()
        {
            try
            {
                using (SqlConnection cn = new SqlConnection(cadenaConexion))
                {
                    cn.Open();

                    decimal totalVendido = Convert.ToDecimal(EjecutarEscalar(cn, "SELECT ISNULL(SUM(total), 0) FROM PEDIDO"));
                    int cantidadPedidos = Convert.ToInt32(EjecutarEscalar(cn, "SELECT COUNT(*) FROM PEDIDO"));
                    decimal ticketPromedio = Convert.ToDecimal(EjecutarEscalar(cn, "SELECT ISNULL(AVG(CAST(total AS DECIMAL(10,2))), 0) FROM PEDIDO"));

                    txtTotalVendido.Text = "S/ " + totalVendido.ToString("N2");
                    txtCantidadPedidos.Text = cantidadPedidos.ToString();
                    txtTicketPromedio.Text = "S/ " + ticketPromedio.ToString("N2");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudo cargar el resumen general.\n" + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private object EjecutarEscalar(SqlConnection cn, string consulta)
        {
            using (SqlCommand cmd = new SqlCommand(consulta, cn))
            {
                return cmd.ExecuteScalar();
            }
        }

        private void CargarComboBoxProductos()
        {
            try
            {
                using (SqlConnection cn = new SqlConnection(cadenaConexion))
                {
                    string consulta = "SELECT id_producto, nombre_producto FROM PRODUCTO ORDER BY nombre_producto";
                    SqlDataAdapter da = new SqlDataAdapter(consulta, cn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    cmbProductos.DataSource = dt;
                    cmbProductos.DisplayMember = "nombre_producto";
                    cmbProductos.ValueMember = "id_producto";
                    cmbProductos.SelectedIndex = -1;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudieron cargar los productos.\n" + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void CargarTabla(string consulta)
        {
            try
            {
                using (SqlConnection cn = new SqlConnection(cadenaConexion))
                {
                    SqlDataAdapter da = new SqlDataAdapter(consulta, cn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dgvReportes.DataSource = dt;
                    dgvReportes.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudo cargar el reporte.\n" + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void CargarProductosMasVendidos()
        {
            lblTabla.Text = "Productos mas vendidos";
            CargarTabla(
                "SELECT TOP 10 " +
                "p.nombre_producto AS Producto, " +
                "SUM(dp.cantidad) AS Cantidad, " +
                "CAST(SUM(dp.subtotal) AS DECIMAL(10,2)) AS Total " +
                "FROM DETALLE_PEDIDO dp " +
                "INNER JOIN PRODUCTO p ON dp.id_producto = p.id_producto " +
                "GROUP BY p.nombre_producto " +
                "ORDER BY Cantidad DESC");
        }

        private void btnProductosMasVendidos_Click(object sender, EventArgs e)
        {
            CargarProductosMasVendidos();
        }

        private void btnStockBajo_Click(object sender, EventArgs e)
        {
            lblTabla.Text = "Stock actual";
            CargarTabla(
                "SELECT p.nombre_producto AS Producto, " +
                "c.nombre_categoria AS Categoria, " +
                "p.stock AS Stock, " +
                "pr.nombre_proveedor AS Proveedor " +
                "FROM PRODUCTO p " +
                "INNER JOIN CATEGORIA c ON p.id_categoria = c.id_categoria " +
                "INNER JOIN PROVEEDOR pr ON p.id_proveedor = pr.id_proveedor " +
                "WHERE p.estado = 'Activo' " +
                "ORDER BY c.nombre_categoria, p.nombre_producto");
        }

        private void btnVentasPorFecha_Click(object sender, EventArgs e)
        {
            lblTabla.Text = "Ventas por fecha";
            CargarTabla(
                "SELECT fecha_pedido AS Fecha, " +
                "COUNT(id_pedido) AS Pedidos, " +
                "CAST(SUM(total) AS DECIMAL(10,2)) AS Total " +
                "FROM PEDIDO " +
                "GROUP BY fecha_pedido " +
                "ORDER BY fecha_pedido DESC");
        }

        private void btnVentasMetodoPago_Click(object sender, EventArgs e)
        {
            lblTabla.Text = "Ventas por metodo de pago";
            CargarTabla(
                "SELECT metodo_pago AS Metodo_Pago, " +
                "COUNT(id_pedido) AS Cantidad_Pedidos, " +
                "CAST(SUM(total) AS DECIMAL(10,2)) AS Total_Vendido " +
                "FROM PEDIDO " +
                "GROUP BY metodo_pago " +
                "ORDER BY Total_Vendido DESC");
        }

        private void btnClientesFrecuentes_Click(object sender, EventArgs e)
        {
            lblTabla.Text = "Clientes frecuentes";
            CargarTabla(
                "SELECT c.nombres + ' ' + c.apellidos AS Cliente, " +
                "COUNT(pe.id_pedido) AS Pedidos, " +
                "CAST(SUM(pe.total) AS DECIMAL(10,2)) AS Total " +
                "FROM CLIENTE c " +
                "INNER JOIN PEDIDO pe ON c.id_cliente = pe.id_cliente " +
                "GROUP BY c.nombres, c.apellidos " +
                "ORDER BY Pedidos DESC");
        }

        private void btnEmpleadosMasPedidos_Click(object sender, EventArgs e)
        {
            lblTabla.Text = "Pedidos atendidos por empleado";
            CargarTabla(
                "SELECT e.nombres + ' ' + e.apellidos AS Empleado, " +
                "e.cargo AS Cargo, " +
                "COUNT(pe.id_pedido) AS Pedidos_Atendidos, " +
                "CAST(ISNULL(SUM(pe.total), 0) AS DECIMAL(10,2)) AS Total_Atendido " +
                "FROM EMPLEADO e " +
                "LEFT JOIN PEDIDO pe ON e.id_empleado = pe.id_empleado " +
                "GROUP BY e.nombres, e.apellidos, e.cargo " +
                "ORDER BY Pedidos_Atendidos DESC");
        }

        private void btnAgregarStock_Click(object sender, EventArgs e)
        {
            if (cmbProductos.SelectedValue == null)
            {
                MessageBox.Show("Seleccione un producto.", "Validacion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            int cantidad;
            if (!int.TryParse(txtCantidadAgregar.Text.Trim(), out cantidad) || cantidad <= 0)
            {
                MessageBox.Show("Ingrese una cantidad valida mayor a cero.", "Validacion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            int idProducto = Convert.ToInt32(cmbProductos.SelectedValue);

            try
            {
                using (SqlConnection cn = new SqlConnection(cadenaConexion))
                {
                    cn.Open();
                    SqlTransaction transaccion = cn.BeginTransaction();

                    try
                    {
                        using (SqlCommand cmdProducto = new SqlCommand(
                            "UPDATE PRODUCTO SET stock = stock + @cantidad WHERE id_producto = @id_producto", cn, transaccion))
                        {
                            cmdProducto.Parameters.AddWithValue("@cantidad", cantidad);
                            cmdProducto.Parameters.AddWithValue("@id_producto", idProducto);
                            cmdProducto.ExecuteNonQuery();
                        }

                        using (SqlCommand cmdInventario = new SqlCommand(
                            "UPDATE INVENTARIO " +
                            "SET cantidad_disponible = (SELECT stock FROM PRODUCTO WHERE id_producto = @id_producto), " +
                            "fecha_actualizacion = CAST(GETDATE() AS DATE) " +
                            "WHERE id_producto = @id_producto", cn, transaccion))
                        {
                            cmdInventario.Parameters.AddWithValue("@id_producto", idProducto);
                            cmdInventario.ExecuteNonQuery();
                        }

                        transaccion.Commit();
                    }
                    catch
                    {
                        transaccion.Rollback();
                        throw;
                    }
                }

                MessageBox.Show("Stock actualizado correctamente.", "Correcto", MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtCantidadAgregar.Clear();
                CargarResumenGeneral();
                btnStockBajo_Click(sender, e);
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudo actualizar el stock.\n" + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
