﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace WPF_Capture.ConnectDB
{
    public class DataConfig
    {
        private static string sConnect = "Server=DESKTOP-I86L24K\\SQLEXPRESS;Database=MedicineReceipt; Persist Security Info=True;User ID=sa;Password=12345;TrustServerCertificate=True";

        private static SqlConnection conn;

        public DataConfig()
        {

        }

        private static void  OpenConnect()
        {
            conn = new SqlConnection(sConnect); 
            conn.Open();
            if(conn.State == System.Data.ConnectionState.Open)
            {
                conn.Close();
            }
        }


        /// <summary>
        /// Hàm dùng để lấy dữ liệu từ SQL lên
        /// </summary>
        /// <param name="sSQL"> Biến này là câu lệnh SQL (VD: Insert,Update, Delete)  </param>
        /// <returns></returns>
        private static DataTable DataTransport(string sSQL)
        {
            OpenConnect(); ;
            SqlDataAdapter adapter = new SqlDataAdapter(sSQL, conn);
            DataTable dtReturn = new DataTable();
            dtReturn.Clear();
            adapter.Fill(dtReturn);
            return dtReturn;
        }


        /// <summary>
        /// Lấy danh sách tên thuốc từ cơ sở dữ liệu
        /// </summary>
        /// <returns>List<string> chứa tên thuốc</returns>
        //public static List<string> GetDrugNames()
        //{
        //    List<string> drugNames = new List<string>();

        //    string query = "SELECT name FROM Drug "; 

        //    DataTable dataTable = DataTransport(query);

        //    foreach (DataRow row in dataTable.Rows)
        //    {
        //        string drugName = row["name"].ToString();
        //        drugNames.Add(drugName);
        //    }

        //    return drugNames;
        //}

        public static Tuple<int, decimal> GetMedicineInfo(string medicineName)
        {
            Tuple<int, decimal> medicineInfo = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(sConnect))
                {
                    connection.Open();

                    string query = "SELECT Quantity, Price FROM Drug WHERE Name = @name";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@name", medicineName);

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        int quantity = Convert.ToInt32(reader["Quantity"]);
                        decimal price = Convert.ToDecimal(reader["Price"]);

                        medicineInfo = new Tuple<int, decimal>(quantity, price);
                    }

                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred while querying the database: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            return medicineInfo;
        }

        public List<string> GetKnownDrugsListNameFromDatabase()
        {
            List<string> knownDrugs = new List<string>();

            try
            {
                using (SqlConnection connection = new SqlConnection(sConnect))
                {
                    string query = "SELECT name FROM Drug"; 
                    SqlCommand command = new SqlCommand(query, connection);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        string drugName = reader["name"].ToString();
                        knownDrugs.Add(drugName);
                    }

                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred while fetching drug names from the database: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            return knownDrugs;
        }

        /// <summary>
        /// Hàm dùng để lưu dữ liệu xuống SQL
        /// </summary>
        /// <param name="sSQL"> Biến này là câu lệnh SQL (VD: Insert,Update, Delete) </param>
        /// <returns></returns>
        private static int DataExecution(string sSQL)
        {
            int iResult = 0;
            OpenConnect(); 
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sSQL;
            iResult = cmd.ExecuteNonQuery();
            return iResult;
        }
    }
}
