# HW 1

Due August 31st at 11:59 pm.

If you are stuck, please ask questions on Discord or send me questions via email.

Turn in all of your answers on paper.

## Continuous Charge Distribution Approximation

In E&M, we often assume that point charges are continuously distributed. This problem addresses the accuracy of this approximation.

A line of length $2L$ is centered on the origin and lies between $-L\le x\le L$. The charge density, $\lambda_o$, on the line is uniform.

If the line is approximated by an odd number of point charges (odd number so a charge is always at the origin) separated by a distance $\Delta$ and is used to compute the approximate electric field $E_{ya}$ on the $y$-axis at $y=L$, how many charges are required so that

$$\left|\frac{E_{ye}(0,L)-E_{ya}(0,L)}{E_{ye}(0,L)}\right|\le 0.01$$

where the exact solution is given by $E_{ye}$. 

You may look up the exact solution, but cite your source. You may use any program or a calculator to solve this problem. Save your program as a file with name <code>HW1_1.ext</code>, where <code>ext</code> is the file extension for your program, e.g., <code>m</code>, <code>py</code>, etc.

Print out the code you used for your answer and write the actual answer it yields in a comment.

## Charge on Cylinder

Charge is uniformly distributed on the curved surface of a cylinder of length $h$ and radius $R$. The cylinder is centered on the origin, aligned with the $z$--axis, and has a uniform charge density of $\sigma_o$.

<img src="https://rweigel.github.io/phys305/figures/Continuous-Charge-Densities-Cylinder.svg"/>


Find $\mathbf{E}(z)$. Prior to doing any calculations, document limiting cases that you can use to check your answer.

## Reading

Next week, Gauss's law will be covered. Find at least one freshman--level textbook and read the sections that cover Gauss's law. Do the same for at least one upper--division undergraduate--level textbook (the references on the syllabus has a list of textbooks, but you may pick your own).

In the next class,

* We will have a general discussion on the the similarities and differences in how Gauss's law is presented and explained.
* I will randomly select students (or groups) to present the solution to a problem. Prepare notes for a 5--7 minute presentation. During your presentation, I will ask the class for clarifications and connections to other problems. You are welcome, and encouraged, to work with one or two other students on this.

Turn in your notes that you have prepared for a presentation.

# HW 2

(Other problems will be posted on August 31st)

## Field Lines

Many students have never actually written a program to draw field lines. In doing so, you'll gain a bit of insight into how the field line drawings you see in books are created. In addition, you'll appreciate some of the limitations of field lines. In the development of the theory of electricity and magnetism, the concept of a field line was central. (They were introduced by Faraday and Maxwell referred to and used them extensively.) In addition, the textbook emphasizes field lines and "tubes of flux".

**Background**

Consider a 2-D vector field defined by

$$\mathbf{F} = F_x(x,y)\hat{\mathbf{x}} + F_y(x,y)\hat{\mathbf{y}}$$

A field line is a line that is always tangent to the vector $\mathbf{F}$.  

To determine the equations that must be solved to find the field line, consider a differential distance $ds$ drawn in the direction of $\mathbf{F}$ at a given point. This step has a horizontal component of $dx$ and a vertical component of $dy$.  

<img src="https://rweigel.github.io/phys513/2022/figures/similar_triangles.svg"/>

The differential triangle is similar to a triangle formed with $a$ $F_x$ in the $x$-direction, $F_y$ in the $y$-direction, and $F$ as the hypotenuse so that

$$\frac{dx}{ds} = \frac{F_x(x,y)}{F(x,y)}$$

$$\frac{dy}{ds} = \frac{F_y(x,y)}{F(x,y)}$$

where $F(x,y)=\sqrt{F_x^2+F_y^2}$.

We have now formulated the statement "a field line is a line that is always tangent to the vector $\mathbf{F}(x,y)$" as a set of two differential equations. The field line corresponds to the solution for $x(s)$ and $y(s)$ and the quantity $s$ corresponds to the length of the field line.

To compute $x(s)$ and $y(s)$, we can solve the above equations in the same way that differential equations for the trajectory of a particle are solved. Using the Forward Euler approximation

$$\frac{dx}{ds} \simeq \frac{x(s+\Delta s)-x(s)}{\Delta s}$$

$$\frac{dy}{ds} \simeq \frac{y(s+\Delta s)-y(s)}{\Delta s}$$

gives

