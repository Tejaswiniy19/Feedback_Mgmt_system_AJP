<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>JNTUGV Principal Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: url('https://images.unsplash.com/photo-1557682250-33bd709cbe85?auto=format&fit=crop&w=1950&q=80') 
                        no-repeat center center/cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.25);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            border-radius: 18px;
            padding: 50px 40px;
            width: 380px;
            color: #fff;
            text-align: center;
        }

        .glass-card img {
            width: 90px;
            height: 90px;
            margin-bottom: 20px;
            border-radius: 50%;
            border: 3px solid white;
        }

        .glass-card h3 {
            font-weight: 600;
            margin-bottom: 25px;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
        }

        .form-control {
            background: rgba(255,255,255,0.8);
            border: none;
            color: #333;
            border-radius: 8px;
            padding: 12px;
            font-weight: 500;
        }

        .form-control:focus {
            box-shadow: 0 0 5px #6f42c1;
        }

        .btn-login {
            width: 100%;
            background: linear-gradient(135deg, #6f42c1, #4527a0);
            border: none;
            border-radius: 25px;
            padding: 12px;
            color: white;
            font-weight: 600;
            margin-top: 10px;
            transition: 0.3s;
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #5a32a3, #311b92);
        }

        .error {
            color: #ffcccc;
            margin-top: 15px;
            font-size: 14px;
        }

        footer {
            position: absolute;
            bottom: 10px;
            color: white;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="glass-card">
    <img src="https://assets.thehansindia.com/h-upload/2025/01/08/1513148-jntu.webp" alt="JNTUGV Logo">
    <h3>JNTUGV Principal Login</h3>

    <form action="<%=request.getContextPath()%>/PrincipalLoginServlet" method="post">
        <div class="mb-3">
            <input type="text" name="username" class="form-control" placeholder="Enter Username" required>
        </div>
        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="Enter Password" required>
        </div>
        <button type="submit" class="btn-login">Login</button>
    </form>

    <p class="error">${errorMessage}</p>
</div>

<footer>
    © 2025 Jawaharlal Nehru Technological University - Gurajada Vizianagaram
</footer>

</body>
</html>
