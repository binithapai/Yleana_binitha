<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="WebApplication2.About" %>

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

<div>
  <table style="width:100%;" >
            <tbody>
                <tr>
                    <th style="width:100px; font-style:italic; color:Red" >Enter data to be added</th>
                   
                </tr>
                </tbody>
            <%--<tr>
                <td>CustomerID (int):</td>
                <td>
                    <input data-bind="value: CustomerID" />
                    </td> <!--,valueUpdate:'keypress'-->
                <td><span data-bind="text: CustomerID" /></td>
            </tr>--%>
            <tr>
                <td>CustomerName :</td>
                <td>
                    <input data-bind="value: CustomerName" /></td>
                <td  ><span data-bind="text: CustomerName" /></td>
            </tr>
            <tr>
                <td>ContactName :</td>
                <td>
                    <input data-bind="value:ContactName" /></td>
                <td><span data-bind="text: ContactName" /></td>
            </tr>
            
            <tr>
                <td>Address :</td>
                <td>
                    <input data-bind="value: Address" /></td>
                <td><span data-bind="text: Address" /></td>
            </tr>
            
            <tr>
                <td>City :</td>
                <td>
                    <input data-bind="value: City" /></td>
                <td><span data-bind="text: City" /></td>
            </tr>
            <tr>
                <td>Postalcode :</td>
                <td>
                    <input data-bind="value: Postalcode " /></td>
                <td><span data-bind="text: Postalcode " /></td>
            </tr>
            <tr>
                <td>Country :</td>
                <td>
                    <input data-bind="value: Country" /></td>
                <td><span data-bind="text: Country" /></td>
            </tr>
           
            <tr>
                <td colspan="3">
                    <button type="button"  data-bind="click: AddCustomer" >Add Customer</button>
                    <button type="button" data-bind="click: SaveCustomer">Save Customer To Database</button>
                </td>
            </tr>

        </table>
            </div>
  
  

<div style="width:10%;float:left;display:inline-block;">

   <button type="button" data-bind="click: GetCustomer"> Get data</button>
           
        <table style="width:auto" data-bind="visible:Customers().length > 0" border="0">
            <tr>
                <th>CustomerID</th>
                <th>CustomerName</th>
                <th>ContactName</th>
                <th>Address</th>
                <th>City</th>
                <th>Postalcode</th>
                <th>Country</th>
            </tr>
            <tbody data-bind="foreach: Customers">
                <tr>
                    <td><span data-bind="text: CustomerID" style="width:70px"/></td>
                    <td>
                        <input data-bind="value: CustomerName" style="width:150px" /></td>
                    <td>
                        <input data-bind="value: ContactName" style="width:110px" /></td>
                    <td>
                        <input data-bind="value: Address" style="width:150px" /></td>
                   
                   
                       <td> <input data-bind="value:City"  style="width:70px"/></td>
                    <td>
                        <input data-bind="value:Postalcode" style="width:70px" /></td>
                    <td>
                        <input data-bind="value: Country"  style="width:70px"/></td>
                   
                   
                </tr>
            </tbody>
        </table>
</div>

 
  
  
   
<script type="text/javascript">



    function Customers(data) {
        this.CustomerID = ko.observable(data.CustomerID);
        this.CustomerName = ko.observable(data.CustomerName);
        this.ContactName= ko.observable(data.ContactName);
        this.Address = ko.observable(data.Address);
        this.City = ko.observable(data.City);
        this.Postalcode = ko.observable(data.Postalcode);
    
        this.Country = ko.observable(data.Country);
       
    }

    function CustomerViewModel() {
        var self = this;

        self.Customers = ko.observableArray([]);
       // self.Customers=ko.observable({});
        self.CustomerID = ko.observable();
        self.CustomerName = ko.observable();
        self.ContactName = ko.observable();
        self.Address = ko.observable();
        self.City = ko.observable();
        self.Postalcode = ko.observable();
        self.Country = ko.observable();



        self.AddCustomer = function () {
        self.Customers.push(new Customers({
                        
        CustomerID : self.CustomerID(),
        CustomerName:self.CustomerName(),
        ContactName:self.ContactName(), 
        Address: self.Address(),
        City:self.City(),
        Postalcode:self.Postalcode(),
        Country:self.Country() 
                    })).toString();
                    self.CustomerID(""),
                 self.CustomerName(""),
                 self.ContactName(""),
                 self.Address(""),
                 self.City(""),
                 self.Postalcode(""),
                 self.Country("")
                };



                self.SaveCustomer = function () {
                   
                    $.ajax({
                        type: "Post",
                        url: "CustomerService.asmx/SaveCustomer",
                        data: "{custdata:" + ko.toJSON(self.Customers)+ "}",
                       // data: $.parseJSON(JSON.stringify({ custdata: jdata })),
                        contentType: "application/json; charset=utf-8",
                        //dataType: "json",
                        success: function () {
                            GetCustomers();
                        },
                        error: function (err) {
                            //                            alert(custdata);
                            alert(err.status + " ------ " + err.statusText);
                        }
                    });
                };

        self.GetCustomer = function () {
            $.ajax({
                type: "POST",
                url: 'CustomerService.asmx/GetCustomers',
                //contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var newcust = $.map(result, function (item) {
                        return new Customers(item)
                    });
                    self.Customers(newcust);
                },
                error: function (err) {
                    alert(err.status + " - " + err.statusText);
                }
            })
        }
    }
        $(document).ready(function () {
            ko.applyBindings(new CustomerViewModel());
        });
    
</script>
   
</asp:Content>
