using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace guicafeteria
{
    public partial class Pedido : Form
    {
        private DataTable detallePedido;
        private decimal totalPedido = 0;
        private int? idEmpleadoAtendio = null;
        private string nombreEmpleadoAtendio = "";

        public Pedido()
        {
            InitializeComponent();
            dgvProductos.CellDoubleClick += dgvProductos_CellDoubleClick;
            btnLimpiar.Click += btnLimpiar_Click;
            btnGenerarBoleta.Click += btnGenerarBoleta_Click;
            btnFinalizarPedido.Click += btnFinalizarPedido_Click;
            btnQuitarProducto.Click += btnQuitarProducto_Click;
        }
        private readonly string conexion = Properties.Settings.Default.BD_CafeteriaConnectionString;



        private void CargarProductos()
        {
            using (SqlConnection cn = new SqlConnection(conexion))
            {
                cn.Open();

                string query = @"
                  SELECT 
                  id_producto,
                  nombre_producto,
                  precio,
                  stock
                  FROM PRODUCTO
                  WHERE estado = 'Activo'
                  ORDER BY nombre_producto";

                SqlDataAdapter da = new SqlDataAdapter(query, cn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                dgvProductos.DataSource = dt;
                FormatearProductos();
                AplicarDetalleAlStockVisual();
            }
        }

        private void Pedido_Load(object sender, EventArgs e)
        {
            this.BackColor = Color.FromArgb(200, 155, 90);
            panel1.BackColor = Color.FromArgb(200, 155, 90);

            cboMetodoPago.Items.Clear();
            cboMetodoPago.Items.Add("Efectivo");
            cboMetodoPago.Items.Add("Tarjeta");
            cboMetodoPago.Items.Add("Yape");
            cboMetodoPago.SelectedIndex = -1;
            cboMetodoPago.Text = "Seleccione";

            ConfigurarDetallePedido();
            CargarProductos();
        }

        private void btnBebidasCalientes_Click(object sender, EventArgs e)
        {
            CargarProductosPorCategoria(1);
        }
        private void CargarProductosPorCategoria(int idCategoria)
        {
            using (SqlConnection cn = new SqlConnection(conexion))
            {
                cn.Open();

                string query = @"
                 SELECT 
                 id_producto,
                 nombre_producto,
                  precio,
                  stock
                  FROM PRODUCTO
                 WHERE estado = 'Activo'
                  AND id_categoria = @id_categoria
                  ORDER BY nombre_producto";

                SqlCommand cmd = new SqlCommand(query, cn);
                cmd.Parameters.AddWithValue("@id_categoria", idCategoria);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                dgvProductos.DataSource = dt;
                FormatearProductos();
                AplicarDetalleAlStockVisual();
            }
        }

        private void btnBebidasFrias_Click(object sender, EventArgs e)
        {
            CargarProductosPorCategoria(2);
        }

        private void btnPanaderia_Click(object sender, EventArgs e)
        {
            CargarProductosPorCategoria(3);
        }

        private void btnPostres_Click(object sender, EventArgs e)
        {
            CargarProductosPorCategoria(4);
        }

        private void ConfigurarDetallePedido()
        {
            detallePedido = new DataTable();
            detallePedido.Columns.Add("id_producto", typeof(int));
            detallePedido.Columns.Add("producto", typeof(string));
            detallePedido.Columns.Add("precio", typeof(decimal));
            detallePedido.Columns.Add("cantidad", typeof(int));
            detallePedido.Columns.Add("subtotal", typeof(decimal));

            dgvDetallePedido.DataSource = detallePedido;
            dgvDetallePedido.ReadOnly = true;
            dgvDetallePedido.AllowUserToAddRows = false;
            dgvDetallePedido.SelectionMode = DataGridViewSelectionMode.FullRowSelect;

            FormatearDetallePedido();
            lblTotal.Text = "Total: S/ 0.00";
        }

        private void FormatearProductos()
        {
            if (dgvProductos.Columns.Count == 0)
            {
                return;
            }

            dgvProductos.ReadOnly = true;
            dgvProductos.AllowUserToAddRows = false;
            dgvProductos.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvProductos.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            dgvProductos.Columns["id_producto"].Visible = false;
            dgvProductos.Columns["stock"].Visible = false;
            dgvProductos.Columns["nombre_producto"].HeaderText = "Producto";
            dgvProductos.Columns["precio"].HeaderText = "Precio";
            dgvProductos.Columns["precio"].DefaultCellStyle.Format = "0.00";
        }

        private void FormatearDetallePedido()
        {
            if (dgvDetallePedido.Columns.Count == 0)
            {
                return;
            }

            dgvDetallePedido.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            dgvDetallePedido.Columns["id_producto"].Visible = false;
            dgvDetallePedido.Columns["precio"].Visible = false;
            dgvDetallePedido.Columns["subtotal"].Visible = false;
            dgvDetallePedido.Columns["producto"].HeaderText = "Producto";
            dgvDetallePedido.Columns["cantidad"].HeaderText = "Cantidad";
        }

        private void AplicarDetalleAlStockVisual()
        {
            DataTable tablaProductos = dgvProductos.DataSource as DataTable;

            if (tablaProductos == null || detallePedido == null)
            {
                return;
            }

            foreach (DataRow detalle in detallePedido.Rows)
            {
                int idProducto = Convert.ToInt32(detalle["id_producto"]);
                int cantidad = Convert.ToInt32(detalle["cantidad"]);
                AjustarStockVisual(idProducto, -cantidad);
            }
        }

        private void AjustarStockVisual(int idProducto, int diferencia)
        {
            DataTable tablaProductos = dgvProductos.DataSource as DataTable;

            if (tablaProductos == null)
            {
                return;
            }

            DataRow producto = tablaProductos.AsEnumerable()
                .FirstOrDefault(fila => Convert.ToInt32(fila["id_producto"]) == idProducto);

            if (producto == null)
            {
                return;
            }

            int stockActual = Convert.ToInt32(producto["stock"]);
            int nuevoStock = stockActual + diferencia;
            producto["stock"] = nuevoStock < 0 ? 0 : nuevoStock;
        }

        private void dgvProductos_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0)
            {
                return;
            }

            DataGridViewRow fila = dgvProductos.Rows[e.RowIndex];

            int idProducto = Convert.ToInt32(fila.Cells["id_producto"].Value);
            string nombreProducto = fila.Cells["nombre_producto"].Value.ToString();
            decimal precio = Convert.ToDecimal(fila.Cells["precio"].Value);
            int stock = Convert.ToInt32(fila.Cells["stock"].Value);

            if (stock <= 0)
            {
                MessageBox.Show("El producto seleccionado no tiene stock disponible.", "Stock no disponible",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            DataRow productoExistente = detallePedido.AsEnumerable()
                .FirstOrDefault(row => row.Field<int>("id_producto") == idProducto);

            if (productoExistente == null)
            {
                detallePedido.Rows.Add(idProducto, nombreProducto, precio, 1, precio);
            }
            else
            {
                int cantidadActual = productoExistente.Field<int>("cantidad");

                productoExistente["cantidad"] = cantidadActual + 1;
                productoExistente["subtotal"] = precio * (cantidadActual + 1);
            }

            AjustarStockVisual(idProducto, -1);
            CalcularTotal();
        }

        private void CalcularTotal()
        {
            totalPedido = detallePedido.AsEnumerable()
                .Sum(row => row.Field<decimal>("subtotal"));

            lblTotal.Text = "Total: S/ " + totalPedido.ToString("0.00");
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtNombreCliente.Clear();
            txtApellidoCliente.Clear();

            if (cboMetodoPago.Items.Count > 0)
            {
                cboMetodoPago.SelectedIndex = -1;
                cboMetodoPago.Text = "Seleccione";
            }

            detallePedido.Clear();
            idEmpleadoAtendio = null;
            nombreEmpleadoAtendio = "";
            CargarProductos();
            CalcularTotal();
        }

        private bool ValidarDatosPedido()
        {
            if (string.IsNullOrWhiteSpace(txtNombreCliente.Text))
            {
                MessageBox.Show("Debe ingresar el nombre del cliente.", "Dato obligatorio",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtNombreCliente.Focus();
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtApellidoCliente.Text))
            {
                MessageBox.Show("Debe ingresar el apellido del cliente.", "Dato obligatorio",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtApellidoCliente.Focus();
                return false;
            }

            if (cboMetodoPago.SelectedIndex < 0 || cboMetodoPago.Text == "Seleccione")
            {
                MessageBox.Show("Debe seleccionar un metodo de pago.", "Dato obligatorio",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                cboMetodoPago.Focus();
                return false;
            }

            return true;
        }

        private bool ValidarPedidoConProductos()
        {
            if (!ValidarDatosPedido())
            {
                return false;
            }

            if (detallePedido.Rows.Count == 0)
            {
                MessageBox.Show("Debe agregar al menos un producto al pedido.", "Pedido vacio",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }

            return true;
        }

        private bool AsegurarEmpleadoAtencion()
        {
            if (idEmpleadoAtendio.HasValue && !string.IsNullOrWhiteSpace(nombreEmpleadoAtendio))
            {
                return true;
            }

            using (FrmSeleccionarEmpleado frmEmpleado = new FrmSeleccionarEmpleado())
            {
                if (frmEmpleado.ShowDialog(this) != DialogResult.OK)
                {
                    return false;
                }

                idEmpleadoAtendio = frmEmpleado.IdEmpleado;
                nombreEmpleadoAtendio = frmEmpleado.NombreEmpleado;
                return true;
            }
        }

        private void btnGenerarBoleta_Click(object sender, EventArgs e)
        {
            if (!ValidarPedidoConProductos())
            {
                return;
            }

            if (!AsegurarEmpleadoAtencion())
            {
                return;
            }

            string rutaBoleta = GenerarArchivoBoleta(null);

            MessageBox.Show("Boleta generada correctamente.\n\nRuta:\n" + rutaBoleta,
                "Boleta guardada", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private string GenerarArchivoBoleta(int? idPedido)
        {

            StringBuilder boleta = new StringBuilder();
            boleta.AppendLine("========================================");
            boleta.AppendLine("          CAFETERIA AURORA");
            boleta.AppendLine("           BOLETA SIMPLE");
            boleta.AppendLine("========================================");
            boleta.AppendLine();
            if (idPedido.HasValue)
            {
                boleta.AppendLine("Pedido N.: " + idPedido.Value);
            }
            boleta.AppendLine("Fecha: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm"));
            boleta.AppendLine("Cliente: " + txtNombreCliente.Text.Trim() + " " + txtApellidoCliente.Text.Trim());
            boleta.AppendLine("Atendido por: " + nombreEmpleadoAtendio);
            boleta.AppendLine("Metodo de pago: " + cboMetodoPago.Text);
            boleta.AppendLine();
            boleta.AppendLine("----------------------------------------");
            boleta.AppendLine("Producto                 Cant.   Subtotal");
            boleta.AppendLine("----------------------------------------");

            foreach (DataRow row in detallePedido.Rows)
            {
                string producto = row["producto"].ToString();
                int cantidad = Convert.ToInt32(row["cantidad"]);
                decimal subtotal = Convert.ToDecimal(row["subtotal"]);

                if (producto.Length > 22)
                {
                    producto = producto.Substring(0, 22);
                }

                boleta.AppendLine(
                    producto.PadRight(24) +
                    cantidad.ToString().PadLeft(3) +
                    "     S/ " + subtotal.ToString("0.00").PadLeft(7));
            }

            boleta.AppendLine("----------------------------------------");
            boleta.AppendLine("TOTAL: S/ " + totalPedido.ToString("0.00"));
            boleta.AppendLine();
            boleta.AppendLine("Gracias por su compra.");
            boleta.AppendLine("========================================");

            string carpetaBoletas = Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),
                "Boletas_Cafeteria");

            Directory.CreateDirectory(carpetaBoletas);

            string nombreArchivo = "Boleta_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".txt";
            string rutaBoleta = Path.Combine(carpetaBoletas, nombreArchivo);

            File.WriteAllText(rutaBoleta, boleta.ToString(), Encoding.UTF8);
            return rutaBoleta;
        }

        private void btnFinalizarPedido_Click(object sender, EventArgs e)
        {
            if (!ValidarPedidoConProductos())
            {
                return;
            }

            DialogResult confirmacion = MessageBox.Show(
                "Desea finalizar este pedido?",
                "Confirmar pedido",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question);

            if (confirmacion != DialogResult.Yes)
            {
                return;
            }

            if (!AsegurarEmpleadoAtencion())
            {
                return;
            }

            btnFinalizarPedido.Enabled = false;

            try
            {
                int idPedido = RegistrarPedidoEnBaseDeDatos();
                string rutaBoleta;

                try
                {
                    rutaBoleta = GenerarArchivoBoleta(idPedido);
                }
                catch (Exception exBoleta)
                {
                    MessageBox.Show("El pedido N. " + idPedido +
                        " se registro correctamente, pero no se pudo guardar la boleta.\n\nDetalle: " +
                        exBoleta.Message,
                        "Pedido guardado sin boleta", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                    btnLimpiar_Click(null, EventArgs.Empty);
                    return;
                }

                string avisoApertura = string.Empty;

                try
                {
                    System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo
                    {
                        FileName = rutaBoleta,
                        UseShellExecute = true
                    });
                }
                catch (Exception exApertura)
                {
                    avisoApertura = "\n\nLa boleta fue guardada, pero no se pudo abrir automaticamente.\nDetalle: " +
                        exApertura.Message;
                }

                MessageBox.Show("Pedido N. " + idPedido + " registrado correctamente.\n\nAtendido por: " +
                    nombreEmpleadoAtendio + "\n\nBoleta guardada en:\n" + rutaBoleta + avisoApertura,
                    "Pedido guardado", MessageBoxButtons.OK, MessageBoxIcon.Information);

                btnLimpiar_Click(null, EventArgs.Empty);
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se guardo ninguna parte del pedido. Rehaga el pedido e intentelo nuevamente.\n\nDetalle: " +
                    ex.Message,
                    "Error al guardar", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                btnFinalizarPedido.Enabled = true;
            }
        }

        private int RegistrarPedidoEnBaseDeDatos()
        {
            using (SqlConnection cn = new SqlConnection(conexion))
            {
                cn.Open();

                using (SqlTransaction transaccion = cn.BeginTransaction(IsolationLevel.Serializable))
                {
                    try
                    {
                        int idCliente;
                        string nombres = txtNombreCliente.Text.Trim();
                        string apellidos = txtApellidoCliente.Text.Trim();

                        const string buscarCliente = @"
                            SELECT TOP (1) id_cliente
                            FROM CLIENTE WITH (UPDLOCK, HOLDLOCK)
                            WHERE UPPER(LTRIM(RTRIM(nombres))) = UPPER(@nombres)
                              AND UPPER(LTRIM(RTRIM(apellidos))) = UPPER(@apellidos)
                            ORDER BY id_cliente;";

                        using (SqlCommand cmd = new SqlCommand(buscarCliente, cn, transaccion))
                        {
                            cmd.Parameters.Add("@nombres", SqlDbType.VarChar, 80).Value = nombres;
                            cmd.Parameters.Add("@apellidos", SqlDbType.VarChar, 80).Value = apellidos;

                            object clienteExistente = cmd.ExecuteScalar();

                            if (clienteExistente == null || clienteExistente == DBNull.Value)
                            {
                                const string insertarCliente = @"
                                    INSERT INTO CLIENTE (nombres, apellidos, telefono, correo)
                                    VALUES (@nombres, @apellidos, NULL, 'No proporcionado');
                                    SELECT CAST(SCOPE_IDENTITY() AS INT);";

                                using (SqlCommand insertar = new SqlCommand(insertarCliente, cn, transaccion))
                                {
                                    insertar.Parameters.Add("@nombres", SqlDbType.VarChar, 80).Value = nombres;
                                    insertar.Parameters.Add("@apellidos", SqlDbType.VarChar, 80).Value = apellidos;
                                    idCliente = Convert.ToInt32(insertar.ExecuteScalar());
                                }
                            }
                            else
                            {
                                idCliente = Convert.ToInt32(clienteExistente);
                            }
                        }

                        const string validarEmpleado = @"
                            SELECT COUNT(*)
                            FROM EMPLEADO WITH (UPDLOCK, HOLDLOCK)
                            WHERE id_empleado = @id_empleado AND estado = 'Activo';";

                        using (SqlCommand cmd = new SqlCommand(validarEmpleado, cn, transaccion))
                        {
                            cmd.Parameters.Add("@id_empleado", SqlDbType.Int).Value = idEmpleadoAtendio.Value;

                            if (Convert.ToInt32(cmd.ExecuteScalar()) != 1)
                            {
                                throw new InvalidOperationException("El empleado seleccionado ya no esta activo.");
                            }
                        }

                        decimal totalConfirmado = 0;

                        foreach (DataRow fila in detallePedido.Rows)
                        {
                            int idProducto = Convert.ToInt32(fila["id_producto"]);
                            int cantidad = Convert.ToInt32(fila["cantidad"]);

                            const string consultarProducto = @"
                                SELECT precio, stock
                                FROM PRODUCTO WITH (UPDLOCK, HOLDLOCK)
                                WHERE id_producto = @id_producto AND estado = 'Activo';";

                            using (SqlCommand cmd = new SqlCommand(consultarProducto, cn, transaccion))
                            {
                                cmd.Parameters.Add("@id_producto", SqlDbType.Int).Value = idProducto;

                                using (SqlDataReader lector = cmd.ExecuteReader())
                                {
                                    if (!lector.Read())
                                    {
                                        throw new InvalidOperationException("Uno de los productos ya no esta disponible.");
                                    }

                                    decimal precioActual = lector.GetDecimal(0);
                                    int stockActual = lector.GetInt32(1);

                                    if (stockActual < cantidad)
                                    {
                                        throw new InvalidOperationException("No hay stock suficiente de " + fila["producto"] + ".");
                                    }

                                    fila["precio"] = precioActual;
                                    fila["subtotal"] = precioActual * cantidad;
                                    totalConfirmado += precioActual * cantidad;
                                }
                            }
                        }

                        const string insertarPedido = @"
                            INSERT INTO PEDIDO (fecha_pedido, total, metodo_pago, id_cliente, id_empleado)
                            VALUES (@fecha_pedido, @total, @metodo_pago, @id_cliente, @id_empleado);
                            SELECT CAST(SCOPE_IDENTITY() AS INT);";

                        int idPedido;

                        using (SqlCommand cmd = new SqlCommand(insertarPedido, cn, transaccion))
                        {
                            cmd.Parameters.Add("@fecha_pedido", SqlDbType.Date).Value = DateTime.Today;
                            cmd.Parameters.Add("@total", SqlDbType.Decimal).Value = totalConfirmado;
                            cmd.Parameters["@total"].Precision = 10;
                            cmd.Parameters["@total"].Scale = 2;
                            cmd.Parameters.Add("@metodo_pago", SqlDbType.VarChar, 40).Value = cboMetodoPago.Text;
                            cmd.Parameters.Add("@id_cliente", SqlDbType.Int).Value = idCliente;
                            cmd.Parameters.Add("@id_empleado", SqlDbType.Int).Value = idEmpleadoAtendio.Value;
                            idPedido = Convert.ToInt32(cmd.ExecuteScalar());
                        }

                        foreach (DataRow fila in detallePedido.Rows)
                        {
                            int idProducto = Convert.ToInt32(fila["id_producto"]);
                            int cantidad = Convert.ToInt32(fila["cantidad"]);
                            decimal subtotal = Convert.ToDecimal(fila["subtotal"]);

                            const string insertarDetalle = @"
                                INSERT INTO DETALLE_PEDIDO (id_pedido, id_producto, cantidad, subtotal)
                                VALUES (@id_pedido, @id_producto, @cantidad, @subtotal);";

                            using (SqlCommand cmd = new SqlCommand(insertarDetalle, cn, transaccion))
                            {
                                cmd.Parameters.Add("@id_pedido", SqlDbType.Int).Value = idPedido;
                                cmd.Parameters.Add("@id_producto", SqlDbType.Int).Value = idProducto;
                                cmd.Parameters.Add("@cantidad", SqlDbType.Int).Value = cantidad;
                                cmd.Parameters.Add("@subtotal", SqlDbType.Decimal).Value = subtotal;
                                cmd.Parameters["@subtotal"].Precision = 10;
                                cmd.Parameters["@subtotal"].Scale = 2;
                                cmd.ExecuteNonQuery();
                            }

                            const string actualizarStock = @"
                                UPDATE PRODUCTO
                                SET stock = stock - @cantidad
                                WHERE id_producto = @id_producto AND stock >= @cantidad;

                                IF @@ROWCOUNT <> 1
                                    THROW 50001, 'No hay stock suficiente para completar el pedido.', 1;

                                UPDATE INVENTARIO
                                SET cantidad_disponible = (
                                        SELECT stock FROM PRODUCTO WHERE id_producto = @id_producto
                                    ),
                                    fecha_actualizacion = CAST(GETDATE() AS DATE)
                                WHERE id_producto = @id_producto;

                                IF @@ROWCOUNT <> 1
                                    THROW 50002, 'No se encontro el inventario del producto.', 1;";

                            using (SqlCommand cmd = new SqlCommand(actualizarStock, cn, transaccion))
                            {
                                cmd.Parameters.Add("@id_producto", SqlDbType.Int).Value = idProducto;
                                cmd.Parameters.Add("@cantidad", SqlDbType.Int).Value = cantidad;
                                cmd.ExecuteNonQuery();
                            }
                        }

                        transaccion.Commit();
                        totalPedido = totalConfirmado;
                        return idPedido;
                    }
                    catch
                    {
                        try
                        {
                            transaccion.Rollback();
                        }
                        catch
                        {
                            // La conexion puede haberse cerrado antes de completar el rollback.
                        }

                        throw;
                    }
                }
            }
        }

        private void btnQuitarProducto_Click(object sender, EventArgs e)
        {
            if (dgvDetallePedido.CurrentRow == null || dgvDetallePedido.CurrentRow.DataBoundItem == null)
            {
                MessageBox.Show("Seleccione un producto del detalle para quitarlo.", "Producto no seleccionado",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            DataRowView filaSeleccionada = dgvDetallePedido.CurrentRow.DataBoundItem as DataRowView;

            if (filaSeleccionada == null)
            {
                return;
            }

            int idProducto = Convert.ToInt32(filaSeleccionada["id_producto"]);
            int cantidad = Convert.ToInt32(filaSeleccionada["cantidad"]);

            detallePedido.Rows.Remove(filaSeleccionada.Row);
            AjustarStockVisual(idProducto, cantidad);
            CalcularTotal();
        }

        private void cboMetodoPago_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}

