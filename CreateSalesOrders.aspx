<%@ Page Theme="Enterprise" MasterPageFile="~/masterpages/Enterprise.master" Language="VB" AutoEventWireup="true" CodeFile="CreateSalesOrders.aspx.vb" Inherits="CreateSalesOrders" %>

<%@ Register Assembly="EnterpriseASPClient" Namespace="EnterpriseASPClient.Core" TagPrefix="core" %>
<%@ Register Assembly="EnterpriseASPClient" Namespace="EnterpriseASPClient.Controls" TagPrefix="ctls" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="_header">
    <asp:Label ID="lblPageHeader" runat="server" Text="Orders List"></asp:Label>
</asp:Content>

<asp:Content ID="PageContent" runat="server" ContentPlaceHolderID="_mainContent">
    <!-- Minimal CSS for fast loading -->
    <style type="text/css">
        /* Modern CSS Variables */
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --light-bg: #f8f9fa;
            --border-radius: 8px;
            --box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Container Styles */
        .main-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin: 20px auto;
            padding: 20px;
            max-width: 1400px;
        }

        .page-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 15px;
            border-radius: var(--border-radius);
            margin-bottom: 20px;
            text-align: center;
        }

        .page-header h2 {
            margin: 0;
            font-weight: normal;
            font-size: 24px;
        }

        /* Action Panel */
        .action-panel {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 15px;
            margin-bottom: 20px;
            border-left: 4px solid var(--secondary-color);
        }

        /* Modern Buttons */
        .btn-modern {
            border-radius: 6px;
            padding: 8px 16px;
            font-weight: 500;
            border: none;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 2px;
            transition: background-color 0.3s ease;
        }

        .btn-success-modern {
            background-color: var(--success-color);
            color: white;
        }

        .btn-success-modern:hover {
            background-color: #229954;
        }

        .btn-danger-modern {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-danger-modern:hover {
            background-color: #c0392b;
        }

        .btn-warning-modern {
            background-color: var(--warning-color);
            color: white;
        }

        .btn-warning-modern:hover {
            background-color: #e67e22;
        }

        .btn-primary-modern {
            background-color: var(--secondary-color);
            color: white;
        }

        .btn-primary-modern:hover {
            background-color: #2980b9;
        }

        /* Modal Styles */
        .modern-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
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
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
            padding: 20px;
            min-width: 400px;
            max-width: 90%;
        }

        .modal-header-modern {
            border-bottom: 2px solid var(--light-bg);
            padding-bottom: 10px;
            margin-bottom: 15px;
        }

        .modal-header-modern h3 {
            margin: 0;
            color: var(--primary-color);
            font-weight: 600;
        }

        /* Grid Styles */
        .grid-container {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--box-shadow);
            margin-top: 15px;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 12px 8px;
            text-align: left;
            font-weight: 600;
        }

        table td {
            padding: 10px 8px;
            border-top: 1px solid #dee2e6;
            vertical-align: middle;
        }

        table tr:hover {
            background-color: #f8f9fa;
        }

        /* Form Controls */
        .form-control-modern {
            border-radius: 6px;
            border: 2px solid #e9ecef;
            padding: 10px 12px;
            width: 100%;
            font-family: inherit;
        }

        .form-control-modern:focus {
            border-color: var(--secondary-color);
            outline: none;
        }

        /* Alert Styles */
        .alert-modern {
            border-radius: var(--border-radius);
            border: none;
            padding: 12px 15px;
            font-weight: 500;
            margin: 10px 0;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }

        /* Utility Classes */
        .text-center { text-align: center; }
        .text-primary { color: var(--secondary-color); }
        .text-danger { color: var(--danger-color); }
        .fw-bold { font-weight: bold; }
        .mb-3 { margin-bottom: 1rem; }
        .mb-4 { margin-bottom: 1.5rem; }
        .me-2 { margin-right: 0.5rem; }
        .d-none { display: none; }
        .d-block { display: block; }
        .d-flex { display: flex; }
        .justify-content-center { justify-content: center; }
        .gap-3 { gap: 1rem; }
        .w-100 { width: 100%; }
        .mt-4 { margin-top: 1.5rem; }

        /* Responsive */
        @media (max-width: 768px) {
            .main-container {
                margin: 10px;
                padding: 15px;
            }
            
            .modal-content-modern {
                min-width: 300px;
                margin: 20px;
            }
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
                <p>Are you sure you want to revise this order?</p>
            </div>
            <div class="d-flex justify-content-center gap-3">
                <asp:Button ID="btnOk" CssClass="btn-success-modern btn-modern" runat="server" OnClick="btnOk_Click" Text="Confirm" />
                <asp:Button ID="btnCancel" CssClass="btn-danger-modern btn-modern" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
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
                <label><strong>Close Reason:</strong></label>
                <asp:TextBox ID="txtCLoseDetail" runat="server" CssClass="form-control-modern" 
                           TextMode="MultiLine" Rows="4" placeholder="Please provide reason for closing this order..."></asp:TextBox>
            </div>
            <div class="text-center mb-3">
                <asp:Label ID="lblCloseStatus" runat="server" CssClass="alert-modern d-none"></asp:Label>
            </div>
            <div class="d-flex justify-content-center gap-3">
                <asp:Button ID="btnClose" CssClass="btn-warning-modern btn-modern" runat="server" 
                          OnClick="btnClose_Click1" Text="Close Order" />
                <asp:Button ID="btnCloseCancel" CssClass="btn-danger-modern btn-modern" runat="server" 
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
                    <asp:Label runat="server" ID="lblMain" Text="Actions" CssClass="fw-bold" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:LinkButton ID="btnTrainingVideo1" runat="server" 
                        CssClass="btn-danger-modern btn-modern me-2" 
                        OnClientClick="window.open('https://www.prosyssoftech.com/TrainingVideos/SalesOrder.mp4', '_blank'); return false;" 
                        Text="Training Video 1" />
                    
                    <asp:LinkButton ID="btnTrainingVideo2" runat="server" 
                        CssClass="btn-danger-modern btn-modern me-2" 
                        OnClientClick="window.open('https://www.prosyssoftech.com/TrainingVideos/SalesOrder-1.mp4', '_blank'); return false;" 
                        Text="Training Video 2" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:LinkButton ID="btnPurchaseApproveAction" Text="Send For Approval" 
                        CssClass="btn-success-modern btn-modern me-2"
                        CommandName="batch:SalesApprove" CommandArgument="OrderHeaderGrid" 
                        runat="server" OnCommand="DBDataSource1.HandleCommand" />
                    
                    <ctls:ShowSearchButton ID="btnMainShowSearch" runat="server" SearchPanelID="MainSearchPanel" 
                        Text="Show Search" CssClass="btn-primary-modern btn-modern me-2" />
                    
                    <ctls:ChildLink ID="btnNewMain" runat="server" DataSourceID="DBDataSource1" 
                        TargetTable="OrderHeader" TargetUrl="OrderHeaderDetail.aspx" 
                        Text="New Order" CssClass="btn-success-modern btn-modern" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>

        <!-- Search Panel -->
        <ctls:SearchPanel ID="MainSearchPanel" runat="server" GridID="OrderHeaderGrid" 
            SearchButtonText="Search" ClearButtonText="Clear" 
            ExpressionLabel="Search Expression" Visible="False" 
            CssClass="mb-4 action-panel" />

        <!-- Orders Grid -->
        <div class="grid-container">
            <asp:GridView ID="OrderHeaderGrid" runat="server" DataMember="OrderHeader" DataSourceID="DBDataSource1" 
                AutoGenerateColumns="False" DataKeyNames="CompanyID,DivisionID,DepartmentID,OrderNumber" 
                OnRowCommand="DBDataSource1.HandleGridCommand" CssClass="w-100">
                <Columns>
                    <ctls:SelectionField HeaderText="Select" />
                    
                    <ctls:ChildLinkField ImageUrl="~/images/edit.gif" HeaderText="Edit" TargetUrl="OrderHeaderDetail.aspx">
                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                    </ctls:ChildLinkField>
                    
                    <ctls:ChildLinkField ImageUrl="~/images/print.gif" TargetUrl='../../Reports/DocOrderNew.aspx' 
                        Target="_blank" HeaderText="Print">
                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                    </ctls:ChildLinkField>
                    
                    <ctls:ChildLinkField ImageUrl="~/images/print.gif" HeaderText="Stock" 
                        TargetUrl='../../NewASPXReports/NewQuotationAndOrderStockReport.aspx?Type=Order' Target="_blank">
                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                    </ctls:ChildLinkField>
                    
                    <ctls:ChildLinkField ImageUrl="~/images/return.gif" TargetUrl='../../SqlServerReports/OrderFileAttachemnt.aspx' 
                        Target="_blank" HeaderText="Files">
                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                    </ctls:ChildLinkField>
                    
                    <ctls:ChildLinkField ImageUrl="~/images/print.gif" TargetUrl='../../reports/DocNewRevDetails.aspx' 
                        Target="_blank" HeaderText="Rev Details">
                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                    </ctls:ChildLinkField>
                    
                    <asp:BoundField HeaderText="Order Number" DataField="OrderNumber" SortExpression="OrderNumber" ReadOnly="true">
                        <ItemStyle CssClass="fw-bold text-primary" />
                    </asp:BoundField>
                    
                    <asp:BoundField HeaderText="Rev Number" DataField="RevisionNumber" SortExpression="RevisionNumber" ReadOnly="true" />
                    
                    <asp:BoundField HeaderText="Order Date" DataField="OrderDate" SortExpression="OrderDate" 
                        DataFormatString="{0:MMM dd, yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" ReadOnly="true" />
                    
                    <asp:BoundField HeaderText="Customer Name" DataField="ShippingName" SortExpression="ShippingName" ReadOnly="true" />
                    
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
                                CssClass="btn-primary-modern btn-modern" 
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

    <!-- Simplified JavaScript -->
    <script type="text/javascript">
        // Modal handling
        function showModal(modalId) {
            try {
                var modal = document.getElementById(modalId);
                if (modal) {
                    modal.style.display = 'block';
                }
            } catch (e) {
                console.log('Error showing modal: ' + e.message);
            }
        }

        function hideModal(modalId) {
            try {
                var modal = document.getElementById(modalId);
                if (modal) {
                    modal.style.display = 'none';
                }
            } catch (e) {
                console.log('Error hiding modal: ' + e.message);
            }
        }

        // Simple alert function
        function showAlert(message, type) {
            alert(message);
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            try {
                var modals = document.getElementsByClassName('modern-modal');
                for (var i = 0; i < modals.length; i++) {
                    if (event.target === modals[i]) {
                        modals[i].style.display = 'none';
                    }
                }
            } catch (e) {
                console.log('Error in modal click handler: ' + e.message);
            }
        };
    </script>
</asp:Content>