using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using MarkReport.DAO;

namespace MarkReport
{
    public partial class MainFrame : Form
    {

        public MainFrame()
        {
            InitializeComponent();
        }


        private void MainFrame_Load(object sender, EventArgs e)
        {
            this.ShowCombobox();
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            string studentCode = (string)cbbCode.SelectedValue;

            LoadDgv(studentCode);

            LoadFormInfo(studentCode);
        }

        public void ShowCombobox()
        {
            string sql = "SELECT code FROM tblStudent";

            cbbCode.DataSource = DataProvider.Instance.ExecuteQuery(sql);

            cbbCode.DisplayMember = "code";

            cbbCode.ValueMember = "code";
        }

        private void LoadDgv(string studentCode)
        {
            string sql = "SELECT  tblMark.courseCode ,\n"
                + "        tblCourse.name ,\n"
                + "        tblMark.mark1 ,\n"
                + "        tblMark.mark2 ,\n"
                + "        tblMark.avgMark\n"
                + "FROM    ( SELECT    courseCode ,\n"
                + "                    mark1 ,\n"
                + "                    mark2 ,\n"
                + "                    ( mark1 + mark2 ) / 2 AS avgMark\n"
                + "          FROM      dbo.tblMarkReport\n"
                + "          WHERE     studentCode = '" + studentCode + "'\n"
                + "        ) AS tblMark\n"
                + "        JOIN dbo.tblCourse ON dbo.tblCourse.code = tblMark.courseCode;";

            dgvMark.DataSource = DataProvider.Instance.ExecuteQuery(sql);
        }

        private void LoadFormInfo(string studentCode)
        {
            string sql = "SELECT  firstName ,\n"
                + "        lastName ,\n"
                + "        dateOfBirth ,\n"
                + "        sex ,\n"
                + "        classCode ,\n"
                + "        tblAvg.avgMark\n"
                + "FROM    ( SELECT    studentCode ,\n"
                + "                    AVG(( mark1 + mark2 ) / 2) AS avgMark\n"
                + "          FROM      dbo.tblMarkReport\n"
                + "          WHERE     studentCode = '" + studentCode + "'\n"
                + "          GROUP BY  studentCode\n"
                + "        ) tblAvg\n"
                + "        LEFT JOIN dbo.tblStudent ON tblAvg.studentCode = dbo.tblStudent.code;";

            DataTable data = DataProvider.Instance.ExecuteQuery(sql);

            txtFirstName.Text = data.Rows[0].Field<string>(0);

            txtLastName.Text = data.Rows[0].Field<string>(1);

            txtDateOfBirth.Text = data.Rows[0].Field<DateTime>(2).Date.ToString("d");

            txtSex.Text = data.Rows[0].Field<bool>(3) ? "Nam" : "Nữ";

            txtClassCode.Text = data.Rows[0].Field<string>(4);

            txtAvgMark.Text = data.Rows[0].Field<double>(5).ToString();
        }
    }
}
