<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link rel="stylesheet" href="css/dashboard.css" />
    <title>Dashboard</title>
</head>

<body> 
    <main>
          <div class="d-flex" id="dashboard">
        <div class="bg" id="sidebar-dashboard">
            <div class="m-2 dark-text fs-5 fw-bold border-start border-5 border-info px-2">
                E-classe
            </div>
            <div class="list-group ">
                <img src="image/profile.jpg" alt="profile picture"
                    class=" profile img-fluid rounded-circle mx-auto d-block my-2 p-1 ">
                <div class="text-center ">
                    <h6> Admin name </h6>
                    <span class=" fs-6 text-info">Admin</span>
                </div>
                <a href="dashboard.html" class="list-group-item mx-5 border-0  bg-info rounded-3 mt-3 ">
                    <i class="fas fa-home"></i> Home</a>
                <a href="#" class="list-group-item mx-5 border-0 bg-transparent ">
                    <i class="far fa-bookmark"></i> Course </a>
                <a href="students.html" class="list-group-item mx-5 border-0 bg-transparent  ">
                    <i class="fas fa-graduation-cap"></i> Students</a>
                <a href="payment.html" class="list-group-item mx-5 border-0 bg-transparent ">
                    <i class="fas fa-dollar-sign "></i> Payment </a>
                <a href="#" class="list-group-item mx-5 border-0 bg-transparent ">
                    <i class="far fa-file-alt"></i> Report </a>
                <a href="#" class="list-group-item mx-5 border-0 bg-transparent ">
                    <i class="fas fa-sliders-h"></i> Settings</a>
                <a href="index.html" class="list-group-item mx-5 border-0 bg-transparent  mt-5 mb-2 ">
                    Logout <i class="fas fa-sign-out-alt"></i> </a>
            </div>
        </div>
        <div id="page-content-dashboard">
            <nav class="navbar navbar-expand-lg navbar-light  py-1 px-4">
                <div class="d-flex align-items-center">
                    <i class="fas fa-chevron-circle-left  me-3" id="menu-toggle"></i>
                </div>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarToggler"
                    aria-controls="navbarToggler" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarToggler">
                    <div class="navbar-nav ms-auto">
                        <div class="nav-item dropdown">
                            <form class="d-flex  justify-content-end mt-3 ">
                                <input class="form-control me-2 " type="search" placeholder="Search..."
                                    aria-label="Search">
                                <i class="fas fa-bell  mt-2 ml-2"></i>
                            </form>
                        </div>
                    </div>
                </div>
            </nav>
            <div class="container-fluid px-4">
                <div class="row my-2 d-flex justify-content-center">
                    <div class="col-lg-3 col-md-5 mb-4 ">
                        <div class="p-3  shadow-sm d-flex justify-content-around align-items-center card_student ">
                            <div>
                                <i class="fas fa-graduation-cap fs-5  p-1"></i>

                                <p class="fs-5 mb-5 Secondary-text">Students</p>
                            </div>
                            <h1 class="fs-5 mt-5">243</h1>
                        </div>
                    </div>
                    <div class="col-lg-3  col-md-5  mb-4 ">
                        <div class="p-3  shadow-sm d-flex justify-content-around align-items-center card_cours ">
                            <div>
                                <i class="far fa-bookmark fs-5 p-1"></i>

                                <p class="fs-5 mb-5 Secondary-text">Course</p>
                            </div>
                            <h1 class="fs-5 mt-5">13</h1>
                        </div>
                    </div>
                    <div class=" col-lg-3  col-md-5  mb-4">
                        <div class="p-3  shadow-sm d-flex justify-content-around align-items-center card_payment ">
                            <div>
                                <i class="fas fa-dollar-sign fs-5  p-1"></i>

                                <p class="fs-5 mb-5 Secondary-text">Payments</p>
                            </div>
                            <h1 class="fs-5 mt-5">DH556,000</h1>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-5  mb-4">
                        <div class="p-3  shadow-sm d-flex justify-content-around align-items-center card_user ">
                            <div>
                                <i class="far fa-user fs-5  p-1"></i>

                                <p class="fs-5 mb-5 text-white">Users</p>
                            </div>
                            <h1 class="fs-5 mt-5">3</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var el = document.getElementById("dashboard");
        var toggleButton = document.getElementById("menu-toggle");
        toggleButton.onclick = function () {
            el.classList.toggle("toggled");
        };
    </script>
    </main>
  
</body>

</html>
