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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    
    <!-- jQuery and Bootstrap JS -->
    <script src="Bootstrap2/js/jquery3.3.1.min.js" type="text/javascript"></script>
    <script src="Bootstrap2/js/bootstrap.min.js" type="text/javascript"></script>
    
    <!-- Select2 -->
    <link href="Bootstrap2/css/Select2.min.css" rel="stylesheet" />
    <script src="Bootstrap2/js/Select2.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.js-example-basic-single').select2({
                theme: "bootstrap",
                minimumResultsForSearch: Infinity,
                dropdownParent: $('.login-form')
            });

            // Enhanced animations
            setTimeout(function() {
                $('.login-card').addClass('animate-in');
            }, 100);

            // Floating label effect
            $('.form-control, .select2-selection').on('focus focusin', function () {
                $(this).closest('.form-group').addClass('focused');
            }).on('blur focusout', function () {
                if (!$(this).val()) {
                    $(this).closest('.form-group').removeClass('focused');
                }
            });

            // Check if fields have values on load
            $('.form-control').each(function() {
                if ($(this).val()) {
                    $(this).closest('.form-group').addClass('focused');
                }
            });

            // Enhanced button interaction
            $('.btn-signin').hover(
                function() { $(this).addClass('btn-hover'); },
                function() { $(this).removeClass('btn-hover'); }
            );

            // Loading effect with proper animation
            $('.btn-signin').click(function (e) {
                if ($(this).hasClass('loading')) return false;
                
                $(this).addClass('loading');
                $(this).find('.btn-text').text('Signing In...');
                $(this).find('.loading-spinner').show();
                
                // Reset after 3 seconds if no server response
                setTimeout(function() {
                    $('.btn-signin').removeClass('loading');
                    $('.btn-signin .btn-text').text('Sign In');
                    $('.btn-signin .loading-spinner').hide();
                }, 3000);
            });

            // Particle animation
            createParticles();
        });

        function createParticles() {
            const particleContainer = $('.particle-container');
            for (let i = 0; i < 50; i++) {
                const particle = $('<div class="particle"></div>');
                particle.css({
                    left: Math.random() * 100 + '%',
                    animationDelay: Math.random() * 20 + 's',
                    animationDuration: (Math.random() * 10 + 10) + 's'
                });
                particleContainer.append(particle);
            }
        }
    </script>

    <style type="text/css">
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --accent-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --success-gradient: linear-gradient(135deg, #a8e6cf 0%, #56ab2f 100%);
            
            --primary-color: #667eea;
            --primary-dark: #5a6fd8;
            --secondary-color: #764ba2;
            --accent-color: #4facfe;
            --success-color: #56ab2f;
            --error-color: #ff6b6b;
            --warning-color: #feca57;
            
            --text-primary: #2c3e50;
            --text-secondary: #7f8c8d;
            --text-light: #bdc3c7;
            --text-white: #ffffff;
            
            --bg-primary: #f8f9fa;
            --bg-secondary: #ffffff;
            --bg-card: rgba(255, 255, 255, 0.95);
            
            --border-light: #e9ecef;
            --border-primary: #dee2e6;
            
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 12px rgba(0,0,0,0.15);
            --shadow-lg: 0 8px 25px rgba(0,0,0,0.15);
            --shadow-xl: 0 15px 35px rgba(0,0,0,0.1), 0 5px 15px rgba(0,0,0,0.07);
            --shadow-2xl: 0 25px 50px rgba(0,0,0,0.25);
            
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 24px;
            
            --transition-fast: 0.2s ease;
            --transition-smooth: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            --transition-bounce: 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: var(--primary-gradient);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* Enhanced animated background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 20%, rgba(102, 126, 234, 0.4) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(118, 75, 162, 0.4) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(79, 172, 254, 0.3) 0%, transparent 50%);
            animation: backgroundShift 15s ease-in-out infinite;
            z-index: 0;
        }

        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Ccircle cx='7' cy='7' r='1'/%3E%3Ccircle cx='27' cy='7' r='1'/%3E%3Ccircle cx='47' cy='7' r='1'/%3E%3Ccircle cx='7' cy='27' r='1'/%3E%3Ccircle cx='27' cy='27' r='1'/%3E%3Ccircle cx='47' cy='27' r='1'/%3E%3Ccircle cx='7' cy='47' r='1'/%3E%3Ccircle cx='27' cy='47' r='1'/%3E%3Ccircle cx='47' cy='47' r='1'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            animation: patternMove 20s linear infinite;
            z-index: 0;
        }

        .particle-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            animation: floatUp linear infinite;
        }

        @keyframes backgroundShift {
            0%, 100% { 
                transform: scale(1) rotate(0deg);
                filter: hue-rotate(0deg);
            }
            50% { 
                transform: scale(1.1) rotate(180deg);
                filter: hue-rotate(90deg);
            }
        }

        @keyframes patternMove {
            0% { transform: translateX(0) translateY(0); }
            100% { transform: translateX(60px) translateY(60px); }
        }

        @keyframes floatUp {
            0% {
                opacity: 0;
                transform: translateY(100vh) rotate(0deg);
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                opacity: 0;
                transform: translateY(-100px) rotate(360deg);
            }
        }

        .login-container {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-2xl);
            overflow: hidden;
            width: 100%;
            max-width: 440px;
            min-height: 620px;
            position: relative;
            z-index: 10;
        }

        .login-card {
            opacity: 0;
            transform: translateY(50px) scale(0.95);
            transition: all 0.8s cubic-bezier(0.16, 1, 0.3, 1);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .login-card.animate-in {
            opacity: 1;
            transform: translateY(0) scale(1);
        }

        .login-header {
            background: var(--primary-gradient);
            padding: 48px 32px 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .login-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: conic-gradient(from 0deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: rotate 10s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .logo-container {
            position: relative;
            z-index: 2;
            margin-bottom: 24px;
        }

        .logo-image {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(15px);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            color: var(--text-white);
            font-size: 28px;
            transition: all var(--transition-bounce);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1), inset 0 1px 0 rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.1);
        }

        .logo-image:hover {
            transform: scale(1.1) rotate(10deg);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3);
        }

        .welcome-title {
            color: var(--text-white);
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
            position: relative;
            z-index: 2;
            letter-spacing: -0.5px;
        }

        .welcome-subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 15px;
            font-weight: 400;
            position: relative;
            z-index: 2;
            opacity: 0.9;
        }

        .login-form {
            padding: 40px 32px 32px;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .form-group {
            position: relative;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
            font-size: 14px;
            transition: all var(--transition-fast);
            transform: translateY(0);
        }

        .form-group.focused .form-label {
            color: var(--primary-color);
            transform: translateY(-2px);
        }

        .input-container {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            font-size: 16px;
            transition: all var(--transition-fast);
            z-index: 2;
        }

        .form-group.focused .input-icon {
            color: var(--primary-color);
            transform: translateY(-50%) scale(1.1);
        }

        .form-control {
            width: 100%;
            padding: 16px 20px 16px 48px;
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: 15px;
            font-weight: 400;
            background: var(--bg-secondary);
            transition: all var(--transition-smooth);
            height: 56px;
            font-family: inherit;
            box-shadow: var(--shadow-sm);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1), var(--shadow-md);
            transform: translateY(-1px);
        }

        .form-control::placeholder {
            color: var(--text-light);
            font-weight: 400;
        }

        /* Enhanced Select2 Styling */
        .select2-container {
            width: 100% !important;
        }

        .select2-container .select2-selection--single {
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            height: 56px;
            padding: 0 20px 0 44px;
            background: var(--bg-secondary);
            transition: all var(--transition-smooth);
            box-shadow: var(--shadow-sm);
        }

        .select2-container .select2-selection--single:focus,
        .select2-container--open .select2-selection--single {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1), var(--shadow-md);
            transform: translateY(-1px);
        }

        .select2-container .select2-selection--single .select2-selection__rendered {
            line-height: 52px;
            padding-left: 0;
            color: var(--text-primary);
            font-weight: 400;
        }

        .select2-container .select2-selection--single .select2-selection__arrow {
            height: 52px;
            right: 12px;
        }

        .select2-dropdown {
            border: 2px solid var(--primary-color);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-xl);
            border-top: none;
            margin-top: -1px;
        }

        .select2-results__option {
            padding: 12px 16px;
            font-weight: 400;
        }

        .select2-results__option--highlighted {
            background: var(--primary-color) !important;
            color: white;
        }

        .btn-signin {
            width: 100%;
            background: var(--primary-gradient);
            border: none;
            border-radius: var(--radius-md);
            padding: 16px 24px;
            font-weight: 600;
            font-size: 15px;
            color: var(--text-white);
            transition: all var(--transition-smooth);
            position: relative;
            overflow: hidden;
            cursor: pointer;
            margin-top: 8px;
            height: 56px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow-lg);
            letter-spacing: 0.5px;
        }

        .btn-signin::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-signin:hover::before {
            left: 100%;
        }

        .btn-signin:hover,
        .btn-signin.btn-hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
            background: linear-gradient(135deg, #5a6fd8 0%, #6a5d9e 100%);
        }

        .btn-signin:active {
            transform: translateY(0);
            box-shadow: var(--shadow-md);
        }

        .btn-signin.loading {
            pointer-events: none;
            opacity: 0.9;
            transform: none;
        }

        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top: 2px solid var(--text-white);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .validation-error {
            color: var(--error-color);
            font-size: 13px;
            margin-top: 6px;
            display: block;
            font-weight: 500;
            animation: slideInUp 0.3s ease;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .security-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 16px 24px;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: var(--text-secondary);
            font-size: 13px;
            font-weight: 500;
            border-top: 1px solid var(--border-light);
        }

        .security-badge i {
            margin-right: 8px;
            color: var(--success-color);
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 16px;
            }

            .login-container {
                max-width: 100%;
                min-height: auto;
                border-radius: var(--radius-lg);
            }

            .login-header {
                padding: 40px 24px 32px;
            }

            .login-form {
                padding: 32px 24px 24px;
                gap: 20px;
            }

            .welcome-title {
                font-size: 24px;
            }

            .logo-image {
                width: 70px;
                height: 70px;
                font-size: 24px;
            }

            .form-control {
                height: 52px;
                padding: 14px 18px 14px 44px;
            }

            .btn-signin {
                height: 52px;
                font-size: 14px;
            }

            .select2-container .select2-selection--single {
                height: 52px;
                padding: 0 18px 0 40px;
            }

            .select2-container .select2-selection--single .select2-selection__rendered {
                line-height: 48px;
            }

            .select2-container .select2-selection--single .select2-selection__arrow {
                height: 48px;
            }
        }

        @media (max-width: 480px) {
            .login-header {
                padding: 32px 20px 24px;
            }

            .login-form {
                padding: 24px 20px 20px;
                gap: 18px;
            }

            .welcome-title {
                font-size: 22px;
            }

            .logo-image {
                width: 64px;
                height: 64px;
                font-size: 22px;
            }
        }

        /* Enhanced animations */
        .form-control.error {
            border-color: var(--error-color);
            animation: shake 0.5s ease-in-out;
            box-shadow: 0 0 0 4px rgba(255, 107, 107, 0.1);
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-8px); }
            75% { transform: translateX(8px); }
        }

        /* Loading overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(5px);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        .loading-overlay.show {
            display: flex;
        }

        /* Additional enhancements */
        .form-group {
            transform: translateY(0);
            transition: transform var(--transition-smooth);
        }

        .form-group:hover {
            transform: translateY(-1px);
        }

        .input-container::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: var(--primary-gradient);
            transition: all var(--transition-smooth);
            transform: translateX(-50%);
        }

        .form-group.focused .input-container::after {
            width: 100%;
        }

        /* Glass morphism effect */
        .login-container {
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 
                0 8px 32px 0 rgba(31, 38, 135, 0.37),
                inset 0 1px 0 rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
        }

        .form-control {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
        }

        .select2-container .select2-selection--single {
            background: rgba(255, 255, 255, 0.9) !important;
            backdrop-filter: blur(10px);
        }
    </style>
