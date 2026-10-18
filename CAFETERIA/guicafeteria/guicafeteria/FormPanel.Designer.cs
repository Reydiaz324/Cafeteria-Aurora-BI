namespace guicafeteria
{
    partial class FormPanel
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormPanel));
            this.panel = new System.Windows.Forms.Panel();
            this.panelogo = new System.Windows.Forms.Panel();
            this.plogo = new System.Windows.Forms.PictureBox();
            this.Panelmenu = new System.Windows.Forms.Panel();
            this.btnEncargado = new System.Windows.Forms.Button();
            this.btnpedido = new System.Windows.Forms.Button();
            this.PanelBarra = new System.Windows.Forms.Panel();
            this.btncerrar = new System.Windows.Forms.PictureBox();
            this.btnmini = new System.Windows.Forms.PictureBox();
            this.panel.SuspendLayout();
            this.panelogo.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.plogo)).BeginInit();
            this.Panelmenu.SuspendLayout();
            this.PanelBarra.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.btncerrar)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnmini)).BeginInit();
            this.SuspendLayout();
            // 
            // panel
            // 
            this.panel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(200)))), ((int)(((byte)(155)))), ((int)(((byte)(90)))));
            this.panel.Controls.Add(this.panelogo);
            this.panel.Controls.Add(this.Panelmenu);
            this.panel.Controls.Add(this.PanelBarra);
            this.panel.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel.Location = new System.Drawing.Point(0, 0);
            this.panel.Name = "panel";
            this.panel.Size = new System.Drawing.Size(1236, 650);
            this.panel.TabIndex = 2;
            // 
            // panelogo
            // 
            this.panelogo.Controls.Add(this.plogo);
            this.panelogo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelogo.Location = new System.Drawing.Point(200, 29);
            this.panelogo.Name = "panelogo";
            this.panelogo.Size = new System.Drawing.Size(1036, 621);
            this.panelogo.TabIndex = 8;
            // 
            // plogo
            // 
            this.plogo.Image = ((System.Drawing.Image)(resources.GetObject("plogo.Image")));
            this.plogo.Location = new System.Drawing.Point(403, 210);
            this.plogo.Name = "plogo";
            this.plogo.Size = new System.Drawing.Size(237, 177);
            this.plogo.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.plogo.TabIndex = 9;
            this.plogo.TabStop = false;
            // 
            // Panelmenu
            // 
            this.Panelmenu.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(76)))), ((int)(((byte)(47)))), ((int)(((byte)(29)))));
            this.Panelmenu.Controls.Add(this.btnEncargado);
            this.Panelmenu.Controls.Add(this.btnpedido);
            this.Panelmenu.Dock = System.Windows.Forms.DockStyle.Left;
            this.Panelmenu.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Panelmenu.Location = new System.Drawing.Point(0, 29);
            this.Panelmenu.Name = "Panelmenu";
            this.Panelmenu.Size = new System.Drawing.Size(200, 621);
            this.Panelmenu.TabIndex = 7;
            // 
            // btnEncargado
            // 
            this.btnEncargado.FlatAppearance.BorderSize = 0;
            this.btnEncargado.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(74)))), ((int)(((byte)(44)))), ((int)(((byte)(29)))));
            this.btnEncargado.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(96)))), ((int)(((byte)(57)))), ((int)(((byte)(34)))));
            this.btnEncargado.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnEncargado.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnEncargado.ForeColor = System.Drawing.SystemColors.Window;
            this.btnEncargado.Location = new System.Drawing.Point(0, 210);
            this.btnEncargado.Name = "btnEncargado";
            this.btnEncargado.Size = new System.Drawing.Size(200, 45);
            this.btnEncargado.TabIndex = 7;
            this.btnEncargado.Text = "Encargado";
            this.btnEncargado.UseVisualStyleBackColor = false;
            this.btnEncargado.Click += new System.EventHandler(this.btnEncargado_Click);
            // 
            // btnpedido
            // 
            this.btnpedido.BackColor = System.Drawing.Color.Transparent;
            this.btnpedido.FlatAppearance.BorderSize = 0;
            this.btnpedido.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(74)))), ((int)(((byte)(44)))), ((int)(((byte)(29)))));
            this.btnpedido.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(96)))), ((int)(((byte)(57)))), ((int)(((byte)(34)))));
            this.btnpedido.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnpedido.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnpedido.ForeColor = System.Drawing.SystemColors.Window;
            this.btnpedido.Location = new System.Drawing.Point(0, 161);
            this.btnpedido.Name = "btnpedido";
            this.btnpedido.Size = new System.Drawing.Size(200, 43);
            this.btnpedido.TabIndex = 6;
            this.btnpedido.Text = "Pedido";
            this.btnpedido.UseVisualStyleBackColor = false;
            this.btnpedido.Click += new System.EventHandler(this.btnpedido_Click);
            // 
            // PanelBarra
            // 
            this.PanelBarra.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(76)))), ((int)(((byte)(47)))), ((int)(((byte)(29)))));
            this.PanelBarra.Controls.Add(this.btncerrar);
            this.PanelBarra.Controls.Add(this.btnmini);
            this.PanelBarra.Dock = System.Windows.Forms.DockStyle.Top;
            this.PanelBarra.Location = new System.Drawing.Point(0, 0);
            this.PanelBarra.Name = "PanelBarra";
            this.PanelBarra.Size = new System.Drawing.Size(1236, 29);
            this.PanelBarra.TabIndex = 6;
            // 
            // btncerrar
            // 
            this.btncerrar.Image = ((System.Drawing.Image)(resources.GetObject("btncerrar.Image")));
            this.btncerrar.Location = new System.Drawing.Point(1206, 7);
            this.btncerrar.Name = "btncerrar";
            this.btncerrar.Size = new System.Drawing.Size(18, 16);
            this.btncerrar.SizeMode = System.Windows.Forms.PictureBoxSizeMode.AutoSize;
            this.btncerrar.TabIndex = 1;
            this.btncerrar.TabStop = false;
            this.btncerrar.Click += new System.EventHandler(this.btncerrar_Click);
            // 
            // btnmini
            // 
            this.btnmini.Image = ((System.Drawing.Image)(resources.GetObject("btnmini.Image")));
            this.btnmini.Location = new System.Drawing.Point(1173, 13);
            this.btnmini.Name = "btnmini";
            this.btnmini.Size = new System.Drawing.Size(18, 10);
            this.btnmini.SizeMode = System.Windows.Forms.PictureBoxSizeMode.AutoSize;
            this.btnmini.TabIndex = 0;
            this.btnmini.TabStop = false;
            this.btnmini.Click += new System.EventHandler(this.btnmini_Click_1);
            // 
            // FormPanel
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1236, 650);
            this.Controls.Add(this.panel);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.MaximumSize = new System.Drawing.Size(1236, 650);
            this.MinimumSize = new System.Drawing.Size(850, 650);
            this.Name = "FormPanel";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Form1";
            this.panel.ResumeLayout(false);
            this.panelogo.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.plogo)).EndInit();
            this.Panelmenu.ResumeLayout(false);
            this.PanelBarra.ResumeLayout(false);
            this.PanelBarra.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.btncerrar)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnmini)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Panel panel;
        private System.Windows.Forms.Panel panelogo;
        private System.Windows.Forms.PictureBox plogo;
        private System.Windows.Forms.Panel Panelmenu;
        private System.Windows.Forms.Button btnpedido;
        private System.Windows.Forms.Panel PanelBarra;
        private System.Windows.Forms.PictureBox btncerrar;
        private System.Windows.Forms.PictureBox btnmini;
        private System.Windows.Forms.Button btnEncargado;
    }
}

