using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MarkReport.DAO
{
    class DataProvider
    {
        private static DataProvider instance;

        internal static DataProvider Instance
        {
            get { if (instance == null) instance = new DataProvider(); return DataProvider.instance; }
            private set => instance = value;
        }

        private DataProvider() { }

        private static string connectionString = @"Data Source=DESKTOP-JG5AV9L;Initial Catalog=MarkReport;Persist Security Info=True;User ID=sa;pwd=123456";

        public DataTable ExecuteQuery(string query)
        {
            DataTable data = new DataTable();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                SqlCommand command = new SqlCommand(query, conn);

                SqlDataAdapter da = new SqlDataAdapter(command);

                da.Fill(data);

                conn.Close();
            }

            return data;
        }
    }
}