</head>
<body onload="javascript:LoginCookie();">
    <div class="particle-container"></div>
    <form id="form1" runat="server">
        <asp:Login ID="Login1" CssClass="login-wrapper" runat="server" Width="100%">
            <LayoutTemplate>
                <div class="login-container">
                    <div class="login-card">
                        <!-- Header Section -->
                        <div class="login-header">
                            <div class="logo-container">
                                <div class="logo-image">
                                    <i class="fas fa-shield-alt"></i>
                                    <asp:Image ID="ImgLogo" ImageUrl="~/images/logo1.jpg" 
                                              style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%; display: none;" 
                                              runat="server" />
                                </div>
                            </div>
                            <h1 class="welcome-title">Welcome Back</h1>
                            <p class="welcome-subtitle">Please sign in to continue to your account</p>
                        </div>

                        <!-- Form Section -->
                        <div class="login-form">
                            <!-- Company Selection -->
                            <div class="form-group">
                                <label class="form-label">Company</label>
                                <div class="input-container">
                                    <i class="fas fa-building input-icon"></i>
                                    <asp:DropDownList ID="cmbCompany" runat="server" AutoPostBack="true" 
                                                     OnSelectedIndexChanged="CompanyChanged" 
                                                     CssClass="js-example-basic-single form-control">
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- Division Selection -->
                            <div class="form-group">
                                <label class="form-label">Division</label>
                                <div class="input-container">
                                    <i class="fas fa-sitemap input-icon"></i>
                                    <asp:DropDownList ID="cmbDivision" runat="server" AutoPostBack="true" 
                                                     OnSelectedIndexChanged="DivisionChanged" 
                                                     CssClass="js-example-basic-single form-control">
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- Username -->
                            <div class="form-group">
                                <label class="form-label">Username</label>
                                <div class="input-container">
                                    <i class="fas fa-user input-icon"></i>
                                    <asp:TextBox ID="UserName" runat="server" CssClass="form-control" 
                                                placeholder="Enter your username"></asp:TextBox>
                                </div>
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
                                <label class="form-label">Password</label>
                                <div class="input-container">
                                    <i class="fas fa-lock input-icon"></i>
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password" 
                                                CssClass="form-control" placeholder="Enter your password"></asp:TextBox>
                                </div>
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
                            <asp:Button ID="LoginButton" runat="server" CommandName="Login" 
                                       CssClass="btn btn-signin" ValidationGroup="Login1">
                                <span class="loading-spinner"></span>
                                <span class="btn-text">Sign In</span>
                            </asp:Button>
                        </div>

                        <!-- Security Badge -->
                        <div class="security-badge">
                            <i class="fas fa-shield-check"></i>
                            Secure Login Protected by SSL Encryption
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