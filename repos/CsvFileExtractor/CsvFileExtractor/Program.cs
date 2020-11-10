using System;

namespace CsvFileExtractor
{
    class Program
    {
        static void Main(string[] args)
        {
            string filename = "";
            if(args!=null && args[0]!="")
            {
                filename = args[0];
                //filename = @"C:\Users\dotnetcloudmc132\source\repos\CsvFileExtractor\Input File\emplyeeTimesheet.csv";
                FileProcessing f = new FileProcessing(filename);
                bool Issucess = f.ExtractFromCsv();
                if (Issucess)
                {
                    Console.WriteLine("File Processing completed Sucessfully");
                    Environment.Exit(0);
                }
                else
                {
                    Console.WriteLine("File Processing failed");
                    Environment.Exit(1);
                }

            }
            Environment.Exit(1);
        }
    }
}
