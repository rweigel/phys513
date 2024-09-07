# HW 1

Due September 5th at 11:59 pm.

If you are stuck, please ask questions on Discord or send me questions via email.

Turn in all of your answers on paper.

## Continuous Charge Distribution Approximation

In E&M, we often assume that point charges are continuously distributed. This problem addresses the accuracy of this approximation.

A line of length $2L$ is centered on the origin and lies between $-L\le x\le L$. The charge density, $\lambda_o$, on the line is uniform.

1. If the line is approximated by an odd number of point charges (so a charge is always at the origin) separated by a distance $\Delta$ and is used to compute the approximate electric field $E_{ya}$ on the $y$-axis at $y=L$, how many charges are required so that

   $$\left|\frac{E_{ye}(0,L)-E_{ya}(0,L)}{E_{ye}(0,L)}\right|\le 0.01$$

   where the exact solution is given by $E_{ye}$.

   You may look up the exact solution but cite your source. You may use any program or a calculator to solve this problem.

   Print out the code you used for your answer and write the actual answer it yields in a comment.

   Save your program as a file named `HW1_1.ext`, where `ext` is the file extension for your program, e.g., `m`, `py`, etc. You do not need to send me your code (unless you have a question about it), but in the future, I'll have you use GitHub to store your code with that filename.

## Charge on Cylinder

Charge is uniformly distributed on the curved surface of a cylinder of length $h$ and radius $R$. The cylinder is centered on the origin, aligned with the $z$--axis, and has a uniform charge density of $\sigma_o$.

<img src="https://rweigel.github.io/phys305/figures/Continuous-Charge-Densities-Cylinder.svg"/>

Find $\mathbf{E}(z)$. Prior to doing any calculations, document limiting cases that you can use to check your answer.

## Reading

Next week, Gauss's law will be covered. Find at least one freshman--level textbook and read the sections that cover Gauss's law. Do the same for at least one upper--division undergraduate--level textbook (the references on the syllabus has a list of textbooks, but you may pick your own).

In the next class,

* We will have a general discussion on the similarities and differences in how Gauss's law is presented and explained.
* I will randomly select students (or groups) to present the solution to a problem on the whiteboard. Prepare notes for a 5--7 minute presentation (no PowerPoint, only hand--written notes). During your presentation, I will ask the class for clarifications and connections to other problems. You are welcome and encouraged to work with one or two other students on this.

Turn in your notes that you have prepared for a presentation.

# HW 2

Due September 12th at 11:59 pm. Due to the fact that I forgot to post this on time, if you need an extensison, feel free to ask.

Upload your solutions to GitHub. Name all files associated with your solution as `HW2_x.EXT`, where `x` = 1, 2, 3, 4 is the problem from this homework and `EXT` is the file extension, e.g., `pdf`, `py`, `m`. Upload all files associated with your solution such as code and notes (in PDF).

If you are stuck, please ask questions on Discord or send me questions via email. Be prepared to answer questions about your answers to these problems. Even if you have not completed them, I will ask for your ideas on how to approach them.

## Limiting Behavior For Cylinder

In the previous HW, you computed the electric field along the centerline of a cylinder with a uniform surface charge on its curved surface.

Showing that the equation approaches the equation for a point charge at the origin when $z\gg R$ and $z\gg h$ is not trivial. (Plugging $R=0$ and $h=0$ gives $E_z(z)=0$.) To show that $E_z(z)$ has the correct limiting behavior mathematically is quite involved. As an alternative, we will check the limit graphically.

Create a plot of $E_z(z/R)/E_o$, where $E_o = kQ/R^2$ for (that is, plot $E_z/E_o$ vs $z/R$):

1. A point charge $Q$ at the origin
2. A ring of radius $R$ that is centered on the origin and lies in the $x$--$y$ plane with a uniformly distributed charge $Q$.
3. The cylinder considered on the previous homework assuming for three cases: $h/R=1$, $h/R=5$, and $h/R=100$.
 
Be prepared to provide a physical explanation for the features of the curves and the ratios of $h/R$.

## Checking Gauss's Law

Given a point charge $Q$ at the origin, compute the electric flux $\Phi_E=\int\mathbf{E}\bfcdot d\mathbf{A}$ through one face of a cube that is also centered on the origin using Coulomb's law and explicit evaluation of the integral.

## Charge on Concentric Thick Shells

Charge placed on concentric spherical conducting shells, the cross--section of which is shown. Both shells have a thickness of $t$. The inner shell has an outer radius of $a$ and a net charge of $-Q$. The outer shell has an inner radius of $b$ and a net charge of $+Q$. Assume that $Q$ is positive.

<img src="https://rweigel.github.io/phys260/Capacitance/figures/Spherical.svg">

Using Gauss's law and the fact that the electric field inside a conductor must be zero show that

1. there can be no charge on the inner surface of the inner conductor,

2. the charge on the inner surface of the outer conductor is $+Q$, and

3. there is no charge on the outer surface of the outer conductor.

4. Find the electric field in each of the five labeled regions and sketch a plot of $E/(kQ/a^2)$ versus $r/a$. Region 1. is the empty volume inside of the inner conductor, region 2. is the inner conductor, region 3. is the empty volume between the conductors, region 4. is the outer conductor, and region 5. is the region outside of the outer conductor. (Hint: Use Gauss's law several times; when not zero, the electric field should be proportional to $1/r^2$.)

## Scalar Potential

Because the electric field has the form of $\rhat/r^2$, it can be shown that we can always find a scalar function $\psi$ (which we call electric potential) such that

$$\mathbf{E}=-\boldsymbol{\nabla}\psi = -{\partial \psi \over \partial x}\xhat - {\partial \psi \over \partial y}\yhat - {\partial \psi \over \partial z}\zhat$$

It can be shown that this equation can be inverted:
   
$$\psi(\mathbf{r})-\psi(\mathbf{r}_o)=-\int_{\mathbf{r}_o}^{\mathbf{r}}\mathbf{E}\bfcdot d\mathbf{l}$$
   
where the integral is taken over _any_ path between the points given by $\mathbf{r}$ and $\mathbf{r}_o$.

In one dimension, assuming the integration path is radial, and choosing $\mathbf{r}_o$ to be the origin, we have
   
$$\psi(r)-\psi(0)=-\int_0^rE_r(r)dr$$
   
Using the electric field from problem [2.3.4](#charge-on-concentric-thick-shells) and assuming $\psi(0)=0$ (I will discuss why this choice is arbitrary in class), find and sketch a plot of $\psi/(kQ/a)$ versus $r/a$.
   
In class, I will ask for a physical explanation for why I will get the same result if I choose a different integration path. For example, if my integration path was radial, then tangential, then radial again. This is covered in most intro textbooks. I'll also ask why I ask for plots of dimensionless parameters in this problem and in other problems on this HW.

