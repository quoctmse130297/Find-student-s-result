using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Windows.Forms;

namespace MarkReport
{
    class MyConnection
    {
        public static SqlConnection GetConn()
        {
            SqlConnection conn;
            try
            {
                conn = new SqlConnection(@"Server=DESKTOP-JG5AV9L;database=MarkReport;user id=sa;password=123456");
            }catch(Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
            return conn;
        }
        public static void OpenDB()
        {
            string sql = @"Server=DESKTOP-JG5AV9L;database=MarkReport;user id=sa;password=123456";
          
                conn = new SqlConnection(sql);
                conn.Open();
            
        }
        public static DataTable GetDataTable(string sql)
        {
            cmd = new SqlCommand(sql, conn);
            da = new SqlDataAdapter();
            da.SelectCommand = cmd;

            DataTable table = new DataTable();
            da.Fill(table);

            da.Dispose();
            cmd.Dispose();

            return table;
        }
        public static void Execute(String sql)
        {
            cmd = new SqlCommand(sql, conn);
            cmd.ExecuteNonQuery();
        }
    }
}
