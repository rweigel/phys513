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

%\ifsolutions
**Solution**

The following plot was created using https://www.desmos.com/calculator/vg2dblcbfc. This page is interactive, so you can adjust the $h/R$ ratio.

Comments:

* By using the dimensionless ratio, we can easily compare the fundamental features of the cylinder equation using only one parameter. If instead we plotted $E$ vs $z$, we would need to plot the equation for many values of $R$ and $h$ to understand the full range shapes the equation can have.
* As $h/R$ decreases, the cylinder solution approaches the ring solution. For $h/R=0.1$, the lines for the ring and cylinder cannot be distinguished by eye.
* For $h/R=1$, the cylinder and ring curves increasingly overlap starting at approximately $z/R=1$. This means the cylinder field is becoming more and more like the ring field as $z/R$ increases, which is expected.
* The ring and cylinder curves (for $h/R=1$) overlap with the point charge curve for large $z/R$. This is expected because both being to "look" like a point charge as you move away from them.
* The explanation for the curve approaching zero as $r/R$ increases is in this limit, the cylinder appears to be "long". Inside of an infinitely long cylinder $h/R\rightarrow \infty$, the field is zero (even off--axis). This can be shown by using Gauss's law.
* All curves have odd symmetry ($E(-z)=-E(z)$), as expected -- the field for $z>0$ is positive and the field for $z<0$ is negative. (The image below only shows $z/R > 0$.)

<img src="solns/HW2_2.png" width="500px"/>
%\fi

## Checking Gauss's Law

Given a point charge $Q$ at the origin, compute the electric flux $\Phi_E=\int\mathbf{E}\bfcdot d\mathbf{A}$ through one face of a cube that is also centered on the origin using Coulomb's law and explicit evaluation of the integral.

%\ifsolutions

**Solution**

From Gauss's law, the net flux through any _closed_ surface is $Q_{encl}/\epsilon_o$. The net flux through the cube's surface is $Q/\epsilon_o$, and the flux must be the same through each face, so we expect the answer to be $Q/6\epsilon_o$. In this problem, you are being asked to show that you get the same result without using Gauss's law.

Several students solved for case when cube was not centered on the origin but rather had one corner at the origin and edges along the cartesian coordinate axes. In this case, one can conclude the flux through one face should be $Q/24\epsilon_o$. This is equivalent to asking if we split the given cube into $8$ sub--cubes, what is the flux through the outer face of one of the sub-cubes. In this case, the face area of the sub--cube is $1/4$ of the area of the main cube. In addition to being the wrong problem, the solution given does not use Coulomb's law and explicit evaluation of the integral. (The motivation for this problem is to reinforce the idea that Gauss' law holds for arbitrary surfaces and as practice for setting up integration.)

In general,

$\mathbf{r}=x\xhat + y\yhat + z\zhat$. If we assume the side length is $2a$, then for the top side, $\mathbf{r}=x\xhat + y\yhat + a\zhat$.

We need to evaluate

$$\Phi_E=\int_{\text{top}}\mathbf{E}\bfcdot d\mathbf{A}$$

Using

$\ds\mathbf{E}=kq\frac{\mathbf{r}}{r^3}$ and $d\mathbf{A}=dxdy\hat{\mathbf{z}}$, the integral is

$$\Phi_E=kq\int_{-a}^{a}dy\int_{-a}^{a}\frac{adx}{\sqrt{a^2+x^2+y^2}^{3/2}}$$

or, nondimensionalizing the integral using $x\rightarrow x/a$ and $y\rightarrow y/a$,

$$\Phi_E=kq\int_{-1}^{1}dy\int_{-1}^{1}\frac{dx}{\sqrt{1+x^2+y^2}^{3/2}}$$

