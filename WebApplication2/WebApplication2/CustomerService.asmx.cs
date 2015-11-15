using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Data;

namespace WebApplication2
{
    /// <summary>
    /// Summary description for CustomerService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class CustomerService : System.Web.Services.WebService
    {
        [WebMethod]
        public void GetCustomers()
        {

            List<Customers> listcustomer = new List<Customers>();

            string cs = ConfigurationManager.ConnectionStrings["YleanaConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Select * from Customers", con);
                con.Open();
                //cmd.CommandType = CommandType.StoredProcedure;

                //SqlParameter parameter = new SqlParameter();
                //parameter.ParameterName = "@Id";
                //parameter.Value = employeeId;

                //cmd.Parameters.Add(parameter);

                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Customers cust = new Customers();
                    cust.CustomerID = Convert.ToInt32(rdr["CustomerID"]);
                    cust.CustomerName = rdr["CustomerName"].ToString();
                    cust.ContactName = rdr["ContactName"].ToString();
                    cust.Address = rdr["Address"].ToString();
                    cust.City = rdr["City"].ToString();
                    cust.Postalcode = rdr["Postalcode"].ToString();
                    cust.Country = rdr["Country"].ToString();
                    listcustomer.Add(cust);

                }

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(listcustomer));
            //return listcustomer;

            //return new JavaScriptSerializer().Serialize(listcustomer);


        }


       [System.Web.Services.WebMethod]
        public void SaveCustomer(List<Customers> custdata)
        {
            string cs = ConfigurationManager.ConnectionStrings["YleanaConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("spaddcustomer", con);
                cmd.CommandType = CommandType.StoredProcedure;
               
                    
                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@CustomerName",
                    Value = custdata[0].CustomerName
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@ContactName",
                    Value = custdata[0].ContactName
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Address",
                    Value = custdata[0].Address
                });
                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@City",
                    Value = custdata[0].City
                });
                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Postalcode",
                    Value = custdata[0].Postalcode
                });
                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Country",
                    Value = custdata[0].Country
                });
               
                cmd.ExecuteNonQuery();
                con.Close();
            }

           //return custdata;
        }
    }
}
