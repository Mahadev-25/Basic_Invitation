<%@ Page Language="VB" AutoEventWireup="true" CodeFile="ModernSalesOrders.aspx.vb" Inherits="ModernSalesOrders" %>

<%@ Register Assembly="EnterpriseASPClient" Namespace="EnterpriseASPClient.Core" TagPrefix="core" %>
<%@ Register Assembly="EnterpriseASPClient" Namespace="EnterpriseASPClient.Controls" TagPrefix="ctls" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Modern Sales Orders Management</title>
    
    <!-- Modern CSS Styles -->
    <style type="text/css">
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
            line-height: 1.6;
        }

        /* CSS Variables for Consistent Theming */
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --info-color: #17a2b8;
            --light-bg: #f8f9fa;
            --border-radius: 8px;
            --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        /* Main Container */
        .main-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin: 20px auto;
            padding: 30px;
            max-width: 1400px;
            min-height: calc(100vh - 40px);
        }

        /* Header Styles */
        .page-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--box-shadow);
        }

        .page-header h1 {
            margin: 0;
            font-size: 28px;
            font-weight: 300;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .page-header .subtitle {
            margin-top: 8px;
            font-size: 16px;
            opacity: 0.9;
        }

        /* Action Panel */
        .action-panel {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 25px;
            border-left: 4px solid var(--secondary-color);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .action-header {
            font-size: 18px;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        /* Modern Button Styles */
        .btn-modern {
            border-radius: 6px;
            padding: 10px 20px;
            font-weight: 500;
            border: none;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 3px;
            transition: var(--transition);
            font-size: 14px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .btn-modern:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .btn-success-modern {
            background: linear-gradient(135deg, var(--success-color), #2ecc71);
            color: white;
        }

        .btn-danger-modern {
            background: linear-gradient(135deg, var(--danger-color), #c0392b);
            color: white;
        }

        .btn-warning-modern {
            background: linear-gradient(135deg, var(--warning-color), #e67e22);
            color: white;
        }

        .btn-primary-modern {
            background: linear-gradient(135deg, var(--secondary-color), #2980b9);
            color: white;
        }

        .btn-info-modern {
            background: linear-gradient(135deg, var(--info-color), #138496);
            color: white;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
        }

        /* Modal Styles */
        .modern-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 9999;
            display: none;
            backdrop-filter: blur(3px);
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
            min-width: 450px;
            max-width: 90%;
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
            font-size: 22px;
        }

        /* Grid Container */
        .grid-container {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--box-shadow);
            margin-top: 20px;
        }

        /* Enhanced Table Styling */
        .modern-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        .modern-table thead th {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 15px 10px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 12px;
            border: none;
        }

        .modern-table tbody td {
            padding: 12px 10px;
            border-top: 1px solid #dee2e6;
            vertical-align: middle;
        }

        .modern-table tbody tr {
            transition: background-color 0.2s ease;
        }

        .modern-table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .modern-table tbody tr:nth-child(even) {
            background-color: #fafafa;
        }

        .modern-table tbody tr:nth-child(even):hover {
            background-color: #f0f0f0;
        }

        /* Action Buttons in Table */
        .action-btn {
            width: 28px;
            height: 28px;
            border-radius: 4px;
            border: none;
            margin: 0 1px;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .action-btn:hover {
            transform: scale(1.1);
        }

        .action-btn img {
            width: 16px;
            height: 16px;
        }

        /* Form Controls */
        .form-control-modern {
            border-radius: 6px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            width: 100%;
            font-family: inherit;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .form-control-modern:focus {
            border-color: var(--secondary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--primary-color);
        }

        /* Alert Styles */
        .alert-modern {
            border-radius: var(--border-radius);
            border: none;
            padding: 15px 20px;
            font-weight: 500;
            margin: 15px 0;
            border-left: 4px solid;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border-left-color: var(--danger-color);
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-left-color: var(--success-color);
        }

        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border-left-color: var(--warning-color);
        }

        /* Search Panel Styling */
        .search-panel {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: var(--border-radius);
            padding: 15px;
            margin-bottom: 20px;
        }

        /* Utility Classes */
        .text-center { text-align: center; }
        .text-left { text-align: left; }
        .text-right { text-align: right; }
        .text-primary { color: var(--secondary-color); }
        .text-danger { color: var(--danger-color); }
        .text-success { color: var(--success-color); }
        .fw-bold { font-weight: bold; }
        .fw-semibold { font-weight: 600; }
        .mb-3 { margin-bottom: 1rem; }
        .mb-4 { margin-bottom: 1.5rem; }
        .mt-4 { margin-top: 1.5rem; }
        .me-2 { margin-right: 0.5rem; }
        .ms-2 { margin-left: 0.5rem; }
        .d-none { display: none; }
        .d-block { display: block; }
        .d-flex { display: flex; }
        .d-inline-block { display: inline-block; }
        .justify-content-center { justify-content: center; }
        .justify-content-between { justify-content: space-between; }
        .align-items-center { align-items: center; }
        .gap-3 { gap: 1rem; }
        .w-100 { width: 100%; }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                margin: 10px;
                padding: 20px;
            }
            
            .modal-content-modern {
                min-width: 320px;
                margin: 20px;
                padding: 20px;
            }
            
            .modern-table {
                font-size: 12px;
            }
            
            .modern-table thead th,
            .modern-table tbody td {
                padding: 8px 6px;
            }
            
            .btn-modern {
                padding: 8px 12px;
                font-size: 12px;
            }
        }

        @media (max-width: 480px) {
            .page-header h1 {
                font-size: 22px;
            }
            
            .modal-content-modern {
                min-width: 280px;
            }
        }

        /* Loading Animation */
        .loading {
            opacity: 0.6;
            pointer-events: none;
        }

        .spinner {
            border: 2px solid #f3f3f3;
            border-top: 2px solid var(--secondary-color);
            border-radius: 50%;
            width: 20px;
            height: 20px;
            animation: spin 1s linear infinite;
            display: inline-block;
            margin-right: 8px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- Page Header -->
        <div class="page-header">
            <h1>Modern Sales Orders Management System</h1>
            <div class="subtitle">Streamlined order processing and management</div>
        </div>

        <!-- Revision Confirmation Modal -->
        <div id="revisionModal" class="modern-modal" runat="server">
            <div class="modal-content-modern">
                <div class="modal-header-modern">
                    <h3>🔄 Order Revision Confirmation</h3>
                </div>
                <div class="text-center mb-3">
                    <h4>Order: <asp:Label ID="lblOrderNumber" runat="server" CssClass="text-primary fw-bold"></asp:Label></h4>
                </div>
                <div class="text-center mb-4">
                    <p style="font-size: 16px;">Are you sure you want to revise this order?</p>
                    <p style="color: #666; font-size: 14px;">This action will create a new revision of the order.</p>
                </div>
                <div class="d-flex justify-content-center gap-3">
                    <asp:Button ID="btnOk" CssClass="btn-success-modern btn-modern" runat="server" OnClick="btnOk_Click" Text="✓ Confirm Revision" />
                    <asp:Button ID="btnCancel" CssClass="btn-danger-modern btn-modern" runat="server" OnClick="btnCancel_Click" Text="✗ Cancel" />
                </div>
            </div>
        </div>

        <!-- Close Order Modal -->
        <div id="closeModal" class="modern-modal" runat="server">
            <div class="modal-content-modern">
                <div class="modal-header-modern">
                    <h3>🔒 Close Order</h3>
                </div>
                <div class="text-center mb-3">
                    <h4>Order: <asp:Label ID="lblCloseOrderNumber" runat="server" CssClass="text-danger fw-bold"></asp:Label></h4>
                </div>
                <div class="mb-3">
                    <label class="form-label">Close Reason *</label>
                    <asp:TextBox ID="txtCLoseDetail" runat="server" CssClass="form-control-modern" 
                               TextMode="MultiLine" Rows="4" placeholder="Please provide a detailed reason for closing this order..."></asp:TextBox>
                </div>
                <div class="text-center mb-3">
                    <asp:Label ID="lblCloseStatus" runat="server" CssClass="alert-modern d-none"></asp:Label>
                </div>
                <div class="d-flex justify-content-center gap-3">
                    <asp:Button ID="btnClose" CssClass="btn-warning-modern btn-modern" runat="server" 
                              OnClick="btnClose_Click1" Text="🔒 Close Order" />
                    <asp:Button ID="btnCloseCancel" CssClass="btn-danger-modern btn-modern" runat="server" 
                              OnClick="btnCloseCancel_Click" Text="✗ Cancel" />
                </div>
            </div>
        </div>

        <div class="main-container">
            <!-- Data Sources -->
            <core:DBDataSource ID="DBDataSource1" runat="server" ObjectName="ModernSalesOrders" TableName="OrderHeader"/>
            
            <core:ClientCallbackControl ID="ClientCallbackControl1" runat="server">
                <Callbacks>
                    <core:CallbackLink Source="btnMainShowSearch" DataFieldSource="" DataFieldTarget="" DataViewTarget="" Target="MainSearchPanel" />
                </Callbacks>
            </core:ClientCallbackControl>

            <!-- Action Panel -->
            <div class="action-panel">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="action-header">📋 Order Management Actions</div>
                    </div>
                    <div class="d-flex gap-3 align-items-center">
                        <!-- Training Videos -->
                        <div>
                            <asp:LinkButton ID="btnTrainingVideo1" runat="server" 
                                CssClass="btn-danger-modern btn-modern btn-sm me-2" 
                                OnClientClick="window.open('https://www.prosyssoftech.com/TrainingVideos/SalesOrder.mp4', '_blank'); return false;" 
                                Text="🎥 Training Video 1" />
                            
                            <asp:LinkButton ID="btnTrainingVideo2" runat="server" 
                                CssClass="btn-danger-modern btn-modern btn-sm" 
                                OnClientClick="window.open('https://www.prosyssoftech.com/TrainingVideos/SalesOrder-1.mp4', '_blank'); return false;" 
                                Text="🎥 Training Video 2" />
                        </div>
                        
                        <!-- Main Actions -->
                        <div>
                            <asp:LinkButton ID="btnPurchaseApproveAction" Text="📤 Send For Approval" 
                                CssClass="btn-success-modern btn-modern me-2"
                                CommandName="batch:SalesApprove" CommandArgument="OrderHeaderGrid" 
                                runat="server" OnCommand="DBDataSource1.HandleCommand" />
                            
                            <ctls:ShowSearchButton ID="btnMainShowSearch" runat="server" SearchPanelID="MainSearchPanel" 
                                Text="🔍 Show Search" CssClass="btn-primary-modern btn-modern me-2" />
                            
                            <ctls:ChildLink ID="btnNewMain" runat="server" DataSourceID="DBDataSource1" 
                                TargetTable="OrderHeader" TargetUrl="OrderHeaderDetail.aspx" 
                                Text="➕ New Order" CssClass="btn-success-modern btn-modern" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search Panel -->
            <ctls:SearchPanel ID="MainSearchPanel" runat="server" GridID="OrderHeaderGrid" 
                SearchButtonText="🔍 Search" ClearButtonText="🗑️ Clear" 
                ExpressionLabel="Search Expression" Visible="False" 
                CssClass="search-panel" />

            <!-- Orders Grid -->
            <div class="grid-container">
                <asp:GridView ID="OrderHeaderGrid" runat="server" DataMember="OrderHeader" DataSourceID="DBDataSource1" 
                    AutoGenerateColumns="False" DataKeyNames="CompanyID,DivisionID,DepartmentID,OrderNumber" 
                    OnRowCommand="DBDataSource1.HandleGridCommand" CssClass="modern-table">
                    <Columns>
                        <ctls:SelectionField HeaderText="Select" />
                        
                        <ctls:ChildLinkField ImageUrl="~/images/edit.gif" HeaderText="Edit" TargetUrl="OrderHeaderDetail.aspx">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>
                        
                        <ctls:ChildLinkField ImageUrl="~/images/print.gif" TargetUrl='../../Reports/DocOrderNew.aspx' 
                            Target="_blank" HeaderText="Print">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>
                        
                        <ctls:ChildLinkField ImageUrl="~/images/print.gif" HeaderText="Stock" 
                            TargetUrl='../../NewASPXReports/NewQuotationAndOrderStockReport.aspx?Type=Order' Target="_blank">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>
                        
                        <ctls:ChildLinkField ImageUrl="~/images/return.gif" TargetUrl='../../SqlServerReports/OrderFileAttachemnt.aspx' 
                            Target="_blank" HeaderText="Files">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>
                        
                        <ctls:ChildLinkField ImageUrl="~/images/print.gif" TargetUrl='../../reports/DocNewRevDetails.aspx' 
                            Target="_blank" HeaderText="Rev Details">
                            <ItemStyle Width="60px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>
                        
                        <asp:BoundField HeaderText="Order Number" DataField="OrderNumber" SortExpression="OrderNumber" ReadOnly="true">
                            <ItemStyle CssClass="fw-bold text-primary" />
                        </asp:BoundField>
                        
                        <asp:BoundField HeaderText="Rev #" DataField="RevisionNumber" SortExpression="RevisionNumber" ReadOnly="true">
                            <ItemStyle Width="60px" HorizontalAlign="Center" />
                        </asp:BoundField>
                        
                        <asp:BoundField HeaderText="Order Date" DataField="OrderDate" SortExpression="OrderDate" 
                            DataFormatString="{0:MMM dd, yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" ReadOnly="true">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        
                        <asp:BoundField HeaderText="Customer Name" DataField="ShippingName" SortExpression="ShippingName" ReadOnly="true">
                            <ItemStyle CssClass="fw-semibold" />
                        </asp:BoundField>
                        
                        <asp:BoundField HeaderText="Customer P.O." DataField="PurchaseOrderNumber" SortExpression="PurchaseOrderNumber" ReadOnly="true">
                            <ItemStyle Width="120px" />
                        </asp:BoundField>
                        
                        <asp:BoundField HeaderText="Delivery Date" DataField="OrderShipDate" SortExpression="OrderShipDate" 
                            DataFormatString="{0:MMM dd, yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        
                        <asp:BoundField HeaderText="Ref. Quotation" DataField="RefQuotationNo" SortExpression="RefQuotationNo" 
                            HtmlEncode="false" ApplyFormatInEditMode="true">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        
                        <asp:BoundField HeaderText="Employee" DataField="EmployeeID" SortExpression="EmployeeID" ReadOnly="true">
                            <ItemStyle Width="80px" />
                        </asp:BoundField>
                        
                        <asp:TemplateField HeaderText="Close" ShowHeader="False">
                            <ItemStyle HorizontalAlign="Center" Width="60px" />
                            <ItemTemplate>
                                <asp:ImageButton ID="btnClose" ImageUrl="~/images/Close.png" Width="24px" Height="24px" 
                                    CausesValidation="false" CommandArgument='<%# Eval("OrderNumber") %>' 
                                    OnCommand="btnClose_Command" runat="server" CssClass="action-btn"
                                    ToolTip="Close Order" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Manage Items">
                            <ItemStyle HorizontalAlign="Center" Width="130px" />
                            <ItemTemplate>
                                <asp:Button ID="btnTicketAndSelect" runat="server" 
                                    CssClass="btn-primary-modern btn-modern btn-sm" 
                                    Text="📦 Items" CommandArgument='<%# Eval("OrderNumber") %>' 
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

        <!-- JavaScript -->
        <script type="text/javascript">
            // Enhanced Modal Management
            function showModal(modalId) {
                try {
                    var modal = document.getElementById(modalId);
                    if (modal) {
                        modal.style.display = 'block';
                        document.body.style.overflow = 'hidden';
                        
                        // Add click outside to close
                        setTimeout(function() {
                            modal.onclick = function(e) {
                                if (e.target === modal) {
                                    hideModal(modalId);
                                }
                            };
                        }, 100);
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
                        document.body.style.overflow = 'auto';
                    }
                } catch (e) {
                    console.log('Error hiding modal: ' + e.message);
                }
            }

            // Enhanced Alert System
            function showAlert(message, type) {
                var title = 'Information';
                var icon = 'ℹ️';
                
                switch(type) {
                    case 'success':
                        title = 'Success';
                        icon = '✅';
                        break;
                    case 'error':
                        title = 'Error';
                        icon = '❌';
                        break;
                    case 'warning':
                        title = 'Warning';
                        icon = '⚠️';
                        break;
                }
                
                alert(icon + ' ' + title + '\n\n' + message);
            }

            // Button Loading States
            function setButtonLoading(button, loading) {
                if (loading) {
                    button.disabled = true;
                    button.innerHTML = '<span class="spinner"></span>Processing...';
                    button.classList.add('loading');
                } else {
                    button.disabled = false;
                    button.classList.remove('loading');
                }
            }

            // Initialize page functionality
            document.addEventListener('DOMContentLoaded', function() {
                // Add loading states to buttons
                var buttons = document.querySelectorAll('.btn-modern');
                for (var i = 0; i < buttons.length; i++) {
                    buttons[i].addEventListener('click', function(e) {
                        if (!this.classList.contains('no-loading')) {
                            var self = this;
                            setButtonLoading(self, true);
                            
                            // Reset after 5 seconds to prevent permanent disable
                            setTimeout(function() {
                                setButtonLoading(self, false);
                                self.innerHTML = self.getAttribute('data-original-text') || self.innerHTML.replace('<span class="spinner"></span>Processing...', '');
                            }, 5000);
                        }
                    });
                    
                    // Store original text
                    buttons[i].setAttribute('data-original-text', buttons[i].innerHTML);
                }

                // Enhanced table row interactions
                var tableRows = document.querySelectorAll('.modern-table tbody tr');
                for (var i = 0; i < tableRows.length; i++) {
                    tableRows[i].addEventListener('click', function(e) {
                        // Remove previous selections
                        var selected = document.querySelectorAll('.modern-table tbody tr.selected');
                        for (var j = 0; j < selected.length; j++) {
                            selected[j].classList.remove('selected');
                        }
                        
                        // Add selection to current row (unless clicking on buttons)
                        if (!e.target.closest('button') && !e.target.closest('a') && !e.target.closest('input')) {
                            this.classList.add('selected');
                        }
                    });
                }

                console.log('Modern Sales Orders page initialized successfully');
            });

            // Global error handler
            window.onerror = function(msg, url, lineNo, columnNo, error) {
                console.log('Error: ' + msg + '\nURL: ' + url + '\nLine: ' + lineNo);
                return false;
            };
        </script>

        <style type="text/css">
            /* Additional table selection styling */
            .modern-table tbody tr.selected {
                background-color: rgba(52, 152, 219, 0.1) !important;
                border-left: 3px solid var(--secondary-color);
            }
            
            /* Improved button spacing in table */
            .modern-table .btn-modern {
                margin: 1px;
            }
            
            /* Loading overlay for better UX */
            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.8);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 10000;
            }
            
            .loading-overlay .spinner {
                width: 40px;
                height: 40px;
                border: 4px solid #f3f3f3;
                border-top: 4px solid var(--secondary-color);
            }
        </style>

        <!-- Loading Overlay -->
        <div class="loading-overlay" id="loadingOverlay">
            <div>
                <div class="spinner"></div>
                <div style="margin-top: 10px; color: var(--primary-color); font-weight: 600;">Loading...</div>
            </div>
        </div>
    </form>
</body>
</html>