Defining $b^2=1+y^2$ and using [Wolfram Alpha for the integration](https://www.wolframalpha.com/input?i=integrate+1%2F%28sqrt%28b%5E2%2Bx%5E2%29%29%5E%283%29+from+-1+to+1), we have

$$\Phi_E=kq\int_{-1}^{1}dy\frac{2}{(1+y^2)\sqrt{2+y^2}}$$

Using [Wolfram Alpha](), $\Phi_E=kq(2\pi/3)=q/6\epsilon_o$.
%\fi

## Charge on Concentric Thick Shells

Charge placed on concentric spherical conducting shells, the cross--section of which is shown. Both shells have a thickness of $t$. The inner shell has an outer radius of $a$ and a net charge of $-Q$. The outer shell has an inner radius of $b$ and a net charge of $+Q$. Assume that $Q$ is positive.

<img src="https://rweigel.github.io/phys260/Capacitance/figures/Spherical.svg">

Using Gauss's law and the fact that the electric field inside a conductor must be zero show that

1. there can be no charge on the inner surface of the inner conductor,

   **Answer**: A Gaussian sphere with a surface inside the inner conductor has $E=0$ on its surface (b/c $E$ inside a conductor is zero). Based on $\oint \bfvec{E}\bfcdot d\mathbf{l}=Q_{\text{encl}}/\epsilon_o$, this implies $Q_{\text{encl}}=0$. (Note that all charges must be on the surface of a conductor, so the only possible location for the charge is on the inner and outer surfaces.)

2. the charge on the inner surface of the outer conductor is $+Q$, and

    **Answer**: A Gaussian sphere with its surface inside the outer conductor has $E=0$ on its surface (b/c $E$ inside a conductor is zero). Based on $\oint \bfvec{E}\bfcdot d\mathbf{A}=Q_{\text{encl}}/\epsilon_o$, this implies $Q_{\text{encl}}=0$. The charge on the inner conductor was given as $-Q$. To make the charge inside the Gaussian sphere zero, we need $+Q$ on the inner surface of the outer conductor to get $Q_{\text{encl}}=0$.

3. there is no charge on the outer surface of the outer conductor.

    **Answer**: If the total charge on the outer conductor is $+Q$ and all of it is on its inner surface, but conservation of charge, there is no charge on its outer surface. Recall that charges arrange themselves on a conductor to make the electric field inside all conductors zero. With this charge arrangement, the field due to the charges on the outer surface of the inner conductor cancels the field due to the charge on the inner surface of the outer conductor for $r>b$.

4. Find the electric field in each of the five labeled regions and sketch a plot of $E/(kQ/a^2)$ versus $r/a$. Region 1. is the empty volume inside of the inner conductor, region 2. is the inner conductor, region 3. is the empty volume between the conductors, region 4. is the outer conductor, and region 5. is the region outside of the outer conductor. (Hint: Use Gauss's law several times; when not zero, the electric field should be proportional to $1/r^2$.)

   **Answer**: 1. $E=0\quad$ 2. $E=0\quad$ 3. $E/(kQ/a^2)=-1/(r/a)^2\quad$ 4. $E=0\quad$ 5. $E=0$

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

**Solution**

In region 1, $\ds\psi(r)-\psi(0)=-\int_0^r 0 dr \Rightarrow \psi(r)=0$ and $\psi(a-t)=0$.

In region 2, $\ds\psi(r)-\psi(a-t)=-\int_{a-t}^r 0 dr \Rightarrow \psi(r)=0$ and $\psi(a)=0$.

The fact that the potential is constant in region 2. is consistent with the expectation that a conductor is an equipotential.

In region 3, $\ds\psi(r)-\psi(a)=kQ\int_a^r 1/r'^2 dr' \Rightarrow \psi(r) = kQ(1/a-1/r)$ and so $\psi(b)=kq(1/a-1/b)$

In region 4., the potential will be the same as in region 3. because a conductor is an equipotential: $\psi(r)=\psi(b)$

In region 5., assuming the outer radius of the outer shell is $c$, $\ds\psi(r)-\psi(c)=-\int_c^r 0 dr \Rightarrow \psi(r)=\psi(c)$. Because $\psi(r)$ in region 4. is constant and equal to $\psi(b)$, $\psi(c)=\psi(b)$.

# HW 3

Due September 19th at 11:59 pm. 

Upload your solutions to GitHub. Name all files associated with your solution as `HW3_x.EXT`, where `x` = 1, 2, 3 is the problem from this homework and `EXT` is the file extension, e.g., `pdf`, `py`, `m`. Upload all files associated with your solution such as code and notes (in PDF). If your PDF is larger than a few MB, [compress it](https://www.adobe.com/acrobat/online/compress-pdf.html).

If you are stuck, please ask questions on Discord or send me questions via email. Be prepared to answer questions about your answers to these problems. Even if you have not completed them, I will ask for your ideas on how to approach them.

## Concentric Spheres and a Charged Shell

Suppose problem 2.3 is modified so that there is also a uniformly charged spherical shell with a radius $(a + b)/2$ and a total charge of $Q/2$.

1. Find the electric field in the five labeled regions and sketch a plot of $E/(kQ/a^2)$ versus $r/a$.
2. Do the same for the electric potential and plot $\psi/(kQ/a)$ versus $r/a$. Assume the potential at $r=0$ is zero.
3. In this problem the electric field "jumps" when crossing over charges on a surface. (That is, there is a discontinuity in the $E(r)$ plot.) For each of the jumps in the plot of $E$, find the ratio of the change in $E$ across the discontinuity and the charge density at the discontinuity.

**Comments**:
1. This was discussed in class. For a sketch, I set $b=2a$ to simplify.
2. One can visualize the answer by inverting the sketch from 1. and asking what the cumulative sum of that plot will look like. A key feature is that the curve is continuous (but the first derivative, related to $E$, will be discontinuous). Many students had discontinuities.
3. The jumps should be $\sigma/\epsilon_o$, where $\sigma$ is the surface charge density at the location of the jumps.

I will not post solutions because there are many ways of checking your answer; you may want to try this problem again in case it shows up on an exam.

## Capacitance for a Long Cylinder

In class, I covered how to compute capacitance for (a) large conducting planes with a small separation distance and (b) the system in HW 2.3. This was done using two methods:

1. Gauss's law (put $+Q$ on one conductor $-Q$ on another, use Gauss's law to find $E$, use $E$ to compute the potential difference, then use $C=Q/|\Delta \psi|$
2. Laplace's equation (put one conductor at a potential of $V_o$ and the other at $0$; solve $\nabla^2\psi=0$ for $\psi$, compute $E$ and use it to find $\sigma$; from $\sigma$, compute $Q$; then use $C=Q/|\Delta \psi|$.)

Use these two methods to find the capacitance of two equal-length and long concentric cylinders. Assume the diagram in HW 2.3 is the cross-section. 

**Comment**: Most students used the equation for the spherical problem for both parts. For part 1., $E\sim 1/r$ (see intro books which cover this). For part 2., the Laplacian in cylindrical coordinates, not spherical, should be used. It is

$$\nabla^2 = \frac{1}{s}\frac{\partial}{\partial s}\left(s\frac{\partial\Phi}{\partial s}\right)$$

where $s$ is the radial cylindrical coordinate. If you made this error, try the problem again and verify that you get the same answer for parts 1. and 2.

## Laplace's Equation in Two Dimensions -- Numerical

1. Verify the numbers in the Step 1 column of Table 1.20 of Ramo. Show your calculations on a piece of paper. (In class, we will develop a program to compute the potentials in the other columns.)

2. Find the equation for this problem's exact potential if all sides are set to have zero potential except the side at $80\text{ V}$ (you do not need to derive -- citing a reference is acceptable). I recommend finding a solution first and using it to answer this part; if you have time, attempt to derive it.

(If you want to work ahead, develop a numerical solution to this problem and compare it to the exact solution.)

**Answers**

1.
   * $\Phi_1=77.50$
   * $\Phi_2=65.62$
   * $\Phi_3=70.62$
   * $\Phi_4=54.06$
2. This problem is given in many books as an example and here I expected you to research to find a solution. Problem 3.54 of Griffiths 4th Edition has a solution for the case when the origin is at the bottom center of the duct, the top is held at $V$, the width is $2b$ and the height is $a$.

   $$\Phi(x,y) = -\frac{2V}{b}\sum_{n=1}^{\infty}\frac{(-1)^n}{\alpha_n}\frac{\sinh(\alpha_n y)}{\sinh(\alpha_n a)}\cos(\alpha_n x)$$

   where $\alpha_n=(2n-1)\pi/2b$. To transform this to the problem we are given, first set the width $2b$ to $1$ and height $a=1$. Then

   $$\Phi(x,y) = -4V\sum_{n=1}^{\infty}\frac{(-1)^n}{\alpha_n}\frac{\sinh(\alpha_n y)}{\sinh(\alpha_n)}\cos(\alpha_n x)$$

   $\alpha_n=(2n-1)\pi$. If we choose a coordinate system the is centered on the right edge of Figure 1.20a with $y$ to the left and $x$ upwards, this equation can be used.

   One can show that if the origin is placed at the lower left of the duct in Figure 1.20a, with $x$ to the right and $y$ up, the potential is
   $$\Phi_l(x,y)=\frac{4V}{\pi}\sum_{n=1,3,...}^\infty \frac{\sin(n\pi y/y_0)}{n\sinh (n\pi y_0/x_0)}\sinh\left[n\pi(x_0-x)/y_0\right]$$

   where $V=80\text{ V}$ and the width $x_o=1$ and height $y_o=1$.
%\fi

# HW 4

Due September 26th at 11:59 pm.

Upload your solutions to GitHub. Name all files associated with your solution as `HW4_x.EXT`, where `x` = 1, 2, 3 is the problem from this homework and `EXT` is the file extension, e.g., `pdf`, `py`, `m`. Upload all files associated with your solution such as code and notes (in PDF). If your PDF is larger than a few MB, [compress it](https://www.adobe.com/acrobat/online/compress-pdf.html).

## Laplace's Equation in 1--D Cylindrical -- Numerical

1. Use similar steps to derive a numerical algorithm for solving numerically solving Laplace's equation in 1--D cylindrical. (In class, I discussed solving the spherical version of this problem.)

2. If $\Phi(r=2)=1$ and $\Phi(r=1)=0$, use your algorithm from 1. to find the potential at $r=1.5$. (Use a grid with points at $r=1$, $r=1.5$, and $r=2$.)
3. Repeat 2. using a grid with points at $r=1$, $r=4/3$, $r=5/3$, and $r=2$.

**Answers**

$$\psi(s) = \frac{1}{2}\left[\left(1+\frac{h}{2s}\right)\psi(s+h) + \left(1-\frac{h}{2s}\right)\psi(s+h)\psi(s-h)\right]$$

1. $\psi(3/2) = 7/12$
2. $\psi(4/3) = 0.414226$, $\psi(5/3) = 0.736402$

## 1--D Spherical 

A spherical shell of radius $r_o=(a + b)/2$ and a uniform charge density $\sigma_o$ is concentric with 
conducting spheres with the inner sphere having radius $a$ and the outer radius $b$. Both conducting spheres are at zero potential.

1. In the previous homework, you used Gauss's law to find the $E(r)$ and $V(r)$ for the same geometry and were given the charge on each surface. In this problem, use the fact that in the regions $[a, r_o]$ and $[r_o,b]$, $\nabla^2\Phi=0$ the fact that $\Phi(a)=\Phi(b)=0$ to find $\Phi(r)$ for $a\le r \le b$.

   You will need to use the fact that the potential is continuous, so $\Phi_1(r_o)=\Phi_2(r_o)$ and also a condition that relates the electric field at $r=r_o^-$ and $r=r_o^+$.


2. Find the charge on both conductors.

**Answers**

1. &nbsp;

   $\displaystyle\psi_i=-\frac{\sigma_or'^2}{\epsilon_o}\left(\frac{1}{\frac{1}{b}-\frac{1}{c}}\right)\left(\frac{1}{r'}-\frac{1}{c}\right)\left(\frac{1}{r}-\frac{1}{b}\right)$

   $\displaystyle\psi_o=-\frac{\sigma_or'^2}{\epsilon_o}\left(\frac{1}{\frac{1}{b}-\frac{1}{c}}\right)\left(\frac{1}{r'}-\frac{1}{b}\right)\left(\frac{1}{r}-\frac{1}{c}\right)$


2.  &nbsp;

   $\displaystyle q_i=-q'\left(\frac{1}{\frac{1}{b}-\frac{1}{c}}\right)\left(\frac{1}{r'}-\frac{1}{c}\right)$

   $\displaystyle q_o=+q'\left(\frac{1}{\frac{1}{b}-\frac{1}{c}}\right)\left(\frac{1}{r'}-\frac{1}{b}\right)$

where $r'=(a+b)/2$ and $q'=4\pi r'^2\sigma_o$.

## A Model of Polarization

In Example 4.3 of Griffiths (3rd and 4th Edition), he models a polarized sphere by using two uniformly charged spheres with centers that are separated by a small distance. 

In this problem, a polarized slab will be modeled using two slabs of charge with uniform and opposite charge density that are offset by a small distance $\delta$.

1. Find $\mathbf{E}^+(y)$ for the slab with uniform charge density $\rho_o$ shown in the following figure. Assume that the slab is infinite in extent in the $\pm z$ and $\pm x$ directions so that Gauss's law can be used to find $\mathbf{E}$. (This slab can be thought of as being composed of thin sheets of charge stacked together, so an alternative to using Gauss's law is to sum the electric field due to sheets of charge.)

   <img src="https://rweigel.github.io/phys305/figures/Gausss_Law_Uniform_Slab.svg"/>

2. Sketch (by hand is fine) $\mathbf{E}^+(y)$ vs $y$. Label key points on the $y$--axis.

3. Next, compute and sketch (by hand is fine) $\mathbf{E}^-(y)$ for the same slab if it had charge density of $-\rho_o$ and was shifted by $-\delta$ in the $y$--direction. Assume that $\delta\ll t$.

4. Compute and sketch $\mathbf{E}^+ + \mathbf{E}^-$.

The primary motivation of this problem is to justify the claim that the field of a polarized object can be computed not by finding the field due to all of the dipoles but rather by finding the field created by so--called "bound" charge densities. Here, the field due to the dipoles approaches the field due to sheets of charge. This fact is addressed in the following problem.

**Answer**

Details on how to solve this problem were given in class and so only a summary is given here.

1\. Gauss's law can be used to find the field for $|y|\ge t/2$ (a cylinder centered on the origin or with its bottom cap at $y=0$ can both be used). This gives $E\_y=\pm \rho_o t/2\epsilon_o$ above/below the slab. Inside the slab, we know $E_y=0$ at $y=0$ because the field due to the upper part of the slab cancels that due to the lower part. We also expect that inside the slab, $E\_y(y)$ field will increase linearly (why?). From this, we can write $E\_y(y)=\rho_o y/\epsilon_o$. This equation gives zero at the origin and matches the outer field at $y=\pm t/2$. Alternatively, we can also use Gauss's law. For a cylinder centered on the origin and height $2y$, the charge enclosed is $\rho_o 2y$.

2\. To simplify notation, use $E'_y=E_y/E_o$, $y'=y/t$, and $\delta'=\delta/t$ with $E_o=\rho t/2\epsilon_o$. Then

$$
E'^+_y = \begin{cases}
  1  & y \ge 1\\
  y' & |y'| \le 1 \\
  -1  & y' \le -1
\end{cases}
$$

See https://www.desmos.com/calculator/uhuz9paddg

3\. Invert the sketch from 2. and then translate it by $\delta$ in the $-y$ direction. Inside the negatively charged slab, the field will be $E\_y(y)=-\rho_o (y+\delta)/\epsilon_o$. (This gives $E_y=0$ when $y=-\delta$, corresponding to the center of the negatively charged slab.)

