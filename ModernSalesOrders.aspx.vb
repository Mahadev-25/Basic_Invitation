Imports EnterpriseASPClient.Core
Imports System.Data
Imports System.Data.SqlClient

Partial Public Class ModernSalesOrders
    Inherits System.Web.UI.Page

    Private ConnectionString As String = ""
    Private CompanyID As String = ""
    Private DivisionID As String = ""
    Private DepartmentID As String = ""
    Private EmployeeID As String = ""
    Private OrderNumber As String = ""

    ' Simple and efficient database connection
    Private Function GetConnection() As SqlConnection
        Try
            ConnectionString = EnterpriseCommon.Configuration.ConfigSettings.ConnectionString
            Dim myConnection As New SqlConnection(ConnectionString)
            myConnection.Open()
            Return myConnection
        Catch ex As Exception
            Throw New ApplicationException("Database connection failed: " & ex.Message)
        End Try
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Try
            ' Validate session and get user context
            If Session("SessionKey") Is Nothing Then
                Response.Redirect("~/ErrorForm.aspx")
                Return
            End If

            ' Get session data safely
            Dim SessionKey As Hashtable = CType(Session("SessionKey"), Hashtable)
            
            ' Initialize session variables
            If SessionKey("CompanyID") IsNot Nothing Then
                CompanyID = SessionKey("CompanyID").ToString()
            End If
            If SessionKey("DivisionID") IsNot Nothing Then
                DivisionID = SessionKey("DivisionID").ToString()
            End If
            If SessionKey("DepartmentID") IsNot Nothing Then
                DepartmentID = SessionKey("DepartmentID").ToString()
            End If
            If SessionKey("EmployeeID") IsNot Nothing Then
                EmployeeID = SessionKey("EmployeeID").ToString()
            End If

            If Not IsPostBack Then
                InitializePage()
            End If

        Catch ex As Exception
            ' Log error but don't crash the page
            System.Diagnostics.Debug.WriteLine("Page Load Error: " & ex.Message)
        End Try
    End Sub

    Private Sub InitializePage()
        Try
            ' Hide modals initially
            revisionModal.Style("display") = "none"
            closeModal.Style("display") = "none"
            
            ' Set page title dynamically
            Page.Title = "Modern Sales Orders - " & DateTime.Now.ToString("MMM dd, yyyy")
            
            ' Add welcome message (optional)
            If Not String.IsNullOrEmpty(EmployeeID) Then
                RegisterWelcomeScript()
            End If
            
        Catch ex As Exception
            ' Simple error handling
            System.Diagnostics.Debug.WriteLine("Initialize Error: " & ex.Message)
        End Try
    End Sub

    Private Sub RegisterWelcomeScript()
        Try
            Dim script As String = "console.log('Modern Sales Orders loaded for Employee: " & EmployeeID & "');"
            ClientScript.RegisterStartupScript(Me.GetType(), "WelcomeScript", script, True)
        Catch ex As Exception
            ' Don't let script registration errors crash the page
        End Try
    End Sub

    ' Order Revision Functionality
    Protected Sub btnOk_Click(sender As Object, e As EventArgs) Handles btnOk.Click
        Try
            If String.IsNullOrEmpty(OrderNumber) Then
                ShowAlert("Order number is required.", "error")
                Return
            End If

            ' Execute order revision
            Dim strSQL As String = String.Format("EXEC enterprise.Order_Revised '{0}', '{1}', '{2}', {3}", 
                                                CompanyID, DivisionID, DepartmentID, OrderNumber)
            
            Using connection As SqlConnection = GetConnection()
                Using cmd As New SqlCommand(strSQL, connection)
                    cmd.CommandTimeout = 30
                    cmd.ExecuteNonQuery()
                End Using
            End Using

            ' Show success and redirect
            ShowAlert("Order " & OrderNumber & " revised successfully!", "success")
            HideModal("revisionModal")
            
            ' Refresh the grid
            OrderHeaderGrid.DataBind()

        Catch ex As SqlException
            ShowAlert("Database error: " & ex.Message, "error")
        Catch ex As Exception
            ShowAlert("An error occurred while revising the order: " & ex.Message, "error")
        End Try
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Try
            HideModal("revisionModal")
        Catch ex As Exception
            ' Simple error handling
        End Try
    End Sub

    ' Revision Command Handler
    Protected Sub btnREV_Command(sender As Object, e As CommandEventArgs)
        Try
            If e.CommandArgument IsNot Nothing Then
                Dim arguments As String() = e.CommandArgument.ToString().Split()
                If arguments.Length > 0 Then
                    OrderNumber = arguments(0)
                    lblOrderNumber.Text = OrderNumber
                    ShowModal("revisionModal")
                End If
            End If
        Catch ex As Exception
            ShowAlert("Error processing revision request.", "error")
        End Try
    End Sub

    ' Items Management
    Protected Sub btnTicketAndSelect_Click(sender As Object, e As EventArgs)
        Try
            Dim myButton As Button = TryCast(sender, Button)
            If myButton IsNot Nothing AndAlso myButton.CommandArgument IsNot Nothing Then
                Dim arguments As String() = myButton.CommandArgument.ToString().Split(","c)
                Dim orderNumber As String = arguments(0)

                If orderNumber = "DEFAULT" Then
                    ShowAlert("Items cannot be added to the default sales order.", "warning")
                    Return
                End If

                ' Open items management window
                Dim url As String = String.Format("./ItemOrderDetailDetail.aspx?OrderNumber={0}", orderNumber)
                Dim script As String = String.Format("window.open('{0}', 'ItemsPopup', 'width=1200,height=800,scrollbars=yes,resizable=yes,location=no,menubar=no,toolbar=no');", url)
                ClientScript.RegisterStartupScript(Me.GetType(), "OpenItemsPopup", script, True)
            End If

        Catch ex As Exception
            ShowAlert("Error opening items management window.", "error")
        End Try
    End Sub

    ' Order Closing Functionality
    Protected Sub btnClose_Command(sender As Object, e As CommandEventArgs)
        Try
            If e.CommandArgument IsNot Nothing Then
                Dim arguments As String() = e.CommandArgument.ToString().Split()
                If arguments.Length > 0 Then
                    OrderNumber = arguments(0)
                    lblCloseOrderNumber.Text = OrderNumber

                    If OrderNumber = "DEFAULT" Then
                        ShowAlert("Default orders cannot be closed.", "warning")
                        Return
                    End If

                    ' Clear previous status and show modal
                    lblCloseStatus.Text = ""
                    lblCloseStatus.CssClass = "alert-modern d-none"
                    txtCLoseDetail.Text = ""
                    ShowModal("closeModal")
                End If
            End If
        Catch ex As Exception
            ShowAlert("Error processing close request.", "error")
        End Try
    End Sub

    Private Sub ExecuteCloseProcedure()
        Try
            Dim strSQL As String = String.Format("EXEC enterprise.UnApprovedOrder_Closed '{0}', '{1}', '{2}', '{3}', '{4}'", 
                                                CompanyID, DivisionID, DepartmentID, lblCloseOrderNumber.Text, EmployeeID)
            
            Using connection As SqlConnection = GetConnection()
                Using dAdapter As New SqlDataAdapter(strSQL, connection)
                    Dim ds As New DataTable
                    dAdapter.Fill(ds)
                End Using
            End Using

        Catch ex As Exception
            Throw New ApplicationException("Error executing close procedure: " & ex.Message)
        End Try
    End Sub

    Protected Sub btnCloseCancel_Click(sender As Object, e As EventArgs) Handles btnCloseCancel.Click
        Try
            HideModal("closeModal")
            ' Clear form
            txtCLoseDetail.Text = ""
            lblCloseStatus.Text = ""
            lblCloseStatus.CssClass = "alert-modern d-none"
        Catch ex As Exception
            ' Simple error handling
        End Try
    End Sub

    Protected Sub btnClose_Click1(sender As Object, e As EventArgs) Handles btnClose.Click
        Try
            ' Validate input
            If String.IsNullOrEmpty(txtCLoseDetail.Text.Trim()) Then
                lblCloseStatus.Text = "Please provide a reason for closing the order."
                lblCloseStatus.CssClass = "alert-modern alert-danger d-block"
                Return
            End If

            ' Execute close procedure
            ExecuteCloseProcedure()

            ' Update close reason in database
            Dim strSQL As String = "UPDATE OrderHeader SET ClosedReason = @CloseReason WHERE CompanyID = @CompanyID AND DivisionID = @DivisionID AND DepartmentID = @DepartmentID AND OrderNumber = @OrderNumber"
            
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

            ' Show success message
            lblCloseStatus.Text = "Order " & lblCloseOrderNumber.Text & " closed successfully!"
            lblCloseStatus.CssClass = "alert-modern alert-success d-block"
            
            ' Hide modal after short delay and refresh
            Dim script As String = "setTimeout(function() { hideModal('closeModal'); location.reload(); }, 2000);"
            ClientScript.RegisterStartupScript(Me.GetType(), "CloseSuccess", script, True)

        Catch ex As SqlException
            lblCloseStatus.Text = "Database error: " & ex.Message
            lblCloseStatus.CssClass = "alert-modern alert-danger d-block"
        Catch ex As Exception
            lblCloseStatus.Text = "An error occurred while closing the order: " & ex.Message
            lblCloseStatus.CssClass = "alert-modern alert-danger d-block"
        End Try
    End Sub

    ' Helper Methods for UI Management
    Private Sub ShowModal(modalId As String)
        Try
            Dim script As String = String.Format("showModal('{0}');", modalId)
            ClientScript.RegisterStartupScript(Me.GetType(), "ShowModal" & modalId, script, True)
        Catch ex As Exception
            ' Don't let script errors crash the page
        End Try
    End Sub

    Private Sub HideModal(modalId As String)
        Try
            Dim script As String = String.Format("hideModal('{0}');", modalId)
            ClientScript.RegisterStartupScript(Me.GetType(), "HideModal" & modalId, script, True)
        Catch ex As Exception
            ' Don't let script errors crash the page
        End Try
    End Sub

    Private Sub ShowAlert(message As String, type As String)
        Try
            ' Escape single quotes in message
            Dim safeMessage As String = message.Replace("'", "\'")
            Dim script As String = String.Format("showAlert('{0}', '{1}');", safeMessage, type)
            ClientScript.RegisterStartupScript(Me.GetType(), "ShowAlert" & DateTime.Now.Ticks.ToString(), script, True)
        Catch ex As Exception
            ' Fallback to simple alert
            Try
                Dim fallbackScript As String = String.Format("alert('{0}');", message.Replace("'", "\'"))
                ClientScript.RegisterStartupScript(Me.GetType(), "FallbackAlert", fallbackScript, True)
            Catch
                ' If all else fails, do nothing rather than crash
            End Try
        End Try
    End Sub

    ' Page Enhancement Methods
    Protected Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        Try
            ' Add any last-minute enhancements
            RegisterPageEnhancements()
        Catch ex As Exception
            ' Don't let enhancement errors crash the page
        End Try
    End Sub

    Private Sub RegisterPageEnhancements()
        Try
            ' Add responsive table enhancement
            Dim script As String = "
                if (window.innerWidth < 768) {
                    var tables = document.querySelectorAll('.modern-table');
                    for (var i = 0; i < tables.length; i++) {
                        tables[i].style.fontSize = '11px';
                    }
                }
            "
            ClientScript.RegisterStartupScript(Me.GetType(), "ResponsiveEnhancements", script, True)
        Catch ex As Exception
            ' Simple error handling
        End Try
    End Sub

    ' Error Handling and Logging
    Protected Sub Page_Error(sender As Object, e As EventArgs) Handles Me.Error
        Try
            Dim ex As Exception = Server.GetLastError()
            If ex IsNot Nothing Then
                ' Log the error
                System.Diagnostics.Debug.WriteLine("Page Error: " & ex.Message)
                
                ' Clear the error
                Server.ClearError()
                
                ' Redirect to error page or show friendly message
                ShowAlert("An unexpected error occurred. Please refresh the page.", "error")
            End If
        Catch
            ' If error handling fails, let it fail silently
        End Try
    End Sub

End Class