$$x(s+\Delta s) = x(s) + \Delta s\frac{F_x(x(s),y(s))}{F(x(s),y(s))}$$

$$y(s+\Delta s) = y(s) + \Delta s\frac{F_y(x(s),y(s))}{F(x(s),y(s))}$$

To find the field line, we must specify initial positions $x(0)$ and $y(0)$ and also a step size $\Delta s$ and then iterate the above two equations. Discretized, the above two equations are

$$x_{i+1} = x_i + \Delta s\frac{F_x(x_i,y_i)}{F(x_i,y_i)}$$

$$y_{i+1} = y_i + \Delta s\frac{F_y(x_i,y_i)}{F(x_i,y_i)}$$

**Problem**

The electric field caused by a $+q$ charge at $(x',y',z')$ is

$$\mathbf{E}(x,y,z) = kq\frac{(x-x')\hat{\mathbf{x}}+(y-y')\hat{\mathbf{y}}+(z-z')\hat{\mathbf{z}}}{\big[(x-x')^2+(y-y')^2+(z-z')^2\big]^{3/2}}$$

Write a program that draws the field lines in the $x$-$y$ plane for a dipole: $+q$ at $(x,y,z)=(d,0,0)$ and $-q$ at $(x,y,z)=(-d,0,0)$. You may use the Forward Euler method, but I encourage you to use a better algorithm using an existing library (such as MATLAB's <code>ODE45</code> or SciPy's <code>ODEINT</code> or <code>SOLVE_IVP</code>). I have intentionally not specified how many lines to draw or given values for $q$ and $d$.

**Sample Code**

As an example of solving two ODES, in the following, I solve the two equations

$\ds\frac{dx}{dt}=x \qquad \frac{dy}{dt}=-y$

numerically using the Forward Euler approximation. In this approximation, the equations can be rewritten as

$x_{i+1}=x_{i} + \Delta t x_i \qquad y_{i+1}=y_{i} - \Delta t y_i$

I use the parameter $\Delta t = 0.01$, which controls the accuracy of the solution. (Note that the Forward Euler approximation is not a good method for solving ODEs, but it is simple and easy to implement.)

*Spreadsheet*

In this [Spreadsheet](https://docs.google.com/spreadsheets/d/1AL08kI-UhRC2qocJcrxnJI52Ckd4w6jVyTn41J3qY5s/edit?usp=sharing), I solve the two equations using the Forward Euler approximation with $\Delta t = 0.01$.

*MATLAB*

You can access MATLAB using the Citrix Virtual Lab: https://its.gmu.edu/service/citrix-virtual-lab/. Make sure to install the app first. The instructions say it is recommended, but I was not able to get things to work until I installed the app.

```matlab
function ode_demo()

    %% Forward Euler
    dt = 0.01;

    t = 0;
    x(1) = 1;
    y(1) = 1;
    Nsteps = 100;

    fprintf('t\tx\ty\n')
    for i = 1:Nsteps-1
        fprintf('%.1f\t%.1f\t%.1f\n',t(i),x(i),y(i));
        x(i+1) = x(i) + dt*x(i);
        y(i+1) = y(i) - dt*y(i);
        t(i+1) = t(i) + dt;
    end

    plot(x,y);
    hold on;
    xlabel('x')
    ylabel('y')
    title('$dx/dt=x; dy/dt=-y$; x(0)=y(0)=1','Interpreter','Latex');

    %% Runge-Kutta

    function ret = dXdt(t, X)
        % For MATLAB ODE functions, must specify code that computes right-hand
        % side of differential equations. Here we have
        % dx/dt = x
        % dy/dt = -y
        %
        % Defining X = [x, y], in matrix notation
        %   dX/dt = [x; -y]
        ret = [X(1); -X(2)];
    end    

    [t, X] = ode45(@dXdt, [0, 1], [1, 1]);

    plot(X(:,1),X(:,2),'r-');

    legend('Forward Euler', 'Runge-Kutta 4-5');
end
```

Save your as a file with name <code>HW2_1.ext</code>, where <code>ext</code> is the file extension for your program, e.g., <code>m</code>, <code>py</code>, etc. Save a PDF or PNG of your plot and name it <code>HW2_1.png</code> or <code>HW2_1.pdf</code>. If you used a spreadsheet, you do not need to upload an image; instead upload the spreadsheet file (if you used Google Docs, create a file named <code>HW2_1.link</code> and paste the link to your Google Spreadsheet; make sure that your spreadsheet is visible to anyone with the link).