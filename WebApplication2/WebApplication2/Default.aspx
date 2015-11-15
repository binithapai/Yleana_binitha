<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="Scripts/knockout-3.3.0.js" type="text/javascript"></script>
    <script src="Scripts/knockout-1.1.2.js" type="text/javascript"></script>
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="Scripts/knockout-2.2.1.js" type="text/javascript"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/knockout/knockout-2.2.1.js" type="text/javascript"></script>
    <script src="Scripts/knockout-min.js" type="text/javascript"></script>
    <script src="Scripts/knockout-2.0.0.debug.js" type="text/javascript"></script>
    

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <p>Firstname:<span data-bind ="text:firstName"></span></p>
   <div class='liveExample'>   
    <p>First name: <input data-bind='value: firstName' /></p> 
    <p>Last name: <input data-bind='value: lastName' /></p> 
    <h2>Hello, <span data-bind='text: fullName'> </span>!</h2>  
   </div>

   <input type="button" id="btnGetCustomers" value="Get All Customers" />
    <br /><br />
    <table id="tblCustomer" border="1" style="border-collapse:collapse">
        <thead>
            <tr>
                <th>CustomerID</th>
                <th>CustomerName</th>
                <th>ContactName</th>
                <th>Address</th>
                <th>City</th>
                <th>Postalcode</th>
                <th>Country</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>


     <table border="1" style="border-collapse:collapse">
        <tr>
            <td>customerName</td>
            <td><input id="txtName" type="text" /></td>
        </tr>
        <tr>
            <td>contactname</td>
            <td><input id="txtcontact" type="text" /></td>
        </tr>
        <tr>
            <td>address</td>
            <td><input id="txtaddress" type="text" /></td>
        </tr>

        <tr>
            <td>city</td>
            <td><input id="txtcity" type="text" /></td>
        </tr>
        <tr>
            <td>postalcode</td>
            <td><input id="txtpostalcode" type="text" /></td>
        </tr>
        <tr>
            <td>country</td>
            <td><input id="txtcountry" type="text" /></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="button" id="btnAddEmployee" value="Add customer" />
            </td>
        </tr>
    </table>


        <script type="text/javascript">
            var obj = { firstName: "Myname",
                lastName: "newname",
                fullName:"mynewname"
            };
            ko.applyBindings(obj);
            $(document).ready(function () {


                $('#btnAddEmployee').click(function () {
                    var Customers = {};
                    Customers.CustomerName = $('#txtName').val();
                    Customers.ContactName = $('#txtcontact').val();
                    Customers.Address = $('#txtaddress').val();
                    Customers.City = $('#txtcity').val();
                    Customers.Postalcode = $('#txtpostalcode').val(); 
                    Customers.Country = $('#txtcountry').val();

                    $.ajax({
                        url: "CustomerService.asmx/SaveCustomer",
                        type: 'post',
                        //dataType: "json",
                        data: "{custdata: " +JSON.stringify(Customers)+"}",
                        contentType: "application/json; charset=utf-8",
                        success: function () {
                            GetCustomers();
                        },
                        error: function (err) {
                            alert(err.status + " ------ " + err.statusText);
                        }
                    });
                });







            
             $('#btnGetCustomers').click(function () {
                $.ajax({
                    url: 'CustomerService.asmx/GetCustomers',
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                    
                        var customerTable = $('#tblCustomer tbody');
                        customerTable.empty();

                        $(data).each(function (index, cus) {
                            customerTable.append('<tr><td>' + cus.CustomerID + '</td><td>'
                                + cus.CustomerName + '</td><td>' + cus.ContactName
                                + '</td><td>' +cus.Address +'</td><td> '+cus.City+'</td><td>'
                                +cus.Postalcode+'</td><td>'+cus.Country+'</td></tr>');
                        });
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            });
        });
            
            
            
            
             //});
   
    </script>
        

   
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:YleanaConnectionString %>" 
    SelectCommand="SELECT * FROM [Customers]"></asp:SqlDataSource>
    <br />
    
   
</asp:Content>
