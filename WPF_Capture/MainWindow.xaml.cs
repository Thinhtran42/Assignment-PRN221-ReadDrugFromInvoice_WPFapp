using Emgu.CV;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
using System.Windows.Navigation;
using System.Windows.Shapes;
using Emgu.CV.Structure;
using Firebase.Storage;
using System.IO;
using IronOcr;
using System.Data;
using WPF_Capture.ConnectDB;

namespace WPF_Capture
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private VideoCapture _capture;
        private ObservableCollection<ImageInfo> imageList = new ObservableCollection<ImageInfo>();

        public class ImageInfo
        {
            public ImageSource ImageSource { get; set; }
            public string FilePath { get; set; }
        }
        public MainWindow()
        {
            InitializeComponent();
            InitializeCamera();
        }

        public void InitializeCamera()
        {
            _capture = new VideoCapture();
            _capture.ImageGrabbed += ProcessFrame;
            _capture.Start();
        }

        public void ProcessFrame(object sender, EventArgs e)
        {
            try
            {
                Mat frame = new Mat();
                _capture.Retrieve(frame);

                imageControl.Dispatcher.Invoke(() =>
                {
                    imageControl.Source = ToBitmapSource(frame);
                });
            }
            catch (Exception ex)
            {
                MessageBox.Show("Something went wrong");
            }

        }

        public static BitmapSource ToBitmapSource(Mat frame)
        {
            BitmapSource bitmapSource = null;
            try
            {
                using (Image<Bgr, byte> image = frame.ToImage<Bgr, byte>())
                {
                    System.Drawing.Bitmap bitmap = image.ToBitmap();

                    using (System.IO.MemoryStream memory = new System.IO.MemoryStream())
                    {
                        bitmap.Save(memory, System.Drawing.Imaging.ImageFormat.Bmp);
                        memory.Position = 0;

                        BitmapImage bitmapImage = new BitmapImage();
                        bitmapImage.BeginInit();
                        bitmapImage.StreamSource = memory;
                        bitmapImage.CacheOption = BitmapCacheOption.OnLoad;
                        bitmapImage.EndInit();
                        bitmapImage.Freeze();

                        //Set BitmapImage as the Source of Image
                        bitmapSource = bitmapImage;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Cannot convert Mat to BitmapSource: " + ex.Message);
            }
            return bitmapSource;
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (_capture != null && _capture.IsOpened)
            {
                _capture.Stop();
            }
        }

        private void btnBrowse_Click(object sender, RoutedEventArgs e)
        {
            Microsoft.Win32.OpenFileDialog openFileDialog = new Microsoft.Win32.OpenFileDialog();
            openFileDialog.Title = "Select a folder to save the image";
            openFileDialog.Filter = "All Files (*.*)|*.*";
            openFileDialog.CheckFileExists = false;
            openFileDialog.CheckPathExists = true;
            openFileDialog.FileName = "Select Folder";

            bool? result = openFileDialog.ShowDialog();

            if (result == true)
            {
                // Display the selected folder path in the TextBox
                txtAddress.Text = System.IO.Path.GetDirectoryName(openFileDialog.FileName);
                LoadImagesFromFolder(txtAddress.Text);
            }
        }

        private void btnCapture_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(txtAddress.Text))
            {
                MessageBox.Show("Please select folder");
                return;
            }
            Mat captureImage = new Mat();
            _capture.Retrieve(captureImage);

            //Create file dialog
            string fileName = System.IO.Path.Combine(txtAddress.Text, DateTime.Now.ToString("yyyyMMddHHmmss") + ".jpg" + ".webp");
            captureImage.Save(fileName);

            //Create image info object
            ImageInfo imageInfo = new ImageInfo()
            {
                ImageSource = ToBitmapSource(captureImage),
                FilePath = fileName
            };

            //Add to list
            imageList.Add(imageInfo);

            //Set to list view
            listView.ItemsSource = null;
            listView.ItemsSource = imageList;


        }

        private void LoadImagesFromFolder(string folderPath)
        {
            // Lấy tất cả các tệp hình ảnh trong thư mục
            string[] imageFiles = Directory.GetFiles(folderPath, "*.*").Where(file => file.EndsWith(".png") || file.EndsWith(".jpg") || file.EndsWith(".webp") || file.EndsWith(".jpeg")).ToArray();

            // Xóa tất cả các mục hiện có trong ListView
            imageList.Clear();

            // Thêm tất cả các hình ảnh vào ListView
            foreach (string imageFile in imageFiles)
            {
                Mat image = CvInvoke.Imread(imageFile); // Đọc hình ảnh từ tệp

                ImageInfo imageInfo = new ImageInfo()
                {
                    ImageSource = ToBitmapSource(image),
                    FilePath = imageFile
                };

                imageList.Add(imageInfo);
            }

            // Đặt nguồn dữ liệu cho ListView
            listView.ItemsSource = null;
            listView.ItemsSource = imageList;
        }


        private async void listView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            // Get the selected item
            var selectedItem = (ImageInfo)listView.SelectedItem;

            if (selectedItem != null)
            {
                MessageBoxResult result = MessageBox.Show("Do you want to read text in this image?", "Confirmation", MessageBoxButton.YesNo);
                if (result == MessageBoxResult.Yes)
                {
                    var Ocr = new IronTesseract();

                    Ocr.Language = OcrLanguage.EnglishBest;
                    //Ocr.AddSecondaryLanguage(OcrLanguage.Vietnamese);

                    using OcrInput input = new OcrInput(selectedItem.FilePath);
                    input.Deskew();
                    input.DeNoise();
                    // Convert the image to a binary (black and white) image
                    input.Binarize();
                    input.EnhanceResolution();

                    OcrResult resultText = Ocr.Read(input);
                    var rs = resultText.Text;

                    // Danh sách các loại thuốc bạn đã biết
                    //List<string> knownDrugs = new List<string> { "YESOM", "Saferon", "Tebexerol", "Medrol", "Arcoxia", "Baciamin Plus", "Bestimac", "DICSEP", "CELERZIN", "Amoxycilin", "Zinnat", "Rivaroxaban", "Tablet", "Gliclazid" };
                    DataConfig dataConfig = new DataConfig();
                    List<string> knownDrugs = dataConfig.GetKnownDrugsListNameFromDatabase();

                    if (!string.IsNullOrEmpty(rs) && rs.Length > 0)
                    {
                        //List<string> drugsInText = knownDrugs.Where(drug => rs.ToLower().Contains(drug.ToLower())).ToList();
                        List<string> drugsInText = knownDrugs.Where(drug => rs.IndexOf(drug, StringComparison.OrdinalIgnoreCase) >= 0).ToList();

                        if (drugsInText.Any())
                        {
                            foreach (string drugName in drugsInText)
                            {
                                // Query database to get medicine info
                                Tuple<int, decimal> medicineInfo = DataConfig.GetMedicineInfo(drugName);
                                if (medicineInfo != null)
                                {
                                    int quantity = medicineInfo.Item1;
                                    decimal price = medicineInfo.Item2;
                                    MessageBox.Show($"Tên thuốc: {drugName}\nSố lượng còn lại: {quantity}\nGiá tiền sản phẩm: {price}", "Thông tin thuốc", MessageBoxButton.OK, MessageBoxImage.Information);
                                }
                                else
                                {
                                    MessageBox.Show($"Không tìm thấy thông tin cho thuốc có tên: {drugName}", "Thông tin thuốc", MessageBoxButton.OK, MessageBoxImage.Information);
                                }
                            }
                        }
                        else
                        {
                            MessageBox.Show("Không tìm thấy tên thuốc trong văn bản.", "Thông tin thuốc", MessageBoxButton.OK, MessageBoxImage.Information);
                        }
                    }
                }
            }
        }
    
        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {
            if (listView.SelectedItem != null)
            {
                var selectedItem = (ImageInfo)listView.SelectedItem;
                var imagePath = selectedItem.FilePath;

                MessageBoxResult result = MessageBox.Show($"Bạn có chắc chắn muốn xóa ảnh \"{imagePath}\" không?", "Xác nhận xóa", MessageBoxButton.YesNo, MessageBoxImage.Question);

                if (result == MessageBoxResult.Yes)
                {
                    try
                    {
                        File.Delete(imagePath);
                        LoadImagesFromFolder(System.IO.Path.GetDirectoryName(imagePath));
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show($"Đã xảy ra lỗi khi xóa tệp ảnh: {ex.Message}", "Lỗi", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
            }
            else
            {
                MessageBox.Show("Vui lòng chọn một hình ảnh để xóa.", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
    }
}