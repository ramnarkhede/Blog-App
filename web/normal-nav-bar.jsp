<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <!-- Brand -->
    <a class="navbar-brand" href="#">Blog App</a>

    <!-- Links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" href="#">Home</a>
        </li>


        <!-- Dropdown -->
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                Catagories
            </a>
            <div class="dropdown-menu">
                <a class="dropdown-item" href="#">Java</a>
                <a class="dropdown-item" href="#">Python</a>
                <a class="dropdown-item" href="#">SQL</a>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Contact</a>
        </li>
        
         <li class="nav-item">
             <a class="nav-link" href="login_page.jsp"><span class="fa fa-user-circle"></span> Login</a>
        </li>
        <li class="nav-item">
             <a class="nav-link" href="register_page.jsp"><span class="fa fa-user-plus"></span> Sign Up</a>
        </li>
    </ul>
    <div>
        <form class="form-inline" action="/action_page.php">
            <input class="form-control mr-sm-2" type="text" placeholder="Search">
            <button class="btn btn-light" type="submit">Search</button>
        </form>
    </div>

</nav>