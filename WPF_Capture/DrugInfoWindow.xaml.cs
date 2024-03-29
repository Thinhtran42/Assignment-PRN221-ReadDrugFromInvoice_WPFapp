using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using static WPF_Capture.MainWindow;

namespace WPF_Capture
{
    /// <summary>
    /// Interaction logic for DrugInfoWindow.xaml
    /// </summary>
    public partial class DrugInfoWindow : Window
    {
        public DrugInfoWindow(List<DrugInfo> drugInfos)
        {
            InitializeComponent();

            // Hiển thị thông tin thuốc trong DataGrid
            drugDataGrid.ItemsSource = drugInfos;

            // Tính tổng giá trị của các thuốc
            decimal totalPrice = 0;
            foreach (DrugInfo drug in drugInfos)    
            {
                totalPrice += drug.Price;
            }

            // Hiển thị tổng giá trị trong TextBlock TotalPrice
            TotalPriceValue.Text = $"Total Price: {totalPrice}";
        }
    }
}
