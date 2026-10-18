namespace guicafeteria
{
    partial class FrmEncargado
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            this.lblTitulo = new System.Windows.Forms.Label();
            this.panelResumen = new System.Windows.Forms.Panel();
            this.txtTicketPromedio = new System.Windows.Forms.TextBox();
            this.txtCantidadPedidos = new System.Windows.Forms.TextBox();
            this.txtTotalVendido = new System.Windows.Forms.TextBox();
            this.lblTicketPromedio = new System.Windows.Forms.Label();
            this.lblCantidadPedidos = new System.Windows.Forms.Label();
            this.lblTotalVendido = new System.Windows.Forms.Label();
            this.lblResumen = new System.Windows.Forms.Label();
            this.panelReportes = new System.Windows.Forms.Panel();
            this.btnVentasMetodoPago = new System.Windows.Forms.Button();
            this.btnEmpleadosMasPedidos = new System.Windows.Forms.Button();
            this.btnClientesFrecuentes = new System.Windows.Forms.Button();
            this.btnVentasPorFecha = new System.Windows.Forms.Button();
            this.btnStockBajo = new System.Windows.Forms.Button();
            this.btnProductosMasVendidos = new System.Windows.Forms.Button();
            this.lblReportes = new System.Windows.Forms.Label();
            this.panelTabla = new System.Windows.Forms.Panel();
            this.dgvReportes = new System.Windows.Forms.DataGridView();
            this.lblTabla = new System.Windows.Forms.Label();
            this.panelStock = new System.Windows.Forms.Panel();
            this.btnAgregarStock = new System.Windows.Forms.Button();
            this.txtCantidadAgregar = new System.Windows.Forms.TextBox();
            this.lblCantidadAgregar = new System.Windows.Forms.Label();
            this.cmbProductos = new System.Windows.Forms.ComboBox();
            this.lblProducto = new System.Windows.Forms.Label();
            this.lblActualizarStock = new System.Windows.Forms.Label();
            this.btnCerrarSesion = new System.Windows.Forms.Button();
            this.panelResumen.SuspendLayout();
            this.panelReportes.SuspendLayout();
            this.panelTabla.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvReportes)).BeginInit();
            this.panelStock.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblTitulo
            // 
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Font = new System.Drawing.Font("Georgia", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTitulo.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(55)))), ((int)(((byte)(32)))), ((int)(((byte)(18)))));
            this.lblTitulo.Location = new System.Drawing.Point(26, 18);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(370, 39);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "Panel del encargado";
            // 
            // panelResumen
            // 
            this.panelResumen.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(76)))), ((int)(((byte)(47)))), ((int)(((byte)(29)))));
            this.panelResumen.Controls.Add(this.txtTicketPromedio);
            this.panelResumen.Controls.Add(this.txtCantidadPedidos);
            this.panelResumen.Controls.Add(this.txtTotalVendido);
            this.panelResumen.Controls.Add(this.lblTicketPromedio);
            this.panelResumen.Controls.Add(this.lblCantidadPedidos);
            this.panelResumen.Controls.Add(this.lblTotalVendido);
            this.panelResumen.Controls.Add(this.lblResumen);
            this.panelResumen.Location = new System.Drawing.Point(26, 66);
            this.panelResumen.Name = "panelResumen";
            this.panelResumen.Size = new System.Drawing.Size(970, 88);
            this.panelResumen.TabIndex = 1;
            // 
            // txtTicketPromedio
            // 
            this.txtTicketPromedio.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.txtTicketPromedio.Location = new System.Drawing.Point(750, 47);
            this.txtTicketPromedio.Name = "txtTicketPromedio";
            this.txtTicketPromedio.ReadOnly = true;
            this.txtTicketPromedio.Size = new System.Drawing.Size(168, 30);
            this.txtTicketPromedio.TabIndex = 6;
            // 
            // txtCantidadPedidos
            // 
            this.txtCantidadPedidos.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.txtCantidadPedidos.Location = new System.Drawing.Point(455, 47);
            this.txtCantidadPedidos.Name = "txtCantidadPedidos";
            this.txtCantidadPedidos.ReadOnly = true;
            this.txtCantidadPedidos.Size = new System.Drawing.Size(168, 30);
            this.txtCantidadPedidos.TabIndex = 5;
            // 
            // txtTotalVendido
            // 
            this.txtTotalVendido.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.txtTotalVendido.Location = new System.Drawing.Point(160, 47);
            this.txtTotalVendido.Name = "txtTotalVendido";
            this.txtTotalVendido.ReadOnly = true;
            this.txtTotalVendido.Size = new System.Drawing.Size(168, 30);
            this.txtTotalVendido.TabIndex = 4;
            // 
            // lblTicketPromedio
            // 
            this.lblTicketPromedio.AutoSize = true;
            this.lblTicketPromedio.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.lblTicketPromedio.ForeColor = System.Drawing.Color.White;
            this.lblTicketPromedio.Location = new System.Drawing.Point(747, 25);
            this.lblTicketPromedio.Name = "lblTicketPromedio";
            this.lblTicketPromedio.Size = new System.Drawing.Size(143, 23);
            this.lblTicketPromedio.TabIndex = 3;
            this.lblTicketPromedio.Text = "Ticket promedio";
            // 
            // lblCantidadPedidos
            // 
            this.lblCantidadPedidos.AutoSize = true;
            this.lblCantidadPedidos.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.lblCantidadPedidos.ForeColor = System.Drawing.Color.White;
            this.lblCantidadPedidos.Location = new System.Drawing.Point(452, 25);
            this.lblCantidadPedidos.Name = "lblCantidadPedidos";
            this.lblCantidadPedidos.Size = new System.Drawing.Size(177, 23);
            this.lblCantidadPedidos.TabIndex = 2;
            this.lblCantidadPedidos.Text = "Cantidad de pedidos";
            // 
            // lblTotalVendido
            // 
            this.lblTotalVendido.AutoSize = true;
            this.lblTotalVendido.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.lblTotalVendido.ForeColor = System.Drawing.Color.White;
            this.lblTotalVendido.Location = new System.Drawing.Point(189, 21);
            this.lblTotalVendido.Name = "lblTotalVendido";
            this.lblTotalVendido.Size = new System.Drawing.Size(119, 23);
            this.lblTotalVendido.TabIndex = 1;
            this.lblTotalVendido.Text = "Total vendido";
            // 
            // lblResumen
            // 
            this.lblResumen.AutoSize = true;
            this.lblResumen.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Bold);
            this.lblResumen.ForeColor = System.Drawing.Color.White;
            this.lblResumen.Location = new System.Drawing.Point(18, 13);
            this.lblResumen.Name = "lblResumen";
            this.lblResumen.Size = new System.Drawing.Size(165, 25);
            this.lblResumen.TabIndex = 0;
            this.lblResumen.Text = "Resumen general";
            // 
            // panelReportes
            // 
            this.panelReportes.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(76)))), ((int)(((byte)(47)))), ((int)(((byte)(29)))));
            this.panelReportes.Controls.Add(this.btnVentasMetodoPago);
            this.panelReportes.Controls.Add(this.btnEmpleadosMasPedidos);
            this.panelReportes.Controls.Add(this.btnClientesFrecuentes);
            this.panelReportes.Controls.Add(this.btnVentasPorFecha);
            this.panelReportes.Controls.Add(this.btnStockBajo);
            this.panelReportes.Controls.Add(this.btnProductosMasVendidos);
            this.panelReportes.Controls.Add(this.lblReportes);
            this.panelReportes.Location = new System.Drawing.Point(26, 174);
            this.panelReportes.Name = "panelReportes";
            this.panelReportes.Size = new System.Drawing.Size(224, 390);
            this.panelReportes.TabIndex = 2;
            // 
            // btnVentasMetodoPago
            // 
            this.btnVentasMetodoPago.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(105)))), ((int)(((byte)(64)))), ((int)(((byte)(39)))));
            this.btnVentasMetodoPago.FlatAppearance.BorderSize = 0;
            this.btnVentasMetodoPago.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(74)))), ((int)(((byte)(44)))), ((int)(((byte)(29)))));
            this.btnVentasMetodoPago.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(126)))), ((int)(((byte)(77)))), ((int)(((byte)(47)))));
            this.btnVentasMetodoPago.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnVentasMetodoPago.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnVentasMetodoPago.ForeColor = System.Drawing.Color.White;
            this.btnVentasMetodoPago.Location = new System.Drawing.Point(22, 316);
            this.btnVentasMetodoPago.Name = "btnVentasMetodoPago";
            this.btnVentasMetodoPago.Size = new System.Drawing.Size(180, 38);
            this.btnVentasMetodoPago.TabIndex = 6;
            this.btnVentasMetodoPago.Text = "Ventas por pago";
            this.btnVentasMetodoPago.UseVisualStyleBackColor = false;
            this.btnVentasMetodoPago.Click += new System.EventHandler(this.btnVentasMetodoPago_Click);
            // 
            // btnEmpleadosMasPedidos
            // 
            this.btnEmpleadosMasPedidos.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(105)))), ((int)(((byte)(64)))), ((int)(((byte)(39)))));
            this.btnEmpleadosMasPedidos.FlatAppearance.BorderSize = 0;
            this.btnEmpleadosMasPedidos.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(74)))), ((int)(((byte)(44)))), ((int)(((byte)(29)))));
            this.btnEmpleadosMasPedidos.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(126)))), ((int)(((byte)(77)))), ((int)(((byte)(47)))));
            this.btnEmpleadosMasPedidos.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnEmpleadosMasPedidos.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnEmpleadosMasPedidos.ForeColor = System.Drawing.Color.White;
            this.btnEmpleadosMasPedidos.Location = new System.Drawing.Point(22, 268);
            this.btnEmpleadosMasPedidos.Name = "btnEmpleadosMasPedidos";
            this.btnEmpleadosMasPedidos.Size = new System.Drawing.Size(180, 38);
            this.btnEmpleadosMasPedidos.TabIndex = 5;
            this.btnEmpleadosMasPedidos.Text = "Pedidos por empleado";
            this.btnEmpleadosMasPedidos.UseVisualStyleBackColor = false;
            this.btnEmpleadosMasPedidos.Click += new System.EventHandler(this.btnEmpleadosMasPedidos_Click);
            // 
            // btnClientesFrecuentes
            // 
            this.btnClientesFrecuentes.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(105)))), ((int)(((byte)(64)))), ((int)(((byte)(39)))));
            this.btnClientesFrecuentes.FlatAppearance.BorderSize = 0;
            this.btnClientesFrecuentes.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(74)))), ((int)(((byte)(44)))), ((int)(((byte)(29)))));
            this.btnClientesFrecuentes.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(126)))), ((int)(((byte)(77)))), ((int)(((byte)(47)))));
            this.btnClientesFrecuentes.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClientesFrecuentes.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnClientesFrecuentes.ForeColor = System.Drawing.Color.White;
            this.btnClientesFrecuentes.Location = new System.Drawing.Point(22, 220);
            this.btnClientesFrecuentes.Name = "btnClientesFrecuentes";
            this.btnClientesFrecuentes.Size = new System.Drawing.Size(180, 38);
            this.btnClientesFrecuentes.TabIndex = 4;
            this.btnClientesFrecuentes.Text = "Clientes frecuentes";
            this.btnClientesFrecuentes.UseVisualStyleBackColor = false;
            this.btnClientesFrecuentes.Click += new System.EventHandler(this.btnClientesFrecuentes_Click);
            // 
            // btnVentasPorFecha
            // 
            this.btnVentasPorFecha.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(105)))), ((int)(((byte)(64)))), ((int)(((byte)(39)))));
            this.btnVentasPorFecha.FlatAppearance.BorderSize = 0;
            this.btnVentasPorFecha.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(74)))), ((int)(((byte)(44)))), ((int)(((byte)(29)))));
            this.btnVentasPorFecha.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(126)))), ((int)(((byte)(77)))), ((int)(((byte)(47)))));
            this.btnVentasPorFecha.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnVentasPorFecha.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnVentasPorFecha.ForeColor = System.Drawing.Color.White;
            this.btnVentasPorFecha.Location = new System.Drawing.Point(22, 172);
            this.btnVentasPorFecha.Name = "btnVentasPorFecha";
            this.btnVentasPorFecha.Size = new System.Drawing.Size(180, 38);
            this.btnVentasPorFecha.TabIndex = 3;
            this.btnVentasPorFecha.Text = "Ventas por fecha";
            this.btnVentasPorFecha.UseVisualStyleBackColor = false;
            this.btnVentasPorFecha.Click += new System.EventHandler(this.btnVentasPorFecha_Click);
            // 
            // btnStockBajo
            // 
            this.btnStockBajo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(105)))), ((int)(((byte)(64)))), ((int)(((byte)(39)))));
            this.btnStockBajo.FlatAppearance.BorderSize = 0;
            this.btnStockBajo.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(74)))), ((int)(((byte)(44)))), ((int)(((byte)(29)))));
            this.btnStockBajo.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(126)))), ((int)(((byte)(77)))), ((int)(((byte)(47)))));
            this.btnStockBajo.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnStockBajo.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnStockBajo.ForeColor = System.Drawing.Color.White;
            this.btnStockBajo.Location = new System.Drawing.Point(22, 124);
            this.btnStockBajo.Name = "btnStockBajo";
            this.btnStockBajo.Size = new System.Drawing.Size(180, 38);
            this.btnStockBajo.TabIndex = 2;
            this.btnStockBajo.Text = "Stock actual";
            this.btnStockBajo.UseVisualStyleBackColor = false;
            this.btnStockBajo.Click += new System.EventHandler(this.btnStockBajo_Click);
            // 
            // btnProductosMasVendidos
            // 
            this.btnProductosMasVendidos.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(105)))), ((int)(((byte)(64)))), ((int)(((byte)(39)))));
            this.btnProductosMasVendidos.FlatAppearance.BorderSize = 0;
            this.btnProductosMasVendidos.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(74)))), ((int)(((byte)(44)))), ((int)(((byte)(29)))));
            this.btnProductosMasVendidos.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(126)))), ((int)(((byte)(77)))), ((int)(((byte)(47)))));
            this.btnProductosMasVendidos.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnProductosMasVendidos.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnProductosMasVendidos.ForeColor = System.Drawing.Color.White;
            this.btnProductosMasVendidos.Location = new System.Drawing.Point(22, 76);
            this.btnProductosMasVendidos.Name = "btnProductosMasVendidos";
            this.btnProductosMasVendidos.Size = new System.Drawing.Size(180, 38);
            this.btnProductosMasVendidos.TabIndex = 1;
            this.btnProductosMasVendidos.Text = "Pro. mas vendidos";
            this.btnProductosMasVendidos.UseVisualStyleBackColor = false;
            this.btnProductosMasVendidos.Click += new System.EventHandler(this.btnProductosMasVendidos_Click);
            // 
            // lblReportes
            // 
            this.lblReportes.AutoSize = true;
            this.lblReportes.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold);
            this.lblReportes.ForeColor = System.Drawing.Color.White;
            this.lblReportes.Location = new System.Drawing.Point(18, 22);
            this.lblReportes.Name = "lblReportes";
            this.lblReportes.Size = new System.Drawing.Size(97, 28);
            this.lblReportes.TabIndex = 0;
            this.lblReportes.Text = "Reportes";
            // 
            // panelTabla
            // 
            this.panelTabla.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(248)))), ((int)(((byte)(240)))), ((int)(((byte)(226)))));
            this.panelTabla.Controls.Add(this.dgvReportes);
            this.panelTabla.Controls.Add(this.lblTabla);
            this.panelTabla.Location = new System.Drawing.Point(272, 174);
            this.panelTabla.Name = "panelTabla";
            this.panelTabla.Size = new System.Drawing.Size(506, 390);
            this.panelTabla.TabIndex = 3;
            // 
            // dgvReportes
            // 
            this.dgvReportes.AllowUserToAddRows = false;
            this.dgvReportes.AllowUserToDeleteRows = false;
            this.dgvReportes.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvReportes.BackgroundColor = System.Drawing.Color.White;
            this.dgvReportes.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(76)))), ((int)(((byte)(47)))), ((int)(((byte)(29)))));
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            dataGridViewCellStyle1.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(76)))), ((int)(((byte)(47)))), ((int)(((byte)(29)))));
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvReportes.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvReportes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Segoe UI", 9F);
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(25)))), ((int)(((byte)(15)))));
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(164)))), ((int)(((byte)(111)))), ((int)(((byte)(61)))));
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgvReportes.DefaultCellStyle = dataGridViewCellStyle2;
            this.dgvReportes.EnableHeadersVisualStyles = false;
            this.dgvReportes.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(200)))), ((int)(((byte)(155)))), ((int)(((byte)(90)))));
            this.dgvReportes.Location = new System.Drawing.Point(18, 58);
            this.dgvReportes.Name = "dgvReportes";
            this.dgvReportes.ReadOnly = true;
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle3.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Segoe UI", 9F);
            dataGridViewCellStyle3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(25)))), ((int)(((byte)(15)))));
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(164)))), ((int)(((byte)(111)))), ((int)(((byte)(61)))));
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvReportes.RowHeadersDefaultCellStyle = dataGridViewCellStyle3;
            this.dgvReportes.RowHeadersWidth = 51;
            this.dgvReportes.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvReportes.Size = new System.Drawing.Size(470, 312);
            this.dgvReportes.TabIndex = 1;
            // 
            // lblTabla
            // 
            this.lblTabla.AutoSize = true;
            this.lblTabla.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold);
            this.lblTabla.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(55)))), ((int)(((byte)(32)))), ((int)(((byte)(18)))));
            this.lblTabla.Location = new System.Drawing.Point(14, 22);
            this.lblTabla.Name = "lblTabla";
            this.lblTabla.Size = new System.Drawing.Size(216, 28);
            this.lblTabla.TabIndex = 0;
            this.lblTabla.Text = "Reporte seleccionado";
            // 
            // panelStock
            // 
            this.panelStock.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(76)))), ((int)(((byte)(47)))), ((int)(((byte)(29)))));
            this.panelStock.Controls.Add(this.btnAgregarStock);
            this.panelStock.Controls.Add(this.txtCantidadAgregar);
            this.panelStock.Controls.Add(this.lblCantidadAgregar);
            this.panelStock.Controls.Add(this.cmbProductos);
            this.panelStock.Controls.Add(this.lblProducto);
            this.panelStock.Controls.Add(this.lblActualizarStock);
            this.panelStock.Location = new System.Drawing.Point(798, 174);
            this.panelStock.Name = "panelStock";
            this.panelStock.Size = new System.Drawing.Size(200, 390);
            this.panelStock.TabIndex = 4;
            // 
            // btnAgregarStock
            // 
            this.btnAgregarStock.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(105)))), ((int)(((byte)(64)))), ((int)(((byte)(39)))));
            this.btnAgregarStock.FlatAppearance.BorderSize = 0;
            this.btnAgregarStock.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(74)))), ((int)(((byte)(44)))), ((int)(((byte)(29)))));
            this.btnAgregarStock.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(126)))), ((int)(((byte)(77)))), ((int)(((byte)(47)))));
            this.btnAgregarStock.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAgregarStock.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnAgregarStock.ForeColor = System.Drawing.Color.White;
            this.btnAgregarStock.Location = new System.Drawing.Point(10, 230);
            this.btnAgregarStock.Name = "btnAgregarStock";
            this.btnAgregarStock.Size = new System.Drawing.Size(180, 38);
            this.btnAgregarStock.TabIndex = 5;
            this.btnAgregarStock.Text = "Agregar stock";
            this.btnAgregarStock.UseVisualStyleBackColor = false;
            this.btnAgregarStock.Click += new System.EventHandler(this.btnAgregarStock_Click);
            // 
            // txtCantidadAgregar
            // 
            this.txtCantidadAgregar.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.txtCantidadAgregar.Location = new System.Drawing.Point(20, 176);
            this.txtCantidadAgregar.Name = "txtCantidadAgregar";
            this.txtCantidadAgregar.Size = new System.Drawing.Size(160, 30);
            this.txtCantidadAgregar.TabIndex = 4;
            // 
            // lblCantidadAgregar
            // 
            this.lblCantidadAgregar.AutoSize = true;
            this.lblCantidadAgregar.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.lblCantidadAgregar.ForeColor = System.Drawing.Color.White;
            this.lblCantidadAgregar.Location = new System.Drawing.Point(17, 151);
            this.lblCantidadAgregar.Name = "lblCantidadAgregar";
            this.lblCantidadAgregar.Size = new System.Drawing.Size(83, 23);
            this.lblCantidadAgregar.TabIndex = 3;
            this.lblCantidadAgregar.Text = "Cantidad";
            // 
            // cmbProductos
            // 
            this.cmbProductos.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbProductos.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.cmbProductos.FormattingEnabled = true;
            this.cmbProductos.Location = new System.Drawing.Point(20, 105);
            this.cmbProductos.Name = "cmbProductos";
            this.cmbProductos.Size = new System.Drawing.Size(160, 28);
            this.cmbProductos.TabIndex = 2;
            // 
            // lblProducto
            // 
            this.lblProducto.AutoSize = true;
            this.lblProducto.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.lblProducto.ForeColor = System.Drawing.Color.White;
            this.lblProducto.Location = new System.Drawing.Point(17, 80);
            this.lblProducto.Name = "lblProducto";
            this.lblProducto.Size = new System.Drawing.Size(83, 23);
            this.lblProducto.TabIndex = 1;
            this.lblProducto.Text = "Producto";
            // 
            // lblActualizarStock
            // 
            this.lblActualizarStock.AutoSize = true;
            this.lblActualizarStock.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold);
            this.lblActualizarStock.ForeColor = System.Drawing.Color.White;
            this.lblActualizarStock.Location = new System.Drawing.Point(16, 22);
            this.lblActualizarStock.Name = "lblActualizarStock";
            this.lblActualizarStock.Size = new System.Drawing.Size(164, 28);
            this.lblActualizarStock.TabIndex = 0;
            this.lblActualizarStock.Text = "Actualizar stock";
            // 
            // btnCerrarSesion
            // 
            this.btnCerrarSesion.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(105)))), ((int)(((byte)(64)))), ((int)(((byte)(39)))));
            this.btnCerrarSesion.FlatAppearance.BorderSize = 0;
            this.btnCerrarSesion.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(74)))), ((int)(((byte)(44)))), ((int)(((byte)(29)))));
            this.btnCerrarSesion.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(126)))), ((int)(((byte)(77)))), ((int)(((byte)(47)))));
            this.btnCerrarSesion.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCerrarSesion.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnCerrarSesion.ForeColor = System.Drawing.Color.White;
            this.btnCerrarSesion.Location = new System.Drawing.Point(858, 20);
            this.btnCerrarSesion.Name = "btnCerrarSesion";
            this.btnCerrarSesion.Size = new System.Drawing.Size(140, 36);
            this.btnCerrarSesion.TabIndex = 5;
            this.btnCerrarSesion.Text = "Cerrar encargado";
            this.btnCerrarSesion.UseVisualStyleBackColor = false;
            this.btnCerrarSesion.Click += new System.EventHandler(this.btnCerrarSesion_Click);
            // 
            // FrmEncargado
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(201)))), ((int)(((byte)(157)))), ((int)(((byte)(96)))));
            this.ClientSize = new System.Drawing.Size(1036, 621);
            this.Controls.Add(this.btnCerrarSesion);
            this.Controls.Add(this.panelStock);
            this.Controls.Add(this.panelTabla);
            this.Controls.Add(this.panelReportes);
            this.Controls.Add(this.panelResumen);
            this.Controls.Add(this.lblTitulo);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "FrmEncargado";
            this.Text = "FrmEncargado";
            this.Load += new System.EventHandler(this.FrmEncargado_Load);
            this.panelResumen.ResumeLayout(false);
            this.panelResumen.PerformLayout();
            this.panelReportes.ResumeLayout(false);
            this.panelReportes.PerformLayout();
            this.panelTabla.ResumeLayout(false);
            this.panelTabla.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvReportes)).EndInit();
            this.panelStock.ResumeLayout(false);
            this.panelStock.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.Panel panelResumen;
        private System.Windows.Forms.Label lblResumen;
        private System.Windows.Forms.TextBox txtTicketPromedio;
        private System.Windows.Forms.TextBox txtCantidadPedidos;
        private System.Windows.Forms.TextBox txtTotalVendido;
        private System.Windows.Forms.Label lblTicketPromedio;
        private System.Windows.Forms.Label lblCantidadPedidos;
        private System.Windows.Forms.Label lblTotalVendido;
        private System.Windows.Forms.Panel panelReportes;
        private System.Windows.Forms.Button btnVentasMetodoPago;
        private System.Windows.Forms.Button btnEmpleadosMasPedidos;
        private System.Windows.Forms.Button btnClientesFrecuentes;
        private System.Windows.Forms.Button btnVentasPorFecha;
        private System.Windows.Forms.Button btnStockBajo;
        private System.Windows.Forms.Button btnProductosMasVendidos;
        private System.Windows.Forms.Label lblReportes;
        private System.Windows.Forms.Panel panelTabla;
        private System.Windows.Forms.DataGridView dgvReportes;
        private System.Windows.Forms.Label lblTabla;
        private System.Windows.Forms.Panel panelStock;
        private System.Windows.Forms.Button btnAgregarStock;
        private System.Windows.Forms.TextBox txtCantidadAgregar;
        private System.Windows.Forms.Label lblCantidadAgregar;
        private System.Windows.Forms.ComboBox cmbProductos;
        private System.Windows.Forms.Label lblProducto;
        private System.Windows.Forms.Label lblActualizarStock;
        private System.Windows.Forms.Button btnCerrarSesion;
    }
}
