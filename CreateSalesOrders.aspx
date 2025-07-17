<%@ Page Theme="Enterprise" MasterPageFile="~/masterpages/Enterprise.master" Language="VB" AutoEventWireup="true" CodeFile="CreateSalesOrders.aspx.vb" Inherits="CreateSalesOrders" %>

<%@ Register Assembly="EnterpriseASPClient" Namespace="EnterpriseASPClient.Core" TagPrefix="core" %>
<%@ Register Assembly="EnterpriseASPClient" Namespace="EnterpriseASPClient.Controls" TagPrefix="ctls" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="_header">
    <asp:Label ID="lblPageHeader" runat="server" Text="Orders List"></asp:Label>
</asp:Content>

<asp:Content ID="PageContent" runat="server" ContentPlaceHolderID="_mainContent">
    <!-- Modern CSS and JS Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.min.css" rel="stylesheet" />
    
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.all.min.js"></script>

    <!-- Custom Styles -->
    <style type="text/css">
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --light-bg: #f8f9fa;
            --border-radius: 12px;
            --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin: 20px auto;
            padding: 30px;
            max-width: 1400px;
        }

        .page-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
            text-align: center;
        }

        .page-header h2 {
            margin: 0;
            font-weight: 300;
        }

        .action-panel {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 30px;
            border-left: 4px solid var(--secondary-color);
        }

        .btn-modern {
            border-radius: 8px;
            padding: 8px 20px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .btn-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .btn-success-modern {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
        }

        .btn-danger-modern {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        .btn-warning-modern {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        .btn-primary-modern {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }

        /* Modern Modal Styles */
        .modern-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(5px);
            z-index: 9999;
            display: none;
        }

        .modal-content-modern {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border-radius: var(--border-radius);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            padding: 30px;
            min-width: 400px;
            animation: modalSlideIn 0.3s ease;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translate(-50%, -60%);
            }
            to {
                opacity: 1;
                transform: translate(-50%, -50%);
            }
        }

        .modal-header-modern {
            border-bottom: 2px solid var(--light-bg);
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .modal-header-modern h3 {
            margin: 0;
            color: var(--primary-color);
            font-weight: 600;
        }

        /* GridView Modern Styling */
        .grid-container {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--box-shadow);
        }

        .table-modern {
            margin: 0;
        }

        .table-modern thead {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
        }

        .table-modern thead th {
            border: none;
            padding: 15px 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9em;
        }

        .table-modern tbody tr {
            transition: background-color 0.2s ease;
        }

        .table-modern tbody tr:hover {
            background-color: #f8f9fa;
        }

        .table-modern tbody td {
            padding: 12px;
            border-top: 1px solid #dee2e6;
            vertical-align: middle;
        }

        .action-btn {
            width: 32px;
            height: 32px;
            border-radius: 6px;
            border: none;
            margin: 0 2px;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .action-btn:hover {
            transform: scale(1.1);
        }

        .training-video-btn {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .form-control-modern {
            border-radius: 8px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: border-color 0.3s ease;
        }

        .form-control-modern:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .alert-modern {
            border-radius: var(--border-radius);
            border: none;
            padding: 15px 20px;
            font-weight: 500;
        }
    </style>

    <!-- Revision Confirmation Modal -->
    <div id="revisionModal" class="modern-modal" runat="server">
        <div class="modal-content-modern">
            <div class="modal-header-modern">
                <h3>Order Revision Confirmation</h3>
            </div>
            <div class="text-center mb-3">
                <h4>Order <asp:Label ID="lblOrderNumber" runat="server" CssClass="text-primary fw-bold"></asp:Label></h4>
            </div>
            <div class="text-center mb-4">
                <p class="lead">Are you sure you want to revise this order?</p>
            </div>
            <div class="d-flex justify-content-center gap-3">
                <asp:Button ID="btnOk" CssClass="btn btn-success-modern btn-modern" runat="server" OnClick="btnOk_Click" Text="Confirm" />
                <asp:Button ID="btnCancel" CssClass="btn btn-danger-modern btn-modern" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
            </div>
        </div>
    </div>

    <!-- Close Order Modal -->
    <div id="closeModal" class="modern-modal" runat="server">
        <div class="modal-content-modern">
            <div class="modal-header-modern">
                <h3>Close Order</h3>
            </div>
            <div class="text-center mb-3">
                <h4>Order: <asp:Label ID="lblCloseOrderNumber" runat="server" CssClass="text-danger fw-bold"></asp:Label></h4>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Close Reason:</label>
                <asp:TextBox ID="txtCLoseDetail" runat="server" CssClass="form-control form-control-modern" 
                           TextMode="MultiLine" Rows="4" placeholder="Please provide reason for closing this order..."></asp:TextBox>
            </div>
            <div class="text-center mb-3">
                <asp:Label ID="lblCloseStatus" runat="server" CssClass="alert alert-modern d-none"></asp:Label>
            </div>
            <div class="d-flex justify-content-center gap-3">
                <asp:Button ID="btnClose" CssClass="btn btn-warning-modern btn-modern" runat="server" 
                          OnClick="btnClose_Click1" Text="Close Order" />
                <asp:Button ID="btnCloseCancel" CssClass="btn btn-danger-modern btn-modern" runat="server" 
                          OnClick="btnCloseCancel_Click" Text="Cancel" />
            </div>
        </div>
    </div>

    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <h2>Sales Orders Management</h2>
        </div>

        <!-- Data Sources -->
        <core:DBDataSource ID="DBDataSource1" runat="server" ObjectName="CreateSalesOrders" TableName="OrderHeader"/>
        
        <core:ClientCallbackControl ID="ClientCallbackControl1" runat="server">
            <Callbacks>
                <core:CallbackLink Source="btnMainShowSearch" DataFieldSource="" DataFieldTarget="" DataViewTarget="" Target="MainSearchPanel" />
            </Callbacks>
        </core:ClientCallbackControl>

        <!-- Action Panel -->
        <asp:Table runat="server" ID="tblMain" CssClass="action-panel w-100">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label runat="server" ID="lblMain" Text="Actions" CssClass="h4 mb-0" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <div class="btn-group me-2">
                        <button type="button" class="training-video-btn dropdown-toggle" data-bs-toggle="dropdown">
                            Training Videos
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" onclick="window.open('https://www.prosyssoftech.com/TrainingVideos/SalesOrder.mp4', '_blank'); return false;">Sales Order Tutorial 1</a></li>
                            <li><a class="dropdown-item" href="#" onclick="window.open('https://www.prosyssoftech.com/TrainingVideos/SalesOrder-1.mp4', '_blank'); return false;">Sales Order Tutorial 2</a></li>
                        </ul>
                    </div>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:LinkButton ID="btnPurchaseApproveAction" Text="Send For Approval" 
                        CssClass="btn btn-success-modern btn-modern me-2"
                        CommandName="batch:SalesApprove" CommandArgument="OrderHeaderGrid" 
                        runat="server" OnCommand="DBDataSource1.HandleCommand" />
                    
                    <ctls:ShowSearchButton ID="btnMainShowSearch" runat="server" SearchPanelID="MainSearchPanel" 
                        Text="Show Search" CssClass="btn btn-primary-modern btn-modern me-2" />
                    
                    <ctls:ChildLink ID="btnNewMain" runat="server" DataSourceID="DBDataSource1" 
                        TargetTable="OrderHeader" TargetUrl="OrderHeaderDetail.aspx" 
                        Text="New Order" CssClass="btn btn-success-modern btn-modern" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>

        <!-- Search Panel -->
        <ctls:SearchPanel ID="MainSearchPanel" runat="server" GridID="OrderHeaderGrid" 
            SearchButtonText="Search" ClearButtonText="Clear" 
            ExpressionLabel="Search Expression" Visible="False" 
            CssClass="mb-4 p-3 bg-light rounded" />

        <!-- Orders Grid -->
        <div class="grid-container">
            <asp:GridView ID="OrderHeaderGrid" runat="server" DataMember="OrderHeader" DataSourceID="DBDataSource1" 
                AutoGenerateColumns="False" DataKeyNames="CompanyID,DivisionID,DepartmentID,OrderNumber" 
                OnRowCommand="DBDataSource1.HandleGridCommand" CssClass="table table-modern table-hover w-100">
                <Columns>
                    <ctls:SelectionField HeaderText="Select" />
                    
                    <ctls:ChildLinkField ImageUrl="~/images/edit.gif" HeaderText="Edit" TargetUrl="OrderHeaderDetail.aspx">
                        <ItemStyle Width="40px" CssClass="text-center" />
                    </ctls:ChildLinkField>
                    
                    <ctls:ChildLinkField ImageUrl="~/images/print.gif" TargetUrl='../../Reports/DocOrderNew.aspx' 
                        Target="_blank" HeaderText="Print">
                        <ItemStyle Width="40px" CssClass="text-center" />
                    </ctls:ChildLinkField>
                    
                    <ctls:ChildLinkField ImageUrl="~/images/print.gif" HeaderText="Stock" 
                        TargetUrl='../../NewASPXReports/NewQuotationAndOrderStockReport.aspx?Type=Order' Target="_blank">
                        <ItemStyle Width="40px" CssClass="text-center" />
                    </ctls:ChildLinkField>
                    
                    <ctls:ChildLinkField ImageUrl="~/images/return.gif" TargetUrl='../../SqlServerReports/OrderFileAttachemnt.aspx' 
                        Target="_blank" HeaderText="Files">
                        <ItemStyle Width="40px" CssClass="text-center" />
                    </ctls:ChildLinkField>
                    
                    <ctls:ChildLinkField ImageUrl="~/images/print.gif" TargetUrl='../../reports/DocNewRevDetails.aspx' 
                        Target="_blank" HeaderText="Rev Details">
                        <ItemStyle Width="40px" CssClass="text-center" />
                    </ctls:ChildLinkField>
                    
                    <asp:BoundField HeaderText="Order Number" DataField="OrderNumber" SortExpression="OrderNumber" ReadOnly="true">
                        <ItemStyle CssClass="fw-bold text-primary" />
                    </asp:BoundField>
                    
                    <asp:BoundField HeaderText="Rev Number" DataField="RevisionNumber" SortExpression="RevisionNumber" ReadOnly="true" />
                    
                    <asp:BoundField HeaderText="Order Date" DataField="OrderDate" SortExpression="OrderDate" 
                        DataFormatString="{0:MMM dd, yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" ReadOnly="true" />
                    
                    <asp:BoundField HeaderText="Customer Name" DataField="ShippingName" SortExpression="ShippingName" ReadOnly="true">
                        <ItemStyle CssClass="fw-semibold" />
                    </asp:BoundField>
                    
                    <asp:BoundField HeaderText="Customer P.O. No" DataField="PurchaseOrderNumber" SortExpression="PurchaseOrderNumber" ReadOnly="true" />
                    
                    <asp:BoundField HeaderText="Delivery Date" DataField="OrderShipDate" SortExpression="OrderShipDate" 
                        DataFormatString="{0:MMM dd, yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                    
                    <asp:BoundField HeaderText="Ref.Quot No" DataField="RefQuotationNo" SortExpression="RefQuotationNo" 
                        HtmlEncode="false" ApplyFormatInEditMode="true" />
                    
                    <asp:BoundField HeaderText="Employee" DataField="EmployeeID" SortExpression="EmployeeID" ReadOnly="true" />
                    
                    <asp:TemplateField HeaderText="Close" ShowHeader="False">
                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                        <ItemTemplate>
                            <asp:ImageButton ID="btnClose" ImageUrl="~/images/Close.png" Width="20px" Height="20px" 
                                CausesValidation="false" CommandArgument='<%# Eval("OrderNumber") %>' 
                                OnCommand="btnClose_Command" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Items">
                        <ItemStyle HorizontalAlign="Center" Width="120px" />
                        <ItemTemplate>
                            <asp:Button ID="btnTicketAndSelect" runat="server" 
                                CssClass="btn btn-sm btn-primary-modern btn-modern" 
                                Text="Manage Items" CommandArgument='<%# Eval("OrderNumber") %>' 
                                OnClick="btnTicketAndSelect_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- Action Panel Footer -->
        <div class="mt-4">
            <ctls:ActionPanel ID="ActionPanel1" runat="server" DataSourceID="DBDataSource1" 
                CssClass="action-panel" />
        </div>
    </div>

    <script type="text/javascript">
        // Modern modal handling
        function showModal(modalId) {
            document.getElementById(modalId).style.display = 'block';
            document.body.style.overflow = 'hidden';
        }

        function hideModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        // Enhanced alert function
        function showAlert(message, type) {
            if (typeof type === 'undefined') type = 'info';
            Swal.fire({
                title: type === 'error' ? 'Error' : 'Information',
                text: message,
                icon: type,
                confirmButtonText: 'OK',
                customClass: {
                    confirmButton: 'btn btn-primary-modern btn-modern'
                }
            });
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            var modals = document.querySelectorAll('.modern-modal');
            for (var i = 0; i < modals.length; i++) {
                if (event.target === modals[i]) {
                    hideModal(modals[i].id);
                }
            }
        }

        // Initialize page when DOM is ready
        document.addEventListener('DOMContentLoaded', function() {
            // Add loading states to buttons
            var buttons = document.querySelectorAll('.btn');
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].addEventListener('click', function() {
                    if (!this.classList.contains('no-loading')) {
                        var originalText = this.innerHTML;
                        this.innerHTML = 'Processing...';
                        this.disabled = true;
                        
                        // Re-enable after 3 seconds to prevent permanent disable
                        setTimeout(function() {
                            this.innerHTML = originalText;
                            this.disabled = false;
                        }.bind(this), 3000);
                    }
                });
            }
        });
    </script>
</asp:Content>