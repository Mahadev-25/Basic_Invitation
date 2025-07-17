Option Strict On

Imports EnterpriseASPClient.Core
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI

Partial Public Class CreateSalesOrders
    Inherits PageBase

    Private ConnectionString As String = ""
    Private CompanyID As String = ""
    Private DivisionID As String = ""
    Private DepartmentID As String = ""
    Private EmployeeID As String = ""
    Private OrderNumber As String = ""

    ' Enhanced connection management with better error handling
    Private Function GetConnection() As SqlConnection
        Try
            Dim context As HttpContext = HttpContext.Current
            Dim myConnection As SqlConnection = TryCast(context.Items("SqlConnection"), SqlConnection)
            
            If myConnection IsNot Nothing AndAlso myConnection.State = ConnectionState.Open Then
                Return myConnection
            End If
            
            myConnection = New SqlConnection(ConnectionString)
            myConnection.Open()
            context.Items("SqlConnection") = myConnection
            Return myConnection
            
        Catch ex As Exception
            LogError("Connection Error", ex)
            Throw New ApplicationException("Database connection failed. Please try again.", ex)
        End Try
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Try
            ' Validate session
            Dim SessionKey As Hashtable = TryCast(Session("SessionKey"), Hashtable)
            If Session("SessionKey") Is Nothing OrElse SessionKey Is Nothing Then
                Response.Redirect("~/ErrorForm.aspx")
                Return
            End If

            ' Initialize session variables
            ConnectionString = EnterpriseCommon.Configuration.ConfigSettings.ConnectionString
            CompanyID = SessionKey("CompanyID")?.ToString() ?? ""
            DivisionID = SessionKey("DivisionID")?.ToString() ?? ""
            DepartmentID = SessionKey("DepartmentID")?.ToString() ?? ""
            EmployeeID = SessionKey("EmployeeID")?.ToString() ?? ""

            If Not IsPostBack Then
                InitializePage()
            End If

        Catch ex As Exception
            LogError("Page Load Error", ex)
            ShowErrorMessage("An error occurred while loading the page. Please refresh and try again.")
        End Try
    End Sub

    Private Sub InitializePage()
        ' Hide modals initially
        revisionModal.Style("display") = "none"
        closeModal.Style("display") = "none"
        
        ' Set up client-side enhancements
        RegisterClientScripts()
    End Sub

    Private Sub RegisterClientScripts()
        ' Register enhanced client-side scripts for better UX
        Dim script As String = "
            document.addEventListener('DOMContentLoaded', function() {
                // Initialize tooltips
                var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle=""tooltip""]'));
                var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl);
                });
                
                // Add loading states to buttons
                document.querySelectorAll('.btn').forEach(btn => {
                    btn.addEventListener('click', function() {
                        if (!this.classList.contains('no-loading')) {
                            this.innerHTML = '<i class=""fas fa-spinner fa-spin""></i> Processing...';
                            this.disabled = true;
                        }
                    });
                });
            });
        "
        
        ScriptManager.RegisterStartupScript(Me, GetType(), "PageEnhancements", script, True)
    End Sub

    Protected Sub btnOk_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        Try
            If String.IsNullOrEmpty(OrderNumber) Then
                ShowErrorMessage("Order number is required.")
                Return
            End If

            Dim strSQL As String = $"EXEC enterprise.Order_Revised '{CompanyID}', '{DivisionID}', '{DepartmentID}', {OrderNumber}"
            
            Using connection As SqlConnection = GetConnection()
                Using cmd As New SqlCommand(strSQL, connection)
                    cmd.CommandTimeout = 30
                    cmd.ExecuteNonQuery()
                End Using
            End Using

            ShowSuccessMessage("Order revised successfully!")
            
            ' Hide modal and redirect
            revisionModal.Style("display") = "none"
            Response.Redirect("OrderHeaderList.aspx")

        Catch ex As SqlException
            LogError("SQL Error in Order Revision", ex)
            ShowErrorMessage("Database error occurred while revising the order. Please try again.")
        Catch ex As Exception
            LogError("General Error in Order Revision", ex)
            ShowErrorMessage("An unexpected error occurred. Please try again.")
        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Try
            revisionModal.Style("display") = "none"
            RegisterHideModalScript("revisionModal")
        Catch ex As Exception
            LogError("Error in Cancel Click", ex)
        End Try
    End Sub

    Protected Sub btnREV_Command(sender As Object, e As CommandEventArgs)
        Try
            If e.CommandArgument IsNot Nothing Then
                Dim arguments As String() = e.CommandArgument.ToString().Split()
                If arguments.Length > 0 Then
                    OrderNumber = arguments(0)
                    lblOrderNumber.Text = OrderNumber
                    ShowRevisionModal()
                End If
            End If
        Catch ex As Exception
            LogError("Error in Revision Command", ex)
            ShowErrorMessage("Error processing revision request.")
        End Try
    End Sub

    Protected Sub btnTicketAndSelect_Click(sender As Object, e As EventArgs)
        Try
            Dim myButton As Button = TryCast(sender, Button)
            If myButton?.CommandArgument IsNot Nothing Then
                Dim arguments As String() = myButton.CommandArgument.ToString().Split(","c)
                Dim orderNumber As String = arguments(0)

                If orderNumber = "DEFAULT" Then
                    ShowWarningMessage("Items cannot be added to the default sales order.")
                    Return
                End If

                Dim url As String = $"./ItemOrderDetailDetail.aspx?OrderNumber={orderNumber}"
                Dim script As String = $"window.open('{url}', 'ItemsPopup', 'width=1200,height=800,scrollbars=yes,resizable=yes');"
                ScriptManager.RegisterStartupScript(Me, GetType(), "OpenItemsPopup", script, True)
            End If

        Catch ex As Exception
            LogError("Error in Ticket and Select Click", ex)
            ShowErrorMessage("Error opening items management window.")
        End Try
    End Sub

    Protected Sub btnClose_Command(sender As Object, e As CommandEventArgs)
        Try
            If e.CommandArgument IsNot Nothing Then
                Dim arguments As String() = e.CommandArgument.ToString().Split()
                If arguments.Length > 0 Then
                    OrderNumber = arguments(0)
                    lblCloseOrderNumber.Text = OrderNumber

                    If OrderNumber = "DEFAULT" Then
                        ShowWarningMessage("Default orders cannot be closed.")
                        Return
                    End If

                    ShowCloseModal()
                End If
            End If
        Catch ex As Exception
            LogError("Error in Close Command", ex)
            ShowErrorMessage("Error processing close request.")
        End Try
    End Sub

    Private Sub ExecuteCloseProcedure()
        Try
            Dim strSQL As String = $"EXEC enterprise.UnApprovedOrder_Closed '{CompanyID}', '{DivisionID}', '{DepartmentID}', '{lblCloseOrderNumber.Text}', '{EmployeeID}'"
            
            Using connection As SqlConnection = GetConnection()
                Using dAdapter As New SqlDataAdapter(strSQL, connection)
                    Dim ds As New DataTable
                    dAdapter.Fill(ds)
                End Using
            End Using

        Catch ex As Exception
            LogError("Error in Close Procedure", ex)
            Throw
        End Try
    End Sub

    Protected Sub btnCloseCancel_Click(sender As Object, e As EventArgs) Handles btnCloseCancel.Click
        Try
            closeModal.Style("display") = "none"
            txtCLoseDetail.Text = ""
            lblCloseStatus.Text = ""
            RegisterHideModalScript("closeModal")
        Catch ex As Exception
            LogError("Error in Close Cancel Click", ex)
        End Try
    End Sub

    Protected Sub btnClose_Click1(sender As Object, e As EventArgs) Handles btnClose.Click
        Try
            If String.IsNullOrWhiteSpace(txtCLoseDetail.Text) Then
                ShowFieldError("Please provide a reason for closing the order.")
                Return
            End If

            ' Execute close procedure
            ExecuteCloseProcedure()

            ' Update close reason
            Dim strSQL As String = $"UPDATE OrderHeader SET ClosedReason = @CloseReason WHERE CompanyID = @CompanyID AND DivisionID = @DivisionID AND DepartmentID = @DepartmentID AND OrderNumber = @OrderNumber"
            
            Using connection As SqlConnection = GetConnection()
                Using cmd As New SqlCommand(strSQL, connection)
                    cmd.Parameters.AddWithValue("@CloseReason", txtCLoseDetail.Text.Trim())
                    cmd.Parameters.AddWithValue("@CompanyID", CompanyID)
                    cmd.Parameters.AddWithValue("@DivisionID", DivisionID)
                    cmd.Parameters.AddWithValue("@DepartmentID", DepartmentID)
                    cmd.Parameters.AddWithValue("@OrderNumber", lblCloseOrderNumber.Text)
                    
                    cmd.ExecuteNonQuery()
                End Using
            End Using

            ShowSuccessMessage("Order closed successfully!")
            
            ' Clean up and redirect
            closeModal.Style("display") = "none"
            Response.Redirect("~/EnterpriseASPAR/OrderProcessing/CreateSalesOrders.aspx")

        Catch ex As SqlException
            LogError("SQL Error in Order Close", ex)
            ShowFieldError("Database error occurred while closing the order.")
        Catch ex As Exception
            LogError("General Error in Order Close", ex)
            ShowFieldError("An unexpected error occurred while closing the order.")
        End Try
    End Sub

    ' Enhanced UI methods for better user experience
    Private Sub ShowRevisionModal()
        revisionModal.Style("display") = "block"
        RegisterShowModalScript("revisionModal")
    End Sub

    Private Sub ShowCloseModal()
        closeModal.Style("display") = "block"
        RegisterShowModalScript("closeModal")
    End Sub

    Private Sub RegisterShowModalScript(modalId As String)
        Dim script As String = $"showModal('{modalId}');"
        ScriptManager.RegisterStartupScript(Me, GetType(), $"Show{modalId}", script, True)
    End Sub

    Private Sub RegisterHideModalScript(modalId As String)
        Dim script As String = $"hideModal('{modalId}');"
        ScriptManager.RegisterStartupScript(Me, GetType(), $"Hide{modalId}", script, True)
    End Sub

    Private Sub ShowSuccessMessage(message As String)
        Dim script As String = $"showAlert('{message}', 'success');"
        ScriptManager.RegisterStartupScript(Me, GetType(), "SuccessAlert", script, True)
    End Sub

    Private Sub ShowErrorMessage(message As String)
        Dim script As String = $"showAlert('{message}', 'error');"
        ScriptManager.RegisterStartupScript(Me, GetType(), "ErrorAlert", script, True)
    End Sub

    Private Sub ShowWarningMessage(message As String)
        Dim script As String = $"showAlert('{message}', 'warning');"
        ScriptManager.RegisterStartupScript(Me, GetType(), "WarningAlert", script, True)
    End Sub

    Private Sub ShowFieldError(message As String)
        lblCloseStatus.Text = message
        lblCloseStatus.CssClass = "alert alert-danger alert-modern d-block"
    End Sub

    Private Sub LogError(context As String, ex As Exception)
        ' Enhanced error logging
        Try
            Dim errorMessage As String = $"[{DateTime.Now}] {context}: {ex.Message}"
            If ex.InnerException IsNot Nothing Then
                errorMessage &= $" Inner: {ex.InnerException.Message}"
            End If
            
            ' Log to system (you might want to implement your own logging mechanism)
            System.Diagnostics.Debug.WriteLine(errorMessage)
            
            ' You can also log to database or file here
            ' LogToDatabase(context, ex)
            
        Catch logEx As Exception
            ' Don't let logging errors crash the application
            System.Diagnostics.Debug.WriteLine($"Logging error: {logEx.Message}")
        End Try
    End Sub

    Protected Overrides Sub OnUnload(e As EventArgs)
        Try
            ' Clean up database connections
            Dim context As HttpContext = HttpContext.Current
            If context?.Items("SqlConnection") IsNot Nothing Then
                Dim connection As SqlConnection = TryCast(context.Items("SqlConnection"), SqlConnection)
                If connection?.State = ConnectionState.Open Then
                    connection.Close()
                End If
            End If
        Catch ex As Exception
            LogError("Error in OnUnload", ex)
        Finally
            MyBase.OnUnload(e)
        End Try
    End Sub

End Class