<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>JNTU-GV | University Feedback System</title>

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Poppins', sans-serif; }
        .navbar { background-color: #004aad !important; }
        .navbar-brand, .nav-link { color: #fff !important; font-weight: 500; }
        .navbar-brand img { height: 40px; margin-right: 10px; }
        .nav-link:hover { color: #cce6ff !important; }
        .hero {
            background: linear-gradient(rgba(0,20,100,0.7), rgba(0,20,80,0.8)),
                        url('https://images.unsplash.com/photo-1604933762819-7f2e47e45c1d?auto=format&fit=crop&w=1350&q=80');
            background-size: cover; background-position: center; color: white;
            padding: 140px 20px; text-align: center;
        }
        .hero h1 { font-size: 3rem; font-weight: 700; }
        .hero p { font-size: 1.2rem; margin-top: 15px; color: #e8e8e8; }
        .btn-role { margin: 10px; border-radius: 50px; font-weight: 500; padding: 12px 25px; }
        .section { padding: 80px 0; }
        .about-section { background-color: #f8f9fa; }
        .features-section { background-color: #e9ecef; }
        .contact-section { background-color: #f8f9fa; }
        footer { background-color: #004aad; color: white; text-align: center; padding: 20px 0; }
        footer a { color: #dff0ff; text-decoration: none; }
        footer a:hover { text-decoration: underline; }
        .feature-card { transition: transform 0.3s; }
        .feature-card:hover { transform: translateY(-10px); }
        .feature-icon { font-size: 2.5rem; color: #004aad; margin-bottom: 15px; }
    </style>

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top shadow-sm">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="https://assets.thehansindia.com/h-upload/2025/01/08/1513148-jntu.webp" alt="JNTU-GV Logo">
            <span>JNTU-GV University Feedback System</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Login</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="admin/admin_login.jsp">Admin</a></li>
                        <li><a class="dropdown-item" href="hod/hod_login.jsp">HOD</a></li>
                        <li><a class="dropdown-item" href="principal/principal_login.jsp">Principal</a></li>
                        <li><a class="dropdown-item" href="faculty/faculty_login.jsp">Faculty</a></li>
                        <li><a class="dropdown-item" href="student/student_login.jsp">Student</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <h1>Welcome to JNTU-GV Feedback System</h1>
        <p>Empowering education through structured feedback and continuous improvement.</p>
        <div class="mt-4">
            <a href="student/student_login.jsp" class="btn btn-light btn-role">Get Started</a>
            <a href="#about" class="btn btn-outline-light btn-role">Learn More</a>
        </div>
    </div>
</section>

<!-- About Section -->
<section id="about" class="about-section section text-center">
    <div class="container">
        <h2 class="mb-4 fw-bold text-primary">About JNTU-GV Feedback System</h2>
        <p class="lead text-muted">
            The JNTU-GV University Feedback System is designed to enhance communication between students, faculty, and administration. 
            It enables transparent and efficient collection of feedback to ensure continuous academic and institutional improvement.
        </p>

        <div class="row mt-5">
            <div class="col-md-4">
                <div class="card p-4 shadow-sm">
                    <h5>🧑‍🎓 For Students</h5>
                    <p>Provide valuable feedback about courses, faculty, and the learning environment.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-4 shadow-sm">
                    <h5>👩‍🏫 For Faculty</h5>
                    <p>Access insights to improve teaching methodologies and academic performance.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-4 shadow-sm">
                    <h5>🏛️ For Administration</h5>
                    <p>Monitor academic progress and evaluate faculty performance effectively.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Key Features Section -->
<section id="features" class="features-section section text-center">
    <div class="container">
        <h2 class="mb-5 fw-bold text-primary">Key Features</h2>
        <div class="row g-4">
            <div class="col-md-3">
                <div class="card p-4 shadow-sm feature-card">
                    <i class="fa-solid fa-user-lock feature-icon"></i>
                    <h5>Secure Login</h5>
                    <p>Role-based access for Admin, Faculty, HOD, Principal, and Students.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-4 shadow-sm feature-card">
                    <i class="fa-solid fa-file-lines feature-icon"></i>
                    <h5>Feedback Forms</h5>
                    <p>Create structured course, faculty, and infrastructure feedback forms.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-4 shadow-sm feature-card">
                    <i class="fa-solid fa-chart-line feature-icon"></i>
                    <h5>Reports & Analytics</h5>
                    <p>Generate department and institution-level feedback analytics with charts.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-4 shadow-sm feature-card">
                    <i class="fa-solid fa-user-gear feature-icon"></i>
                    <h5>Admin Control</h5>
                    <p>Manage users, courses, departments, and system settings effectively.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-4 shadow-sm feature-card">
                    <i class="fa-solid fa-user-graduate feature-icon"></i>
                    <h5>Student Feedback</h5>
                    <p>Submit anonymous quantitative and qualitative feedback online.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-4 shadow-sm feature-card">
                    <i class="fa-solid fa-chalkboard-teacher feature-icon"></i>
                    <h5>Faculty Insights</h5>
                    <p>View course and teaching feedback to improve academic performance.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-4 shadow-sm feature-card">
                    <i class="fa-solid fa-building-columns feature-icon"></i>
                    <h5>Department Monitoring</h5>
                    <p>HODs can track departmental performance and faculty efficiency.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-4 shadow-sm feature-card">
                    <i class="fa-solid fa-shield-halved feature-icon"></i>
                    <h5>Data Security</h5>
                    <p>Confidential storage and secure handling of all feedback data.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Contact Section -->
<section id="contact" class="contact-section section">
    <div class="container">
        <h2 class="text-center mb-4 fw-bold text-primary">Contact Us</h2>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form>
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" class="form-control" placeholder="Your Name">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" placeholder="Your Email">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Message</label>
                        <textarea class="form-control" rows="4" placeholder="Your Message"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <p>© 2025 JNTU-GV University Feedback System | Designed by <strong>Vinay</strong></p>
        <p>
            <a href="#">Home</a> |
            <a href="#about">About</a> |
            <a href="#features">Features</a> |
            <a href="#contact">Contact</a> |
            <a href="admin/admin_login.jsp">Admin Login</a>
        </p>
    </div>
</footer>

</body>
</html>