$$
E'^-_y = \begin{cases}
  1  & y \ge 1-\delta'\\
  y' & |y'+\delta'| \le 1 \\
  -1  & y' \le -1-\delta'
\end{cases}
$$

See https://www.desmos.com/calculator/uhuz9paddg

4\. In the region of overlap we need to sum

$E\_y(y) = E^+\_y(y) + E^-\_y(y)$

Using $E^+\_y(y)=\rho_o y/\epsilon_o$ and $E^-\_y(y)=-\rho_o (y+\delta)/\epsilon_o$ gives

$E\_y(y) = -\rho_o\delta/\epsilon_o$

See https://www.desmos.com/calculator/uhuz9paddg
## Polarized Cylinder

For background, see Griffiths 4.1--4.4, Introduction to Electrodynamics (3rd or 4th Edition).

A result in section 4.2 is that the electric potential (and also electric field, which is related to electric potential) of a polarized object can be found by computing the bound surface and volume charge densities $\sigma_b$ and $\rho_b$, respectively. That is, instead of computing the electric field due to each dipole in a polarized object, we can get the same answer by computing the electric field due to $\sigma_b$ and $\rho_b$ by using the same methods used to find the electric field due to ordinary charges $\sigma$ and $\rho$ (Gauss's law or solving the Poisson equation).

Suppose a cylinder of radius $a$ has $\mathbf{P}=P_o\hat{\mathbf{s}}$, where $s$ is the cylindrical radial coordinate. The cylinder is long, and its centerline is the $z$ axis.

1. Find $\sigma_b$ and $\rho_b$.
2. Compute the total bound charge.
2. Find $\mathbf{E}_b(s)$, which is the electric field due to $\sigma_b$ and $\rho_b$.

**Solution**

1. $\sigma_b=P_o$ at $r=a$; $\rho_b=-P_o/s$ for $r\le a$.
2. 0, as expected because polarization is created by dipoles with a net charge of zero.
3. $E_s=-P_o/\epsilon_o$

# HW 5

Due Friday, October 4th at 11:59 pm.

## Laplace's Equation in 2-D Cartesian -- Numerical

Determine if the "Correct Potentials" column in Table 1.20 of Ramo are correct using the analytical solution covered in HW 3.3.

Write out the equations that were evaluated to compute the potentials in a file named `HW5_1.pdf` and any code as `HW5_1.ext`, where ext is the file name extension for the language, e.g., `m` or `py`. (As before, you do not need to derive the analytical solution -- you can simply cite the source of one and adapt it to this problem.)

**Answer**

Problem 3.54 of Griffiths 4th Edition has a solution for the case when the origin is at the bottom center of the duct, the top is held at $V$, the width is $2b$ and the height is $a$.

$$\Phi(x,y) = -\frac{2V}{b}\sum_{n=1}^{\infty}\frac{(-1)^n}{\alpha_n}\frac{\sinh(\alpha_n y)}{\sinh(\alpha_n a)}\cos(\alpha_n x)$$

where $\alpha_n=(2n-1)\pi/2b$. To transform this to the problem we are given, first set the width $2b$ to $1$ and height $a=1$. Then

$$\Phi(x,y) = -4V\sum_{n=1}^{\infty}\frac{(-1)^n}{\alpha_n}\frac{\sinh(\alpha_n y)}{\sinh(\alpha_n)}\cos(\alpha_n x)$$

$\alpha_n=(2n-1)\pi$. If we choose a coordinate system the is centered on the right edge of Figure 1.20a with $y$ to the left and $x$ upwards, this equation can be used.

One can show that if the origin is placed at the lower left of the duct in Figure 1.20a, with $x$ to the right and $y$ up, the potential is

$$\Phi_l(x,y)=\frac{4V}{\pi}\sum_{n=1,3,...}^\infty \frac{\sin(n\pi y/y_0)}{n\sinh (n\pi y_0/x_0)}\sinh\left[n\pi(x_0-x)/y_0\right]$$

where $V=80\text{ V}$ and the width $x_o=1$ and height $y_o=1$. Similar coordinate changes can be made to find the solution to the problem where only the right/to/bottom side is at a non--zero potential and then by superposition, $\Phi = \Phi_l + \Phi_r + \Phi_t + \Phi_b$.

I get, with 33 terms in sum

* $\Phi_1=78.07$ (book $75.2$)
* $\Phi_2=62.39$ (book $60.5$)
* $\Phi_3=67.61$ (book $65.4$)
* $\Phi_4=51.93$ (book $50.7$)

See [HW5_1.py](solns/HW5_1.py).

## Capactor with Dielectrics -- Analytical

(Related problems are in section 1.15 of Ramo and example 4.5 of Griffiths 3rd and 4th edition.)

A large parallel plate capacitor is half--filled with two linear dielectrics with permittivities of $\epsilon_1$ and $\epsilon_2$. Assume that the capacitor is large enough that the potential only varies in the $x$--direction. In the diagram, the dotted rectangle is the cross--section of a Gaussian cylinder referenced in parts 4. and 5.

<img src="figures/Capacitor_With_Dielectric.svg"/>

1. Solve $\nabla^2 \psi=0$ in each dielectric using $\psi_1(0)=0$, $\psi_2(2d)=V_o$, $\psi_1(d)=\psi_2(d)$ and $D_1(d)=D_2(d)$.

2. Verify that when $\epsilon_1=\epsilon_2=\epsilon_o$, the answer is as expected from a problem solved previously in class.

Using your answer to 1.,

3. use $\sigma_b=\mathbf{P}\bfcdot\hat{\mathbf{n}}$ to find the four bound surface charge densities (that is, the bound charge density on the left and right surfaces on both dielectrics);

Save your answer in a file named `HW5_2.pdf`.

**Answers**

1. &nbsp;

   $$\frac{V_1}{V_o} = \left(\frac{\epsilon_2}{\epsilon_1+\epsilon_2}\right)\frac{x}{d}$$ 

   $$\frac{V_2}{V_o} = \left(\frac{\epsilon_1}{\epsilon_1+\epsilon_2}\right)\frac{x}{d} + \frac{\epsilon_2-\epsilon_1}{\epsilon_1+\epsilon_2}$$

2. In this case, $V_1/V_o = V_2/V_o = x/2d$, which is a solution to Laplace's equation that matches the boundary conditions (and so is the unique solution).

3. Assuming the dielectrics are linear so that $\mathbf{P}=\epsilon_o\chi_e\mathbf{E}=-\epsilon_o\chi_e\boldsymbol{\nabla}V$. This gives the general result
   
   $$\sigma_b = -\epsilon_o\chi_e\boldsymbol{\nabla}V\bfcdot\hat{\mathbf{n}}$$

   For dielectric 1 on the right face, $\hat{\mathbf{n}}=\xhat$, so 
   
   $$\sigma_{b1r}=-\epsilon_o\chi_{e1}\left(\frac{\epsilon_2}{\epsilon_1+\epsilon_2}\right)\frac{V_o}{d}$$
   
   On the left face $\hat{\mathbf{n}}=-\xhat$, so the density has the opposite sign.

   For dielectric 2 on the right face, $\hat{\mathbf{n}}=\xhat$.

   $$\sigma_{b2r}=-\epsilon_o\chi_{e2}\left(\frac{\epsilon_1}{\epsilon_1+\epsilon_2}\right)\frac{V_o}{d}$$

   On the left face $\hat{\mathbf{n}}=-\xhat$, so the density has the opposite sign.

   To answer the question in terms of the parameters given, use the definition $\epsilon = \epsilon_o(1+\chi_e)$.

## Capactor with Dielectrics -- Numerical

Find a numerical approximation of the (1--D) potential for the previous problem. Do this using the "Simple Averaging Method" described in Example 1.20 of the textbook. Use grid points at $x=0, d/2, d, 3d/2$, and $2d$. You only need to find the approximation using one step of the simple averaging method.

Hint: For any grid point that is not at $x=d$, the potential is simply the average of the potentials to the left and right. For a grid point at $x=d$, you will need to find an equation that numerically implements the exact condition $D_1(d)=D_2(d)$. If your grid points are at $x=0, d$, and $2d$, the only equation that you will solve is the equation for the condition $D_1(d)=D_2(d)$. Try this version of the problem first. Does it give a sensible result when $\chi_{e2}\rightarrow \infty$ or if $\epsilon_1=\epsilon_2$?

Save your derivation and numerical values for the potential in a file named `HW5_3.pdf` and any code as `HW5_2.ext`, where ext is the file name extension for the language, e.g., `m` or `py`.

# HW 6

Problem 1. due at the start of class. Problems 2. and 3. due on Friday, October 11th at 11:59 pm.

## Mid-term problems

**This problem is due at the start of class on October 10th.**

The midterm notes I mentioned in class are
* The problems will be based on concepts covered in homework problems.
* I will look at the homework problems, identify the concepts, and write questions that can be solved in the allotted time.
* You are encouraged to find problems related to the homework problems in other resources and attempt them.

Find at least one problem that you think would be a good problem to know how to solve in order to be prepared for the exam.

Write the problem out on a sheet of paper and turn it in at the start of class.

During class, I'll write the problems on the board and give you time to think about the key concepts and steps.

## Trajectory

At $t=0$ and the position $(x,y,z) = (x_o, 0, 0)$, a particle with charge $q$ is given an initial velocity $\mathbf{v}_o=(v_{ox}, 0, 0)$ in a region of space where there is no electric field and the magnetic field is dipolar and given by (in spherical coordinates)

%$$\mathbf{B}=\frac{\mu_o}{4\pi}\frac{\pi b^2}{r^5}\left(3xz\hat{\mathbf{x}}+3yz\hat{\mathbf{y}}+(3z^2-r^2)\hat{\mathbf{z}}\right)$$

$$\mathbf{B}=\frac{B_o}{r^3}\left(2\cos\theta\mathbf{\hat{r}}+\sin\theta\boldsymbol{\hat{\theta}}\right)$$

%where $R_E=6.37\cdot 10^6 \text{ m}$, $B_o=3.12\cdot 10^{-5}\text{ T}$, and $v_{ox}=1.4\cdot 10^7\text{ m/s}$. There is no electric field.

In class, I discussed a numerical algorithm for finding the trajectory of a particle in a magnetic field by starting with

$$m\frac{d\mathbf{v}}{dt} = q\mathbf{v}\times\mathbf{B}$$

using the "Forward Euler" method:

$$\frac{v_x(t+\Delta t)-v_x(t)}{\Delta t} = \frac{q}{m}\Big[\mathbf{v}(t)\times\mathbf{B}\big(x(t),y(t)\big)\Big]_x$$

$$\frac{v_y(t+\Delta t)-v_y(t)}{\Delta t} = \frac{q}{m}\Big[\mathbf{v}(t)\times\mathbf{B}\big(x(t),y(t))\big)\Big]_y$$

