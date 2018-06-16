using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Xml;
using System.IO;


namespace BIS_Yahoo_Weather_Feed
{
    class Program
    {
        
        static void Main(string[] args)
        {
            
            List<string> Locations = Get_Locations();
            List<Weather> Weather = new List<Weather>();

            string SaveFile = ConfigurationManager.AppSettings["SaveFolder"] + "Yahoo_Weather_" + DateTime.Now.ToString("yyyy-MM-dd") + ".csv";

            foreach (string location in Locations)
            {
                Weather.Add(Get_Weather(location));
            }


            WriteCSV(Weather, SaveFile);

            //Console.ReadLine();
        }

        public static List<string> Get_Locations()
        {
            List<string> Locations = new List<string>();

            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Dune_Data_Warehouse"].ConnectionString);
            SqlCommand command = new SqlCommand("SELECT DISTINCT Yahoo_WOEID FROM Store_Dim WHERE Yahoo_WOEID <> ''");
            SqlDataReader reader = null;

            connection.Open();
            command.Connection = connection;
            reader = command.ExecuteReader();

            while (reader.Read())
            {
                Locations.Add(reader[0].ToString());
            }

            return Locations;
        }

        //public static void Get_XML(string location, string destination)
        //{
        //    WebClient web = new WebClient();
            
        //    string url = @"http://weather.yahooapis.com/forecastrss?u=c&w=" + location;
        //    destination += location + ".xml";

        //    web.DownloadFile(url, destination);
        //}

        public static Weather Get_Weather(string location)
        {
            Weather w = new Weather();

            XmlDocument doc = new XmlDocument();
            doc.Load("http://weather.yahooapis.com/forecastrss?u=c&w=" + location);
            XmlNamespaceManager ns = new XmlNamespaceManager(doc.NameTable);
            ns.AddNamespace("yweather", "http://xml.weather.yahoo.com/ns/rss/1.0");
            XmlNodeList nodes = doc.SelectNodes("/rss/channel/item/yweather:condition", ns);

            w.Location = location;
            w.Condition = nodes[0].Attributes["text"].InnerText;
            w.Temperature = int.Parse(nodes[0].Attributes["temp"].InnerText);

            return w;
        }

        public static void WriteCSV(List<Weather> weather, string path)
        {
            using (var file = File.CreateText(path))
            {
                foreach (Weather w in weather)
                {
                    file.WriteLine(w.Location + "," + w.Condition + "," + w.Temperature.ToString());
                }
            }
        }

    }

    public class Weather
    {
        public string Location { get; set; }
        public string Condition { get; set; }
        public int Temperature { get; set; }
    }
}
