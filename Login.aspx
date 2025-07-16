<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Login"
    EnableEventValidation="false" %>

<%@ Register Assembly="EnterpriseASPClient" Namespace="EnterpriseASPClient.Core"
    TagPrefix="core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>LOGIN - Welcome</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <script src="scripts/lib.js" type="text/javascript"></script>
    <script src="scripts/General.js" type="text/javascript"></script>

    <!-- Bootstrap CSS -->
    <link href="Bootstrap2/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    
    <!-- jQuery and Bootstrap JS -->
    <script src="Bootstrap2/js/jquery3.3.1.min.js" type="text/javascript"></script>
    <script src="Bootstrap2/js/bootstrap.min.js" type="text/javascript"></script>
    
    <!-- Select2 -->
    <link href="Bootstrap2/css/Select2.min.css" rel="stylesheet" />
    <script src="Bootstrap2/js/Select2.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.js-example-basic-single').select2({
                theme: "bootstrap"
            });
            
            // Add loading animation
            $('.login-container').addClass('fade-in');
            
            // Add floating label effect
            $('.form-control').on('focus blur', function(e) {
                var $this = $(this);
                var label = $this.prev('label');
                if (e.type === 'focus' || this.value.length > 0) {
                    label.addClass('active highlight');
                } else if (e.type === 'blur' && this.value.length === 0) {
                    label.removeClass('active highlight');
                }
            });
        });
    </script>

    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow-x: hidden;
        }

        /* Animated background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 40% 80%, rgba(120, 219, 255, 0.3) 0%, transparent 50%);
            animation: float 15s ease-in-out infinite;
            z-index: -1;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-30px) rotate(1deg); }
            66% { transform: translateY(-20px) rotate(-1deg); }
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: 
                0 25px 45px rgba(0, 0, 0, 0.1),
                0 0 0 1px rgba(255, 255, 255, 0.2);
            padding: 0;
            overflow: hidden;
            max-width: 1000px;
            width: 90%;
            margin: 20px auto;
            opacity: 0;
            transform: translateY(50px);
            transition: all 0.8s ease;
        }

        .login-container.fade-in {
            opacity: 1;
            transform: translateY(0);
        }

        .login-form-section {
            padding: 50px 40px;
            background: linear-gradient(145deg, #ffffff 0%, #f8f9ff 100%);
        }

        .visual-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            min-height: 600px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .visual-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.1'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            opacity: 0.1;
        }

        .visual-content {
            text-align: center;
            color: white;
            z-index: 2;
            position: relative;
        }

        .visual-content h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .visual-content p {
            font-size: 1.1rem;
            opacity: 0.9;
            line-height: 1.6;
            max-width: 300px;
            margin: 0 auto;
        }

        .logo-container {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo-image {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 4px solid #667eea;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            color: white;
            font-size: 2rem;
        }

        .logo-image:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
        }

        .sign-in-title {
            text-align: center;
            color: #333;
            font-weight: 600;
            font-size: 1.8rem;
            margin-bottom: 30px;
            position: relative;
        }

        .sign-in-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-label {
            font-weight: 500;
            color: #555;
            margin-bottom: 8px;
            font-size: 0.95rem;
            display: block;
        }

        .form-control {
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
            height: auto;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            background: white;
            outline: none;
        }

        .select2-container .select2-selection--single {
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            height: 45px;
            padding: 8px 12px;
        }

        .select2-container--bootstrap .select2-selection--single .select2-selection__rendered {
            padding-left: 0;
            line-height: 28px;
        }

        .btn-signin {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 12px 40px;
            font-weight: 600;
            font-size: 1rem;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            min-width: 150px;
        }

        .btn-signin::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            transition: left 0.3s ease;
            z-index: 0;
        }

        .btn-signin:hover::before {
            left: 0;
        }

        .btn-signin:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .btn-signin span {
            position: relative;
            z-index: 1;
        }

        .validation-error {
            color: #dc3545;
            font-size: 0.8rem;
            margin-top: 5px;
            display: block;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            z-index: 5;
        }

        .form-control.has-icon {
            padding-left: 45px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .login-container {
                margin: 10px;
                width: 95%;
            }
            
            .login-form-section {
                padding: 30px 20px;
            }
            
            .visual-section {
                min-height: 300px;
                order: -1;
            }
            
            .visual-content h2 {
                font-size: 1.8rem;
            }
            
            .sign-in-title {
                font-size: 1.5rem;
            }
        }

        /* Loading Animation */
        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 2px solid #ffffff;
            border-top: 2px solid transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Floating particles animation */
        .floating-shapes {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 1;
        }

        .floating-shapes::before,
        .floating-shapes::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float-shapes 20s infinite linear;
        }

        .floating-shapes::before {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-shapes::after {
            width: 120px;
            height: 120px;
            top: 60%;
            right: 10%;
            animation-delay: 10s;
        }

        @keyframes float-shapes {
            0% { transform: translateY(0px) rotate(0deg); opacity: 1; }
            50% { transform: translateY(-100px) rotate(180deg); opacity: 0.5; }
            100% { transform: translateY(0px) rotate(360deg); opacity: 1; }
        }
    </style>
</head>
<body onload="javascript:LoginCookie();">
    <form id="form1" runat="server">
        <asp:Login ID="Login1" CssClass="container-fluid" runat="server" Width="100%">
            <LayoutTemplate>
                <div class="login-container">
                    <div class="row no-gutters">
                        <!-- Login Form Section -->
                        <div class="col-md-6">
                            <div class="login-form-section">
                                <!-- Logo Section -->
                                <div class="logo-container">
                                    <div class="logo-image">
                                        <i class="fas fa-user-shield"></i>
                                        <asp:Image ID="ImgLogo" ImageUrl="~/images/Logo1.jpg" 
                                                  style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%; display: none;" 
                                                  runat="server" 
                                                  onerror="this.style.display='none'; this.parentNode.querySelector('i').style.display='block';"
                                                  onload="this.style.display='block'; this.parentNode.querySelector('i').style.display='none';" />
                                    </div>
                                </div>

                                <!-- Title -->
                                <h3 class="sign-in-title">Welcome Back</h3>

                                <!-- Company Selection -->
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-building" style="margin-right: 8px; color: #667eea;"></i>
                                        Company
                                    </label>
                                    <asp:DropDownList ID="cmbCompany" runat="server" AutoPostBack="true" 
                                                     OnSelectedIndexChanged="CompanyChanged" 
                                                     CssClass="js-example-basic-single form-control">
                                    </asp:DropDownList>
                                </div>

                                <!-- Division Selection -->
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-sitemap" style="margin-right: 8px; color: #667eea;"></i>
                                        Division
                                    </label>
                                    <asp:DropDownList ID="cmbDivision" runat="server" AutoPostBack="true" 
                                                     OnSelectedIndexChanged="DivisionChanged" 
                                                     CssClass="js-example-basic-single form-control">
                                    </asp:DropDownList>
                                </div>

                                <!-- Username -->
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-user" style="margin-right: 8px; color: #667eea;"></i>
                                        Username
                                    </label>
                                    <asp:TextBox ID="UserName" runat="server" CssClass="form-control" 
                                                placeholder="Enter your username"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserRequired" runat="server" 
                                                               ControlToValidate="UserName" 
                                                               ErrorMessage="Username is required" 
                                                               ValidationGroup="Login1"
                                                               CssClass="validation-error"
                                                               Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>

                                <!-- Password -->
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-lock" style="margin-right: 8px; color: #667eea;"></i>
                                        Password
                                    </label>
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password" 
                                                CssClass="form-control" placeholder="Enter your password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                                               ControlToValidate="Password" 
                                                               ErrorMessage="Password is required" 
                                                               ValidationGroup="Login1"
                                                               CssClass="validation-error"
                                                               Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>

                                <!-- Hidden Department -->
                                <asp:DropDownList ID="cmbDepartment" runat="server" Width="150px" 
                                                 AutoPostBack="true" Visible="false"></asp:DropDownList>

                                <!-- Sign In Button -->
                                <div class="form-group text-center" style="margin-top: 35px;">
                                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" 
                                               CssClass="btn btn-signin" Text="Sign In" 
                                               ValidationGroup="Login1" />
                                </div>
                            </div>
                        </div>

                        <!-- Visual Section -->
                        <div class="col-md-6">
                            <div class="visual-section">
                                <div class="floating-shapes"></div>
                                <div class="visual-content">
                                    <h2>Secure Access</h2>
                                    <p>Welcome to your enterprise portal. Sign in to access your dashboard and manage your business operations securely.</p>
                                    <div style="margin-top: 40px;">
                                        <i class="fas fa-shield-alt" style="font-size: 4rem; opacity: 0.8;"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </LayoutTemplate>
        </asp:Login>

        <asp:Label runat="server" ID="lbCurrentDate" 
                  Style="z-index: 100; left: 48px; position: absolute; top: 180px"
                  Font-Bold="True" Width="12%" Visible="false" />
    </form>
</body>
</html>