$$\frac{x(t+\Delta t)-x(t)}{\Delta t}=v_x(t)$$

$$\frac{y(t+\Delta t)-y(t)}{\Delta t}=v_y(t)$$


Use this method to find $x, y, v_x$, and $v_y$ at $t=\Delta t$.

Then, using the results for $t=\Delta t$, find $x, y, v_x$, and $v_y$ $t=2\Delta t$.

(In a future homework assignment, you will find the trajectory over a long period of time using a better algorithm. For this homework, I want you to understand the basic algorithm.)

## Ampere's law

The figure shows the cross--section of two square planes that are "large", meaning that their side length is much larger than $t$. A surface current of $\mathbf{K}=K_o\zhat$ flows on the bottom plane ($K_o$ has units of Amps/meter); the top plane has a surface current of $\mathbf{K}=-K_o\zhat$. (To understand a surface current, think of it as being created by placing many long straight wires side--by--side; in the diagram, the wires would be perpendicular to the page.)

Use Ampere's law to find the magnetic field for all $y$. Justify all of your steps. Note that most of the steps involve starting with the most general solution, $\mathbf{B}(x,y,z) = B_x(x,y,z)\xhat + B_y(x,y,z)\yhat + B_z(x,y,z)\zhat$, and making symmetry arguments such that integration in Ampere's law is not needed.

<img src="figures/Two_Planes.svg"/>

**Answer**

If one considers the sheets to be composed straight wires, then one can argue that any field must be in the $x$ direction - at any point in space, there are two wires whose field sums to horizontal, and an infinite uniform sheet can be created by placing two such wires at a time on the sheet (to see this, use the Biot-Savart result for an infinite wire, the field is tangent to a circle centered on the wire; make sure that you can draw a diagram that justifies this paragraph).

As a result, $\mathbf{B}(x,y,z) = B_x(x,y,z)\xhat$. If the system is infinite in the $x$ and $z$ directions, there can be no dependence on these coordinates, so $\mathbf{B}(x,y,z) = B_x(y)\xhat$.

At this point, we can use Ampere's law. Although it is possible to use Ampere's law twice on the given system, it is easier to find the field due to one of the sheets and then use superposition.

<img src="figures/Two_Planes_Solution.svg"/>

$$\oint \mathbf{B}\bfcdot d\mathbf{l}=\mu_oI_{\text{encl}}=\int_{1}\mathbf{B}\bfcdot d\mathbf{l}+\int_{2}\mathbf{B}\bfcdot d\mathbf{l}+\int_{3}\mathbf{B}\bfcdot d\mathbf{l}+\int_{4}\mathbf{B}\bfcdot d\mathbf{l}$$

The sign of $I_{\text{encl}}$ depends on the direction of integration around the Amperian loop. Choosing clockwise integration, $I_{\text{encl}}=+K_od$, where $d$ is the width of the Amperian loop. (The sign of $I_{\text{encl}}$ is positive if you wrap your fingers around loop in the direction of integration and the flow of current through the loop is in the direction of your thumb.) 

Therefore, we are left with

$$\mu_oI_{\text{encl}} = -B_2(y)w + B_4(y)w$$

where we have assumed the unknown $B_2$ and $B_4$ are in the positive $x$ direction. It may seem we are stuck, but we can argue that $B_2=-B_4$, that is the field a distance above the sheet must be equal in magnitude and opposite in sign to the field the same distance below the sheet.

The final result is that the field is $\mu_oK_o/2\xhat$ above the blue sheet and $-\mu_oK_o/2\xhat$ below the sheet.

Finally, we can use superposition to conclude that the field is $-\mu_oK_o\xhat$ between the sheets and zero otherwise.

# HW 7

Due on Friday, October 25th at 11:59 pm. Upload your code to your GitHub repository.

In HW 6.2, you solved for the first few steps of a charged particle in a magnetic field. In this problem, you will solve for the trajectory for a longer period of time.

Assume the particle is a proton with kinetic energy of $10\text{ MeV}$ (ignore relativistic effects) so $v_{ox}=10^7\text{ m/s}$. For the initial position, use $x_o=2R_E$, where $R_E$ is Earth's radius. Finally, for $B_o$, use $3\cdot 10^{-5} \text{ T}$.

Note that the $r$ in the equation for $\mathbf{B}$ in HW 6.2 should have been $r/R_E$, that is,

$$\mathbf{B}=\frac{B_o}{(r/R_E)^3}\left(2\cos\theta\mathbf{\hat{r}}+\sin\theta\boldsymbol{\hat{\theta}}\right)$$

1\. Plot the trajectory of this particle for 100 seconds.

You may use the integration method discussed in HW 6.2 (Forward Euler) or you may use a more advanced ODE integration algorithm, such as Runge-Kutta 4-5. In the following sample code, I demonstrate using Forward Euler and the `ode45` function in MATLAB to solve a simple ODE. 

2\. Plot the trajectory of a proton with $v_{ox}=10^7\cos(10^\circ)\text{ m/s}$ and $v_{oy}=10^7\sin(10^\circ)\text{ m/s}$ for 100 seconds and using the same initial position used previously.

If you are interested in the theory of these trajectories, see https://arxiv.org/abs/1112.3487.

----

**Sample Code**

As an example of solving two ODES, in the following, I solve the two equations

$\ds\frac{dx}{dt}=x \qquad \frac{dy}{dt}=-y$

numerically using the Forward Euler approximation. In this approximation, the equations can be rewritten as

$x_{i+1}=x_{i} + \Delta t x_i \qquad y_{i+1}=y_{i} - \Delta t y_i$

