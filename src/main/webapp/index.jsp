<%@ page language="java" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Mock Evaluation System - Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#0f172a,#1e293b);
    font-family:'Segoe UI',sans-serif;
    overflow:hidden;
}

/* Animated Background */

.circle{
    position:absolute;
    border-radius:50%;
    background:rgba(56,189,248,0.15);
    animation:float 8s infinite ease-in-out;
}

.circle:nth-child(1){
    width:250px;
    height:250px;
    top:-80px;
    left:-80px;
}

.circle:nth-child(2){
    width:200px;
    height:200px;
    bottom:-50px;
    right:-50px;
    animation-delay:2s;
}

@keyframes float{
    0%,100%{
        transform:translateY(0px);
    }
    50%{
        transform:translateY(-25px);
    }
}

/* Login Card */

.login-card{
    width:420px;
    padding:40px;
    border-radius:25px;
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(20px);
    border:1px solid rgba(255,255,255,0.1);
    box-shadow:0 20px 50px rgba(0,0,0,0.4);
    color:white;
    z-index:10;
    animation:fadeUp 1s ease;
}

@keyframes fadeUp{
    from{
        opacity:0;
        transform:translateY(40px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

.logo{
    text-align:center;
    margin-bottom:25px;
}

.logo i{
    font-size:60px;
    color:#38bdf8;
}

.logo h2{
    margin-top:10px;
    font-weight:700;
}

.logo p{
    color:#cbd5e1;
    font-size:14px;
}

.form-label{
    color:#e2e8f0;
    font-weight:500;
}

.form-control{
    background:rgba(255,255,255,0.08);
    border:none;
    color:white;
    height:50px;
}

.form-control:focus{
    background:rgba(255,255,255,0.12);
    color:white;
    border:1px solid #38bdf8;
    box-shadow:none;
}

.form-control::placeholder{
    color:#94a3b8;
}

.input-group-text{
    background:rgba(255,255,255,0.08);
    border:none;
    color:#38bdf8;
}

.login-btn{
    width:100%;
    height:50px;
    border:none;
    border-radius:12px;
    background:#38bdf8;
    color:white;
    font-weight:600;
    transition:.3s;
}

.login-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 10px 20px rgba(56,189,248,.3);
}

.footer-text{
    text-align:center;
    margin-top:20px;
    color:#94a3b8;
    font-size:13px;
}

@media(max-width:500px){

    .login-card{
        width:90%;
        padding:30px;
    }

    .logo h2{
        font-size:24px;
    }
}

</style>

</head>

<body>

<div class="circle"></div>
<div class="circle"></div>

<div class="login-card">


<div class="logo">
    <i class="bi bi-mortarboard-fill"></i>
    <h2>Mock Evaluation System</h2>
    <p>Login Portal</p>
</div>

<form action="login" method="post">

    <div class="mb-3">

        <label class="form-label">
            Email Address
        </label>

        <div class="input-group">

            <span class="input-group-text">
                <i class="bi bi-envelope-fill"></i>
            </span>

            <input type="email"
                   name="email"
                   class="form-control"
                   placeholder="Enter your email"
                   required>

        </div>

    </div>

    <div class="mb-4">

        <label class="form-label">
            Password
        </label>

        <div class="input-group">

            <span class="input-group-text">
                <i class="bi bi-lock-fill"></i>
            </span>

            <input type="password"
                   id="password"
                   name="password"
                   class="form-control"
                   placeholder="Enter your password"
                   required>

            <span class="input-group-text"
                  onclick="togglePassword()"
                  style="cursor:pointer">

                <i id="eye"
                   class="bi bi-eye-fill"></i>

            </span>

        </div>

    </div>

    <button type="submit"
            class="login-btn">

        <i class="bi bi-box-arrow-in-right"></i>
        Login

    </button>

</form>

<div class="footer-text">
    © 2026 Mock Evaluation System
</div>


</div>

<script>

function togglePassword(){

    let password =
    document.getElementById("password");

    let eye =
    document.getElementById("eye");

    if(password.type==="password"){

        password.type="text";
        eye.className="bi bi-eye-slash-fill";

    }else{

        password.type="password";
        eye.className="bi bi-eye-fill";
    }
}

</script>

</body>
</html>
