# HW 1

Due September 5th at 11:59 pm.

If you are stuck, please ask questions on Discord or send me questions via email.

Turn in all of your answers on paper.

## Continuous Charge Distribution Approximation

In E&M, we often assume that point charges are continuously distributed. This problem addresses the accuracy of this approximation.

A line of length $2L$ is centered on the origin and lies between $-L\le x\le L$. The charge density, $\lambda_o$, on the line is uniform.

If the line is approximated by an odd number of point charges (so a charge is always at the origin) separated by a distance $\Delta$ and is used to compute the approximate electric field $E_{ya}$ on the $y$-axis at $y=L$, how many charges are required so that

$$\left|\frac{E_{ye}(0,L)-E_{ya}(0,L)}{E_{ye}(0,L)}\right|\le 0.01$$

where the exact solution is given by $E_{ye}$.

You may look up the exact solution but cite your source. You may use any program or a calculator to solve this problem.

Print out the code you used for your answer and write the actual answer it yields in a comment.

Save your program as a file named `HW1_1.ext`, where `ext` is the file extension for your program, e.g., `m`, `py`, etc. You do not need to send me your code (unless you have a question about it), but in the future, I'll have you use GitHub to store your code with that filename.

**Solution**

Assume a charge at x of $\lambda dx$, with $dx$ small enough to be such that it is effectively a point charge. If this is the case, the vector from $x$ to $y=h$ is
$\mathbf{r} = -x\xhat + y\yhat$ and so

$$d\mathbf{E} = k (\lambda dx) \rhat/r^2 = k (\lambda dx) \mathbf{r}/r^3 = k (\lambda dx) (-x \xhat + y \yhat)/r^3$$

To find the electric field due to a summation of these charges at $x$ from $-L$ to $L$, integrate the above expression.The exact solution is (Griffiths 4th Edition, example 2.2):

$$E_y=2k\lambda_oL\frac{1}{y\sqrt{y^2+L^2}}$$

We want to re-write this is a form that will allow cancellation of constants that were not given when the above ratio is computed. Using $\lambda_o=Q/2L$, we have

$$E_y=\frac{kQ}{L^2}\frac{1}{\ds\frac{y}{L}\left[1+\left(\frac{y}{L}\right)^2\right]^{1/2}}$$

With $y=L$, 

$$E_y=\frac{kQ}{L^2}\frac{1}{\sqrt{2}}$$

For a charge $Q$ at position $(x,y)$

$$E_y=kQ\frac{y}{(y^2+x^2)^{3/2}}$$

Setting $y=L$, this can be written as

$$E_y=\frac{kQ}{L^2}\frac{1}{\ds\left[1+\left(\frac{y}{L}\right)^2\right]^{3/2}}$$

To compute the field due to multiple charges, we need to place charges at $x=-L,-L+\Delta, ..., L$. The spacing $\Delta/L$ is $2/(N-1)$.


With $kQ/L^2$ term omitted, the sum is

$$S(N)\equiv\frac{1}{N}\sum_{i=-(N-1)/2}^{(N-1)/2}\frac{1}{\ds\left[1+(i\Delta)^2\right]^{3/2}}$$

Before implementing, check that this sum is correct by expanding it for $N=3$, $N=5$.

**Important**: I want to see checks like this in your code. In analytical problems you should always use limits to check answer. In numerical problems, you should always use some sort of check on a reduced problem to check your implementation. The following checks took me some time, but because I had them, I was able to catch errors very quickly and also have confidence in my result. In my code, I also created two plots to help me build confidence in my result; see below. I plotted the sum as a function of $N$ and verified that it converged to a constant value (initially it did not, because I forgot to divide sum by $N$). I also plotted the error as a function of $N$ to verify that it was monotonically decreasing. (If it started increasing at some value of $N$, I would know that something went wrong.)

$N=3$, $\Delta=1$ and we want the sum terms to correspond to charges at $x/L=-1, 0, $ and $1$.

$$S(N)=\frac{1}{3}\sum_{i=-1}^{1}\frac{1}{\ds\left[1+(i\Delta)^2\right]^{3/2}}=
\frac{1/3}{\ds\left[1+(-1)^2\right]^{3/2}}+
\frac{1/3}{\ds\left[1+(0)^2\right]^{3/2}}+
\frac{1/3}{\ds\left[1+(1)^2\right]^{3/2}}
$$

The result is $0.569035593728849$. This value is used in the following program as a check.

$N=5$, $\Delta=2/(N-1)=1/2$ and we want charges at $x/L=-1, -1/2, 0, 1/2, $ and $1$.

$$S(N)=\frac{1}{5}\sum_{i=-2}^{2}\frac{1}{\ds\left[1+(i\Delta)^2\right]^{3/2}}=
\frac{1/5}{\ds\left[1+(-1)^2\right]^{3/2}}+
\frac{1/5}{\ds\left[1+(-1/2)^2\right]^{3/2}}+
\frac{1/5}{\ds\left[1+(0/2)^2\right]^{3/2}}+
\frac{1/5}{\ds\left[1+(1/2)^2\right]^{3/2}}+
\frac{1/5}{\ds\left[1+(1\Delta)^2\right]^{3/2}}
$$