I use the parameter $\Delta t = 0.01$, which controls the accuracy of the solution. (Note that the Forward Euler approximation is not a good method for solving ODEs, but it is simple and easy to implement. Additional references for ODEs and MATLAB: [1](https://perhuaman.wordpress.com/wp-content/uploads/2014/07/solving-odes-with-matlab-shampine-gladwell-thompson.pdf), [2](https://www.math.tamu.edu/reu/comp/matode.pdf).

*MATLAB*

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

# HW 8

Due on Friday, November 1st at 11:59 pm.

## Inductance of a Rectangular Duct

A rectangular duct carries a net current of $I = Kl$ in the direction shown. A series of current supplies along the infinitesimal gap is driving the current. The conducting material of the duct has a small enough thickness that the current can be treated as flowing on a sheet. Ignore the subscript $1$ on the variables in the following diagram.

<img src="figures/Rectangular_Duct.svg">

1. Assuming $w \gg h$ and $l \gg h$, use Ampere's law to find the magnetic field inside and outside of the duct. Show the Amperian loop and justify your steps.

   **Answer**: Inside the duct $B\approx\mu_oK$ out of the page. To derive this see HW 6.3 for the derivation for a single plane. Inside the duct, the fields due to each plane add. Outside they cancel.
   
2. The electromotive force across the gap is due to a change in magnetic flux

   $$\mathcal{E} = -\frac{d \Phi_m}{d t}$$

   where $\Phi_m$ is the magnetic flux. Compute this magnetic flux and re-write this equation in the form of

   $$\mathcal{E} = -\mathcal{L} \frac{\partial I}{\partial t}$$

   so as to find the inductance $\mathcal{L}$ in terms of $\mu_o$, $l$, and the cross-sectional area $A=hw$.
   
   **Answer**: For the area bounded by the loop as shown, $\Phi_m=BA=\mu_oKA=\mu_o(I/l)A$ so $d\Phi_m/dt=\mu_o(A/l)(dI/dt)$ from which we conclude $\mathcal L = \mu_o A/l$. Note the sign convention for $\Phi_m=\mathbf{B}\cdot \mathbf{A}$ - the direction of $\mathbf{A}$ is determined by the right-hand rule applied to the path shown. From the diagram, $\mathbf{A}$ is out of the page because wrapping your fingers in the direction of the loop gives your thumb pointing out of the page. So $\mathbf{A}$ is in the direction of $\mathbf{B}$ and $\Phi_m$ is positive if $K$ is increasing in time. From $\mathcal{E} = -{d \Phi_m}/{d t}$, we see that $\mathcal{E}$ is negative in this case, so this induced emf is clockwise. This is consistent with Lenz's law - if $K$ is increasing in the counter-clockwise direction, the induced emf will be as to oppose that change, which an emf clockwise direction does.
   
   <img src="figures/Rectangular_Duct_Cross_Section.svg">

3. An alternative method of computing inductance uses the relationship $\mu_o\mathcal{L}I^2=\int B^2 dv$, where $dv$ is a differential volume, the integral is taken over all space, and $B$ is the magnitude of the field created by the current $I$ (see Ramo section 2.17 with $H=B/\mu_o$ and Griffiths 4th edition, section 7.2.4). Use this formula to compute $\mathcal{L}$.

   **Answer**: Assuming th magnetic field is constant over the volume and ignoring the field outside of the volume, $\int B^2 dv = (\mu_oK)^2Al$, so $\mathcal L = \mu_o A/l$

## Inductance of a Co--Axial Cable

In class, I derived the inductance of a long co--axial cable using $\oint \mathbf{E}\bfcdot d\mathbf{l}=-d\Phi_m/dt$ and the definition $\mathcal{L}=\Phi_m/I$

In the previous problem, it was noted that an alternative approach is to use $\mu_o\mathcal{L}I^2=\int B^2 dv$.

Use $\mu_o\mathcal{L}I^2=\int B^2 dv$ to find $\mathcal{L}$ for the long co--axial cable geometry considered in class, where the cable had length $l$, inner radius $a$, and outer radius $b$.

**Answer**: $\ds\mathcal L = \frac{\mu_o l}{2\pi}\ln (b/a)$

## Phasors and Related Math

### Trig Identity I

Show that $\sin(\alpha + \beta)=\sin\alpha\cos\beta+\cos\alpha\sin\beta$ using only Euler's identity, $e^{ix}=\cos x+i\sin x$.

(For the curious, there is [a geometrical proof](https://mymission.lamission.edu/userdata/sargsye2/docs/Math%20240/Proof%20of%20the%20difference%20formula%20for%20cosine.pdf)).

**Answer**:

$$\sin(\alpha + \beta)=\text{Im}[e^{i(\alpha+\beta)}]=\text{Im}[e^{i\alpha}e^{i\beta}]$$

Using $e^{ix}=\cos(x)+i\sin(x)$ and expanding the product gives

$$\sin(\alpha + \beta)=\text{Im}[e^{i\alpha}e^{i\beta}] = \text{Im}[(\cos\alpha\cos\beta - \sin\alpha\sin\beta) + i(\sin\alpha\cos\beta+\cos\alpha\sin\beta)]=\sin\alpha\cos\beta+\cos\alpha\sin\beta$$

It also follows that

$\cos(\alpha + \beta)=\text{Re}[e^{i\alpha}e^{i\beta}] = \cos\alpha\cos\beta - \sin\alpha\sin\beta$


### Trig Identity II

Later in the semester, we will encounter an equation that corresponds to the sum of waves travelling in opposite directions, each with different amplitudes:

$$V(z,t)=\cos(\omega t-kz) + a\cos(\omega t+kz)$$

where $a$ is a constant. Show that this equation can be written as the sum of two standing waves:

$$V(z,t)=A\cos(\omega t)\cos(kz) + B\sin(\omega t)\sin(kz)$$

and find $A$ and $B$.

**Answer**: Using, from the last problem,

$\cos(\alpha + \beta) = \cos\alpha\cos\beta - \sin\alpha\sin\beta$

also,

$a\cos(\alpha - \beta) = a\cos\alpha\cos\beta + a\sin\alpha\sin\beta$

With $\alpha=\omega t$ and $\beta = \beta z$ and adding these two equations,

$\cos(\alpha + \beta) + a\cos(\alpha - \beta) = (1+a)\cos\alpha\cos\beta + (1-a)\sin\alpha\sin\beta$

so $A=a+1$, $B=1-a$. The importance of this identity is that a forward traveling wave of amplitude $1$ and an backward (for example reflected) travelling wave with amplitude $a$ can be expresses as the sum of two standing waves.

### Summing Sinusoidal Functions

Write $A_1\cos(\theta+\delta_1) + A_2\cos(\theta + \delta_2)$ in the form $A\cos(\theta+\delta)$ using

1. only the identity $\cos(x+y)=\cos(x)\cos(y)-\sin(x)\sin(y)$ and
2. the method outlined on page 784 for the example _addition of two sine functions_ of [this document](https://ws.engr.illinois.edu/sitemanager/getfile.asp?id=184).

**Answer**:

1. Using the identity, we can write

   $f=A'\cos\theta - B'\sin\theta$

   where $A'=A_1\cos \delta_1+A_2\cos\delta_2$ and $B'= A_1\sin \delta_1+A_2\sin\delta_2$.
   
   Using an identity derived earlier, $a\cos x+b\sin x=\sqrt{a^2+b^2}\cos(x+\phi)$ where $\tan\phi=-b/a$, we get
   
   $f = \sqrt{A'^2+B'^2}\cos(\theta+\delta)$

2. $f=\text{Re}[A_1 e^{i\theta} e^{i\delta_1}]+\text{Re}[A_2 e^{i\theta} e^{i\delta_2}]$

   $f=\text{Re}\big[e^{i\theta}(A_1e^{i\delta_1}+A_2e^{i\delta_2})\big]$
   
   Using Euler's identity,
   
   $f=\text{Re}\Big[e^{i\theta}\big(A_1\cos \delta_1+A_2\cos\delta_2 + i(A_1\sin \delta_1+A_2\sin\delta_2)\big)\Big]$
   
  Because $A'+iB'$ can be written as $\sqrt{A'^2+B'^2}e^{i\delta}$, where $\tan\delta=B'/A'$, we can write
   
   $f=\text{Re}[\sqrt{A'^2+B'^2}e^{i(\theta+\delta)}]$ or
   
   $f = \sqrt{A'^2+B'^2}\cos(\theta+\delta)$

## Reading

Read about the displacement current in Ramo, Griffiths, and one other reference. Come to class with at least one question about it

# HW 9

Background: Ramo Chapter 4 for the theory. See also Nayfeh and Brussels, Electricity and Magnetism, Chapter 13. For the analysis of simple circuits, see [1](https://open.umn.edu/opentextbooks/textbooks/883) and [2](https://link.springer.com/book/10.1007/978-3-030-60986-3). 

## Finding the Steady State Solution of an ODE with Phasors

Use the approach covered in class (see also [Example A.1](https://ws.engr.illinois.edu/sitemanager/getfile.asp?id=184)) to find the steady state solution $I(t)$ for the ordinary differential equation

$$\frac{dI}{dt}+\frac{I}{\tau}=\frac{V_o}{\mathcal{L}}\cos(\omega t + \phi)$$

Also, find the steady-state solution to

$$\mathcal{L}\frac{dI}{dt}+IR + Q/C = V_o\cos(\omega t)$$

where $I=dQ/dt$.

**Answer**

Using $I(t)=\text{Re}[\widetilde{I}_oe^{i\omega t}]$ and $\cos(\omega t)=\text{Re}[e^{i\omega t}e^{i\phi}]$ gives

$$\text{Re}\left[e^{i\omega t}\left(i\omega\widetilde{I}_o+\frac{\widetilde{I}_o}{\tau}-\frac{V_o}{\mathcal{L}}e^{i\phi}\right)\right]=0$$

where $\tau=R/L$, which is satisfied when the quantity in $()$ is zero. This gives

$$\widetilde{I}_o=\frac{V_o}{\mathcal{L}}\frac{e^{i\phi}}{1/\tau + i\omega}$$

which can be written in the form $\widetilde{I}_o=I_oe^{i\theta}$ using $1/\tau-i\omega=\sqrt{\tau^2+\omega^2}e^{i\phi_{I_o}}$ where $\phi_{I_o}=\tan^{-1}(-\omega\tau)$ and $I_o=\sqrt{I_oI_o^*}$ so that

$$\widetilde{I}_o=\frac{V_o}{\mathcal{L}}\frac{1}{1+\omega^2\tau^2}e^{i(\phi-\phi_{I_o})}$$

With $I(t)=\text{Re}[\widetilde{I}_oe^{i\omega t}]$, we have

$$I(t)=I_o\cos(\omega t + \phi - \phi_{I_o})$$

Checks:
* For $R/L\rightarrow \infty$, $\phi_{I_o}\rightarrow 0$ and fixed $\omega$, so current is in phase with voltage, which is expected for circuit with inductor replaced with resistanceless wire. Same for $DC$ circuit ($\omega=0$).
* For $R/L\rightarrow 0$ and fixed $\omega$, $I(t)=I_o\cos(\omega t + \phi + \pi/2)$, current lags voltage by $90^\circ$. (In this case, the solution is $\widetilde{I}_o=-i(V_o/\mathcal{L}e^{i\phi})=(V_o/\mathcal{L})e^{i(\phi-\pi/2)})$, or without phasors, $V_o\cos(\omega t+\phi)=-\mathcal{L}dI(t)/dt \Rightarrow I_o(t)=-(V_o/\mathcal{L}\omega)\sin(\omega t + \phi)=(V_o/\mathcal{L})\cos(\omega t + \phi + \pi/2)$.

## Capacitor Impedance

In class, I showed how the differential equation for a circuit with a AC voltage in series with a resistor and inductor and the use of $I(t)=\text{Re}[\widetilde{I}_oe^{i\omega t}]$ and $V(t)=\text{Re}[\widetilde{V}_oe^{i\omega t}]$ led to an equation for $\widetilde{I}_o$ that was the same as if we had a circuit with

* a AC source of $\widetilde{V}_o$
* a resistor with a voltage drop of $\widetilde{I}_oR$, 
* and an inductor with impedance of $X_L=i\omega L$, and we treated the voltage drop across the inductor as $\widetilde{I}_oX_L$.

As a result, we can treat an inductor much like a resistor in DC circuit analysis when finding the voltage across it: we multiply the (complex-valued) current times the impedance, $X_L$.

In class, I started the problem of finding the impedance of a capacitor by considering the differential equation for a circuit with an AC voltage in series with a resistor and capacitor. 

Show your notes for the procedure I started in class for this case and then finish it by showing $ \widetilde{V}_o - \widetilde{I}_oR - \widetilde{I}_oX_C = 0$, where $X_C=1/(j\omega C)$. 

## Two-Step Ladder Circuit

1. Find the complex currents $\widetilde{I}_i$ ($i=0, 1, 2$) in the following circuit using KVL and KCL for AC circuits. That is, use the same procedure as KVL and KCL for DC circuits with voltage drops across inductors and capacitors as $\widetilde{I}X_L$ and  $\widetilde{I}X_C$, respectively.

  Use $V_o(t)=\cos(\omega t)$ [Volts], $L=1$ [Henry], and $C=1$ [Farad].

2. Find  $\widetilde{V}_i$ ($i=0, 1, 2$)

3. Find the impedance "seen" by the source, which is $\widetilde{V}_o/\widetilde{I}_o$. (As a check, for $\omega=1\text{ s}$ and $Z_L=1\text{ [Ohm]}$, you should get $(1-i)/2\text{ [Ohm]}$)

4. Find the time domain expressions for all currents and voltages. That is, find  $I_i(t)$ and $V_i(t)$ ($i=1, 2$).

5. Sketch or plot $V_o(t)$ and $V_2(t)$ if $Z_L=\sqrt{L/C}$ (in this case the "load" is a resistor with resistance of $\sqrt{L/C}$). 

<img src="figures/Short_Ladder.svg"/>

**Answer**

One method is to collapse the circuit in steps as shown below to find $Z_0$. Once $Z_0$ is known, the unknown complex voltage and current amplitudes can be found.

<img src="figures/Short_Ladder_Step1.svg"/>

<img src="figures/Short_Ladder_Step2.svg"/>

$$Z_1=\frac{1}{\frac{1}{1/j\omega C} + \frac{1}{Z_L+j\omega L}}$$

Note that this can be generalized - replace $Z_L$ with $Z_2$:

$$Z_1=\frac{1}{j\omega C + \ds\frac{1}{Z_2+j\omega L}}$$

This is the equation that would apply if the circuit had a third step and $Z_2$ was the result of collapsing the third step. More generally,

$$Z_n=\frac{1}{j\omega C + \ds\frac{1}{Z_{n+1}+j\omega L}}$$

where $n$ is the step number. Using the given parameters,

$$Z_1=\frac{1}{j+\frac{1}{1+j}}=\frac{1}{j+\frac{1-j}{2}}=\frac{1}{\frac{1+j}{2}}=1-j$$

$$Z_0=\frac{1}{j+\frac{1}{(1-j)+j}}=\frac{1}{1+j}=\frac{1-j}{2}$$

An iterative approach to computing $\widetilde{V}$ and $\widetilde{I}$, and $Z$ is to note that KCL for each node is

$\widetilde{I}_{n+1} = \widetilde{I}_n - j\omega C \widetilde{V}_n$

and the relationship for the voltages across the inductor is

$\widetilde{V}_{n+1} = \widetilde{V}_n - j\omega L \widetilde{I}_{n+1}$

and, as before,
   
$Z_n = \widetilde{V}_n/\widetilde{I}_n$

We are given that $\widetilde{V}_0$ and we also know that $\widetilde{I}_0=\widetilde{V}_0/Z_0$.

$\widetilde{I}_{n+1} = \widetilde{I}_n - j\omega C \widetilde{V}_n$ with $n=0$ gives

$$\widetilde{I}_{1} = \widetilde{I}_0 - j\omega C \widetilde{V}_0 = \widetilde{V}_0/Z_0 - j\omega C \widetilde{V}_0=\widetilde{V}_0\left(\frac{1}{Z_0} - j\omega C\right)$$

Using

$\widetilde{V}_{n+1} = \widetilde{V}_n - j\omega L \widetilde{I}_{n+1}$ with $n=0$ gives

$\widetilde{V}_{1} =
\widetilde{V}_0 - j\omega L \widetilde{I}_{1} = 
\widetilde{V}_0 \left[1-j\omega L \left( \frac{1}{Z_0} - j\omega C\right) \right]$

Repeating the last two steps with $n=1$ gives

$\widetilde{I}_{2} = \widetilde{I}_1 - j\omega C \widetilde{V}_1$

$\widetilde{V}_{2} = \widetilde{V}_1 - j\omega L \widetilde{I}_{2}$

Using the above with the given parameters,

1. $\widetilde{I}_0 = 1+j = \sqrt{2}e^{j\pi/4}$, $\widetilde{I}_1 = 1$, and $\widetilde{I}_2=-j=e^{-j\pi/2}$
2. $\widetilde{V}_0 = 1$, $\widetilde{V}_1 = 1-j= \sqrt{2}e^{-j\pi/4}$, and $\widetilde{V}_2=-j=e^{-j\pi/2}$
3. $\ds Z_0=\frac{1}{j\omega C + \frac{1}{Z_1+j\omega L}}$, where $\ds Z_1=\frac{1}{j\omega C + \frac{1}{Z_L+j\omega L}}$

   Using given parameters (see above),
   
   $Z_1=1-j$

   $Z_0=(1-j)/2$

   Check that answers to 1. and 2. are consistent:

   $Z_1=1-j = \widetilde{V}_1/\widetilde{I}_1=1-j$
   
   $Z_0=(1-j)/2=\widetilde{V}_0/\widetilde{I}_0=1/(1+j)=(1-j)/2$

4. $I_n(t) = \text{Re}\left[\widetilde{I}_n e^{j\omega t}\right]$

   $I_0(t) = \text{Re}\left[ \sqrt{2}e^{j\pi/4}e^{j\omega t}\right]=\sqrt{2}\cos(\omega t + \pi/4)$

   $I_1(t) = \text{Re}\left[ e^{j\omega t}\right]=\cos(\omega t)$

   $I_2(t) = \text{Re}\left[ e^{-j\pi/2}e^{j\omega t}\right]=\cos(\omega t - \pi/2)$

   $V_n(t) = \text{Re}\left[\widetilde{V}_n e^{j\omega t}\right]$

   $V_1(t) = \text{Re}\left[\sqrt{2}e^{-j\pi/4} e^{j\omega t}\right]=\sqrt{2}\cos(\omega t - \pi/4)$

   $V_2(t) = \text{Re}\left[e^{-j\pi/2} e^{j\omega t}\right]=\cos(\omega t - \pi/2)$
5. Plot should have $V_0(t)=\cos(\omega t)$ and $V_2(t)=\cos(\omega t - \pi/2)=-\sin(\omega t)$

# HW 10

## Maximizing Power

Given an AC power source $V_s(t)=V_o\cos(\omega t)$ that has an internal impedance of $Z_s=R_s + iX_s$ that is in series with a load with impedance $Z_l=R_l + iX_l$,

1. Find the instantanous power of the load: $P_l(t)=V_l(t)I_l(t)$
2. Find $\overline{P}_l$, the average of $P_l(t)$ found in part 1. over a time of $2\pi/\omega$
3. Use the equation $\overline{P}_l$ found in part 2. to show that $\overline{P}(R_l,X_l)$ is a maximum when $R_l=R_s$ and $X_l=-X_s$ (assume $R_s$ and $X_s$ are constants; in this case, $\overline{P}_l$ is a function of the variables $R_l$ and $X_l$).

**Answer**

Let $Z=Z_l+Z_s=(R_l+R_s)+j(X_l+X_s)$. Note that $\widetilde{V}_o=V_o$ because $V_s(t)=\text{Re}\left[\widetilde{V}_oe^{j\omega t}\right]$ defines $\widetilde{V}_o$.

$\ds\widetilde{I}=\frac{\widetilde{V}_o}{Z}$

Using $\widetilde{V}_o=V_o$ and $Z=|Z|e^{i\phi_Z}$

$\ds\widetilde{I} = \frac{V_o}{Z} = \frac{V_o}{|Z|}e^{-j\phi_Z}$.

$\ds\widetilde{V}_l=\widetilde{I}Z_l=V_o\frac{Z_l}{|Z|}e^{-j\phi_Z}=V_o\frac{|Z_l|}{|Z|}e^{-j\phi_Z+j\phi_l}$

By definition, $P_l(t)=I_l(t)V_l(t)$. Using $I_l(t)=I(t)$,

$P_l(t)=I(t)V_l(t)$

$P_l(t)=\text{Re}\left[\widetilde{I}e^{j\omega t}\right]\text{Re}\left[\widetilde{V}_le^{j\omega t}\right]$

Note that $\text{Re}[a+jb]\text{Re}[a'+jb'] \ne \text{Re}[(a+jb)(a'+jb')]$.

Let $\omega t-\phi_Z=\omega t'$, then

$P_l(t)=\text{Re}\left[\frac{V_o}{|Z|}e^{-j\phi_Z}e^{j\omega t}\right]\text{Re}\left[V_o\frac{|Z_l|}{|Z|}e^{-j\phi_Z+j\phi_l}e^{j\omega t}\right]$

$P_l(t)=V_o\frac{|Z_l|}{|Z|^2}\text{Re}\left[e^{-j\phi_Z}e^{j\omega t}\right]\text{Re}\left[e^{-j\phi_Z+j\phi_l}e^{j\omega t}\right]$

$\ds P_l(t)=V_o\frac{|Z_l|}{|Z|^2}\cos\omega t'\cos(\omega t'+\phi_l)$, where $\omega t'\equiv\omega t - \phi_Z$

Using a trig identity, 
$\ds P_l(t)=V_o\frac{|Z_l|}{|Z|^2}\cos\omega t'(\cos\omega t'\cos\phi_l-\sin\omega t'\sin\phi_l)$

Using $\ds \overline{P}\equiv\frac{1}{T}\int_0^TP(t)dt$ and integrating,

$\ds \overline{P}_l=\frac{V_o}{2}\frac{|Z_l|}{|Z|^2}\cos\phi_l$

Recall that $\phi_l$ is the angle associated with $Z_l=R_l + iX_l$, so although we ususally use $\tan\phi_l=X_l/R_l$, we can also write $\cos\phi_l=R_l/\sqrt{R_l^2+X_l^2}=R_l/Z_l$. Thus

$\ds \overline{P}_l=\frac{V_o}{2}\frac{R_l}{|Z|^2}=\frac{V_o}{2}\frac{R_l}{(R_l+R_s)^2+(X_l+X_s)^2}$

If we assume that the $R_s$ and $X_s$ are constant and $R_l$ and $X_s$ can be varied, we have

$\ds \overline{P}_l(R_l,X_l)$

## $N$-Step Ladder Circuit

In class, I discussed an iterative method for solving for the steady state currents and voltages in the ladder circuit of HW 9.3.

Write a program that takes as an input the the number of steps in the ladder, $L$, $C$, $\omega$, and $Z_L$ and produces a plot of the magnitude and phase of the voltage across each capacitor as a function of the capacitor number (use the numbering convention used in the diagram of HW 9.3). Assume the input voltage is $V_o(t)=\cos(\omega t)$ [Volts].

1. Create a plot of the magnitude and phase of the voltage across each capacitor as a function of the capacitor number using $N=100$ and the same parameters used in HW 9.3.
2. Repeat part 1. using $Z_L=10\sqrt{L/C}$
3. Repeat part 1. using $Z_L=0$.

**Answer**

See [HW10_2](solns/H10_2.m).

## Background Videos

Watch the following three videos before class

1. https://www.youtube.com/watch?v=bHIhgxav9LY
   2. Response: https://www.youtube.com/watch?v=iph500cPK28
   3. Response to response: https://www.youtube.com/watch?v=oI_X2cMHNe0

If you want to work ahead, think about how you would reproduce the results shown at 14:25 of [the second video](https://www.youtube.com/watch?v=iph500cPK28&t=865s&ab_channel=ElectroBOOM).

## Reading

Read 5.1-5.8 of Ramo.

# HW 11

## Basic Continuous Transmission Line

In class, we considered a coaxial cable  of length $l_o$ with one end connected to a AC power supply with $V_s(t)=V_{so}\cos(\omega t)$. The other end was connected to an infinitely long coaxial cable. The characteristic impedances were $Z_o$ and $Z_1$, respectively. Schematically, the system is represented as in the following figure, where the top line corresponds to the outer cylinder and the bottom line corresponds to the inner cylinder.

<img src="figures/Transmission_Line_2_Segment.svg"/>

We solved for the complex--valued constants $\widetilde{\rho}\equiv\widetilde{V}_{0}^-/\widetilde{V}_{0}^+$ and $\widetilde{\tau}\equiv\widetilde{V}_{1}^+/\widetilde{V}_{0}^+$.

Recall that the general solution for voltage in the two cables is

$$V_k(x,t)=\text{Re}\left[\widetilde{V}_{k}^+e^{i(\omega t-\beta_kx)}+\widetilde{V}_{k}^-e^{i(\omega t+\beta_kx)}\right]$$

where $k=0$ corresponds to the cable of length $l_o$ and $k=1$ the infinitely long cable; $\widetilde{V}_{k}^+$ and $\widetilde{V}_{k}^-$ are complex--valued constants.

This can be re-written as 

$$V_k(x,t)=\text{Re}\left[e^{i\omega t}\left(\widetilde{V}_{k}^+(x)+\widetilde{V}_{k}^-(x)\right)\right]$$

by defining $\widetilde{V}_{k}^+(x)=\widetilde{V}_{k}^+e^{-i\beta_kx}$ and $\widetilde{V}_{k}^-(x)=\widetilde{V}_{k}^-e^{i\beta_kx}$

1. Find $\widetilde{V}_{0}^+(x)$, $\widetilde{V}_{0}^-(x)$ and $\widetilde{V}_{1}^+(x)$ in terms of $\widetilde{V}_s$.

2. Plot or sketch the voltages $V_0(x,0)$ and $V_1(x,0)$ as a function of $x/l_o$. Assume that $\beta_0 l_0 = 4\pi$ and $Z_1=3Z_0$ (from which you should find $\widetilde{\rho}=1/2$, and $\widetilde{\tau}=3/2$.)

3. Write the quantity $\widetilde{V}_0(x)\equiv\widetilde{V}_{0}^+(x)+\widetilde{V}_{0}^-(x)$ in polar form, $|\widetilde{V}_0(x)|e^{i\phi}$. That is, find $|\widetilde{V}_0(x)|$ and $\phi$. Assume that $\beta_0 l_0 = 4\pi$ and $Z_1=3Z_0$.

**Answer**

1\.

$$\widetilde{\rho}=\frac{Z_1-Z_0}{Z_1+Z_0}$$

$$\widetilde{\tau}=\frac{2Z_1}{Z_1+Z_0}$$

$$\widetilde{V}_{0}^+(x)=V_{so}\frac{e^{-j\beta_0 x}}{e^{j\beta_0 l_0}+\widetilde{\rho}e^{-j\beta_0 l_0}}$$

$$\widetilde{V}_{0}^-(x)=\widetilde{\rho}\frac{e^{j\beta_0 x}}{e^{j\beta_0 l_0}+\widetilde{\rho}e^{-j\beta_0 l_0}}$$

$$\widetilde{V}_{1}^+(x)=\widetilde{\tau}V_{so}\frac{e^{-j\beta_1 x}}{e^{j\beta_0 l_0}+\widetilde{\rho}e^{-j\beta_0 l_0}}$$

$$\widetilde{V}_{0}(x)=\widetilde{V}_{0}^+(x)+\widetilde{V}_{0}^-(x)=V_{so}\frac{e^{-j\beta_0 x}+\widetilde{\rho}e^{j\beta_0 x}}{e^{j\beta_0 l_0}+\widetilde{\rho}e^{-j\beta_0 l_0}}$$

$$\widetilde{V}_{1}(x)=
V_{so}\frac{\widetilde{\tau} e^{-j\beta_1 x}}{e^{j\beta_0 l_0}+\widetilde{\rho}e^{-j\beta_0 l_0}}
$$

2\. See https://www.desmos.com/calculator/wteuno5c2u

3\. 

$$\widetilde{V}_{0}(x)=\widetilde{V}_{0}^+(x)+\widetilde{V}_{0}^-(x)=V_{so}\frac{e^{-j\beta_0 x}+\widetilde{\rho}e^{j\beta_0 x}}{e^{j\beta_0 l_0}+\widetilde{\rho}e^{-j\beta_0 l_0}}$$

Using the given values,

$$\widetilde{V}_{0}(x)=V_{so}\frac{2}{3}\left(e^{-j\beta_0x} + \frac{1}{2}e^{j\beta_0x}\right)$$

We want to write

$$V_o(x,t)=\text{Re}\left[\widetilde{V}_{0}(x)e^{j\omega t}\right]$$

in the form

$$V_o(x,t)=\text{Re}\left[|\widetilde{V}_{0}(x)|e^{j\phi}e^{j\omega t}\right]$$

or

$$V_o(x,t)=|\widetilde{V}_{0}(x)|\cos(\omega t + \phi)$$

so that we can determine at a given $x$ what the maximum of $V_o$ will be over one period.

Using $|\widetilde{V}_{0}(x)|=\sqrt{\widetilde{V}_{0}(x)\widetilde{V}_{0}^*(x)}$ gives

$$|\widetilde{V}_{0}(x)|=\frac{2}{3}\sqrt{\frac{5}{4} + \cos(8\pi x)}$$

## Transient Analysis of a Circuit

Previously, we have considered a method for finding the steady state solution to a circuit that is driven by a harmonic source.

To find a transient solution, an alternative approach is needed. These approaches include using numerical integration (for an approximate solution) and the Laplace transform method (for an exact solution). Both typically involve writing the circuit equations in "state space form", e.g.,

$$\frac{dx_1}{dt} = a_{11}x_1 + a_{12}x_2 + b_1u_1(t)$$

$$\frac{dx_2}{dt} = a_{21}x_1 + a_{22}x_2 + b_2u_2(t)$$

$$\frac{dx_3}{dt} = a_{31}x_1 + a_{32}x_2 + b_3u_3(t)$$

1\. For the circuit below, assume $Z_l$ is a resistor so $Z_l=R$. If $V_o=\cos(t)\text{ [V]}$, $L=1\text{ [H]}$, $C=1\text{ [F]}$, and and $R=1\text{ [}\Omega\text{]}$ and the state space variables are $x_1=I_1$, $x_2=I_2$, and $x_3=V_1$, show that

$a_{11} = 0\quad a_{12} =  0\quad a_{13}=-1$

$a_{21} = 0\quad a_{22} = -1\quad a_{23}=1$

$a_{31} = 1\quad a_{32} = -1\quad a_{33}=0$

$b_1 = 1\quad b_2=0\quad b_3=0$

$u_1=\cos(t)\quad u_2=0\quad u_3=0$

(If you are interested in more background on the state space formulation, see [1](https://lpsa.swarthmore.edu/Representations/SysRepSS.html) and [2](https://elec3004.uqcloud.net/2013/lectures/Lathi-Chapter13-StateSpace.pdf).

<img src="figures/Transient_Circuit_Step2.svg">

**Answer**

$$-L\frac{dI_1}{dt}-V_1+V_0 = 0$$

$$-L\frac{dI_2}{dt}-V_2+V_1 = 0$$

$Q_{C1}=CV_1$, where $Q_{C1}$ is the charge on the capactor at node $1$. Differentiating and using $dQ_{C1}/dt=I_{C1}$ gives $\frac{dI_2}{dt}=I_{C1}/C$. KVL at node 1 is $I_{C1}=I_1-I_2$, so

$$\frac{dV_2}{dt}=\frac{I_1-I_2}{C}$$

---
Using $V_2=I_2R$, the three differential equations are

$$\frac{dI_1}{dt}=\frac{V_0-V_1}{L}$$

$$\frac{dI_2}{dt}=\frac{V_1-I_2R}{L}$$

$$\frac{dV_2}{dt}=\frac{I_1-I_2}{C}$$

2\. Use the techniques covered previously for finding the steady state values to find the steady state $I_1(t)$, $I_2(t)$, and $V_1(t)$. (You do not need to find the transient solution; here we only want to confirm that our numerical solution matches the easier-to-compute steady state solution for large $t$. Note that there are many ways of solving [1](https://www.ee.hacettepe.edu.tr/~solen/Matlab/MatLab/Matlab%20-%20Electronics%20and%20Circuit%20Analysis%20using%20Matlab.pdf); [2](https://www.math.tamu.edu/reu/comp/matode.pdf)

The following program plots the solution for part 1.; you may use this to check your answer to part 2. (Using Python one would use SciPy's `solve_ivp` in place of `ode45`.)

```bash
set(0,'defaultTextInterpreter','LaTeX')
set(0,'defaultLegendInterpreter','LaTeX');

T = 2*pi;

% Solution for one ladder step
figure(1);clf;hold on;grid on;
[t, X] = ode45(@dXdt1, [0, 5*pi], 0);
plot(t,cos(t),'k-','LineWidth',2);
plot(t,X(:,1),'r-','LineWidth',2);
title_ = '$dx/dt = -x + \cos(t)$';
title(title_,'FontWeight','bold');
legend('$\cos(t)$','$x$');
xlabel('$t$');

% Solution for two ladder steps
figure(2);clf;hold on;grid on;
[t, X] = ode45(@dXdt2, [0, 20*T], [0, 0, 0]);
plot(t/T,cos(2*pi*t/T),'k-','LineWidth',3);
plot(t/T,X(:,1),'g-','LineWidth',2);
plot(t/T,X(:,2),'b-','LineWidth',2);
plot(t/T,X(:,3),'r-','LineWidth',2);
legend('$\cos(t)$','$I_1$', '$I_2$', '$V_1$');
xlabel('$t/T$');
ylabel('$x$');

function dXdt = dXdt1(t, X)
    T = 2*pi; % Note variable defined also above.
              % Better approach (not used here to keep code simple):
              % https://www.mathworks.com/matlabcentral/answers/168073-ode45-where-odefun-requires-more-parameters
    dXdt = -X + cos(2*pi*t/T);
end    

function dXdt = dXdt2(t, X)
    T = 2*pi;
    U = [cos(-2*pi*t/T) ; 0 ; 0];    % Time-dependent drivers
    A = [ 0  0 -1;...
          0 -1  1;...
          1 -1  0];
    B = [1 ; 0 ; 0];
    dXdt = A*X + B.*U;
end
```

**Answer**: The following program has the steady state solution added.

```
clear
set(0,'defaultTextInterpreter','LaTeX')
set(0,'defaultLegendInterpreter','LaTeX');

T = 2*pi;

if 0
% Solution for one ladder step
figure(1);clf;hold on;grid on;
[t, X] = ode45(@dXdt1, [0, 5*pi], 0);
plot(t,cos(t),'k-','LineWidth',2);
plot(t,X(:,1),'r-','LineWidth',2);
title_ = '$dx/dt = -x + \cos(t)$';
title(title_,'FontWeight','bold');
legend('$\cos(t)$','$x$');
xlabel('$t$');
end

if 1
% Solution for two ladder steps
figure(2);clf;hold on;grid on;
[t, X] = ode45(@dXdt2, [0, 5*T], [0, 0, 0]);
title('Lines show exact soln.; dots are steady state soln.')
plot(t/T,X(:,1),'g-','LineWidth',4);
plot(t/T,X(:,2),'b-','LineWidth',4);
plot(t/T,X(:,3),'r-','LineWidth',4);
xlabel('$t/T$');

N = 3;
w = 2*pi/T;
L = 1;
C = 1;
ZL = 1;
Xss = ss(w,L,C,ZL,N);
Xss = Xss([2,3,5]); % I1, I2, V1
for i = 1:size(Xss,2)
    xc = Xss(:,i);
    phi = atan2(imag(xc),real(xc));
    x(:,i) = abs(xc)*cos(w*t + phi);
end

plot(t/T,x(:,1),'k.','MarkerSize',10);
plot(t/T,x(:,2),'g.','MarkerSize',10);
plot(t/T,x(:,3),'b.','MarkerSize',10);
legend('$I_1$', '$I_2$', '$V_1$',...
        '$I_1^{\mbox{ss}}$', '$I_2^{\mbox{ss}}$', '$V_1^{\mbox{ss}}$');
end

function X = ss(w,L,C,ZL,N)
    Z = zeros(1, N);
    Z(end) = ZL;

    V(1) = 1.0; % Source voltage

    % Compute impedances starting at load
    for n = [N:-1:2]
        y = 1/(Z(n) + 1j*w*L);
        Z(n-1) = 1/(y + 1j*w*C);
    end

    I(1) = V(1)/Z(1);
    for n = [1:N-1]
        I(n+1) = I(n) - 1j*w*C*V(n);
        V(n+1) = V(n) - 1j*w*L*I(n+1);        
    end
    X = [I,V];
end

function dXdt = dXdt1(t, X)
    T = 2*pi; % Note variable defined also above.
              % Better approach (not used here to keep code simple):
              % https://www.mathworks.com/matlabcentral/answers/168073-ode45-where-odefun-requires-more-parameters
    dXdt = -X + cos(2*pi*t/T);
end    

function dXdt = dXdt2(t, X)
    T = 2*pi;
    U = [cos(2*pi*t/T) ; 0 ; 0];    % Time-dependent drivers
    A = [ 0  0 -1;...
          0 -1  1;...
          1 -1  0];
    B = [1 ; 0 ; 0];
    dXdt = A*X + B.*U;
end
```

# HW 12 

Due on Friday, December 6th at 11:59 pm

## Steady-State 

In HW 10.2, you found the exact steady--state solution to a $N$--step ladder circuit.

In HW 11.1, you computed the steady--state solution for a continuous transmission line.

I have noted that a ladder circuit can be used to approximate a continuous transmission line and that finding the transient solution analytically for a ladder circuit is possible, but more involved.

Approximate the transmision line of HW 11.1 with a ladder LC network with at least 100 elements; assume $V_{s0}=1\text{ Volt}$ and $Z_0=1\text{ }\Omega$. Note that in a circuit representation, the second transmission line can be replaced with a circuit element with resistance $Z_1$. Assume that $\beta_0 l_0 = 4\pi$, $l_0=0.5\text{ m}$, and $Z_1=3Z_0$.

1. Compute and plot $|\widetilde{V}(k)|$, where $k$ is the step number of the ladder. In class, I discussed several ways of doing this, including writing recursive relationships for the voltages and currents.

2. Compare your result from 1. with your answer from HW 11.1 by plotting their voltage magnitudes on the same plot vs. $x$ (from $x=0$ to $x=0.5\text{ m}$). You will need to determine a relationship between the step number of the ladder and the coordinate $x$ in HW 11.1 in order to make the comparison.

Notes:
* In the derivation for the continuous transmission line, $L$ and $C$ are inductances and capacitances per unit length.
* The lumped capacitances and inductances for the circuit problem can be computed using the given parameters and and arbitrary non--zero value of $\omega$.

## Transient Response

Starting with HW 11.2, create a function `dXdt3` that is a generalization of `dXdt2` that allows the solution to work for an $3$--step ladder.

Plot $V_1(t)$ and $V_2(t)$. Also plot $V_1^{\text{ss}}(t)$ and $V_2^{\text{ss}}(t)$ on the same axes, where the $\text{ss}$ superscript indicates the solution found using the phasor method to find the steady state solution.

# Midterm

PHYS 513 Midterm Exam. Closed book and notes. 4:30 -- 6:00 pm Thursday, October 17th.

## Spherical Capacitor

The space between two concentric conducting spherical shells of radius $a$ and $3a$ is filled with a thick dielectric shell with permittivity $\epsilon_1=2\epsilon_o$ for $a\lt r \le 2a$ and a thick dielectric shell with permittivity $\epsilon_2=4\epsilon_o$ for $2a\lt r\lt 3a$. The space for $r < a$ and $r>3a$ has permittivity $\epsilon_o$.

The inner conducting shell at $r=a$ is held at potential $V_o$. The outer conducting shell at $r=3a$ is held at a potential of $0$.

<img src="figures/Sphere_with_Dielectrics.svg" width="25%"/>

1. Find the electric potential, $\psi(r)$,  for all $r$
2. Find $\mathbf{E}(r)$ for all $r$
3. Find $\mathbf{D}(r)$ for all $r$
4. Find all surface charge densities (both bound and free)
5. Find the capacitance

Note that $\nabla^2\psi(r) = \frac{1}{r^2}\frac{\partial}{\partial r}\left(r^2\frac{\partial\Phi}{\partial r}\right)$

## Coaxial Cable

A section of a long coaxial cable is shown in the following image. Find the magnetic field for all $r$. Assume that the current $I$ is uniformly distributed through the cross--sectional areas (i.e., the current density, $J$, is constant for $0\le r\le a$ and $b\le r \le c$).

<img src="figures/Coaxial_Cable.png" width=20%/>

**Answer**

From Ampere's law and the symmetry arguments discussed in class,

$$B_{\phi}(s) = \frac{\mu_o}{2\pi s}I_{\text{encl}}(s)$$

where $s$ is the radial coordinate and the $\phi$ increases in the counterclockwise direction.

$$
I_{\text{encl}}(s) =
\begin{cases}
    \ds I\frac{s^2}{a^2}  & \text{if } s < a \\\\
    I                 & \text{if } a \le s \le b \\\\
    \ds I\left(1-\frac{s^2-b^2}{c^2-b^2}\right)  & \text{if } b \le s \le c \\\\
    0                 & \text{if } s > c
\end{cases}
$$