The result is $0.627638057357283$.

Notice the fact that the first two and last two terms evaluate to the same value. This can be used to reduce the number of computations.

To finish the problem, evaluate 

$$\left|\frac{1/\sqrt{2}-S(N)}{1/\sqrt{2}}\right|\le 0.01$$

or $|1-\sqrt{2}S(N)|\le 0.01$

for odd positive values of $N$ until the inequality is satisified. The result should be $N=51$. 

The following two figures were used to check my algorithm. [Source code](solns/HW1_1.m)

<img src="solns/HW1_1a.svg"/>

<img src="solns/HW1_1b.svg"/>

## Charge on Cylinder

Charge is uniformly distributed on the curved surface of a cylinder of length $h$ and radius $R$. The cylinder is centered on the origin, aligned with the $z$--axis, and has a uniform charge density of $\sigma_o$.

<img src="https://rweigel.github.io/phys305/figures/Continuous-Charge-Densities-Cylinder.svg"/>

Find $\mathbf{E}(z)$. Prior to doing any calculations, document limiting cases that you can use to check your answer.

**Answer**

Limiting cases:

* Expect zero at origin.
* Expect ring of charge solution as $h/R\rightarrow 0$
* Expect infinite cylinder solution when $h\gg R$

We also expect $E_z(z) = -E_z(z)$ (symmetry)

The field for uniformly charged ring in the $x$--$y$ plane and centered on the origin is

$$E_z=2\pi R\lambda k\frac{z}{\left(z^2+R^2\right)^{3/2}}=kQ\frac{z}{R^3}\frac{1}{\left(1+(z/R)^2\right)^{3/2}}$$

If the ring is translated along the $z$--axis by $z'$, this corresponds to a translation of the coordinate system and we can write

$$E_z=\frac{kQ}{R^2}\frac{\ds\left(\frac{z-z'}{R}\right)}{\ds\left(1+\left(\frac{z-z'}{R}\right)^2\right)^{3/2}}$$

If we consider differential rings of height $dz'$, their area is $2\pi Rdz'$ and charge is

$dQ=(2\pi Rdz')\sigma_o$

Replacing $E_z$ with $dE_z$ and $Q$ with $dQ$ in the last equation for $E_z$, we have

$$dE_z(z)=2\pi R k\frac{dz'}{R^2}\frac{\ds\left(\frac{z-z'}{R}\right)}{\ds\left(1+\left(\frac{z-z'}{R}\right)^2\right)^{3/2}}$$

and this must be integrated from $z'=-h/2$ to $z'=h/2$. The result is

$$E_z(z)=
\frac{kQ}{R^2}
\left[
\frac{1}{h_R\sqrt{(\frac{z}{R}-\frac{h_R}{2})^2+1}}-
\frac{1}{h_R\sqrt{(\frac{z}{R}+\frac{h_R}{2})^2+1}}
\right]
$$

where $h_R \equiv h/R$. 

(The solution was written in this form in anticipation for a problem on HW #2.)

Checks:

* $E_z(0)=0$ is satisfied.
* We expect ring of charge solution as $h/R=h_R\rightarrow 0$. However, when we plug this into the above, we get $1/0-1/0$, which is indeterminate.
* Expect infinitely long and uniformly charged cylinder solution when $h\gg R$ (or $h_R\gg 1$). When we plug this into the above, we get $0$. This can be shown to be correct using Gauss's law, from which it follows that $E_z=0$ at all points inside the cylinder (not only along $z$--axis, which we computed above).

The symmetry condition $E_z(z) = -E_z(z)$ is satisifed.

Addressing the last two limits requires a significant amount of effort ([see related problem](https://rweigel.github.io/phys685/hw.html#surface-current-on-cylinder)). In the next homework, you will consider an alternative approach.

## Reading

Next week, Gauss's law will be covered. Find at least one freshman--level textbook and read the sections that cover Gauss's law. Do the same for at least one upper--division undergraduate--level textbook (the references on the syllabus has a list of textbooks, but you may pick your own).

In the next class,

* We will have a general discussion on the similarities and differences in how Gauss's law is presented and explained.
* I will randomly select students (or groups) to present the solution to a problem of your choosing on the whiteboard. Prepare notes for a 5--7 minute presentation (no PowerPoint, only hand--written notes). During your presentation, I will ask the class for clarifications and connections to other problems. You are welcome and encouraged to work with one or two other students on this. Stated a different way, I would like you to review Gauss's law from multiple sources, pick a problem you think you can explain (it can be a textbook example problem, in which case explain it in your own words), and prepare a short presentation of the solution. We'll find that all solutions (even textbook examples) have many subtleties.


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