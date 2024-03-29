# Laplace 2D Analytical and Numerical

Due Tuesday, September 8th at 11:59 pm, but you are expected to have it mostly finished before we meet in person on Tuesday.

## Laplace' Equation in Two Dimensions - Analytical

A long pipe runs parallel to the \(z\)-axis as shown in the figure. The sides are labeled with subscripts \(l\), \(r\), \(t\), \(b\) for the left, right, top, and bottom. These sites are held at potentials \(V_l\), \(V_r\), \(V_t\), and \(V_b\).

[[Image:long_pipe.png]]

In the following problem, you will be asked to verify the exact solution in Table 1.20 of the textbook.

In this problem, you will derive a general solution for the potential inside of the pipe, \(\Phi(x,y)\) that depends on \(x_o\), \(y_o\), \(V_l\), \(V_r\), \(V_t\), and \(V_b\).

I have sent a PDF of Chapter 3 of Griffiths to the Piazza email list, which covers problems related to this. In addition, I have [[Notes|notes]] that fill in the mathematical gaps in Griffiths' examples.

1. Assume only \(V_l\) is nonzero. Find the potential inside of the pipe and call it \(\Phi_l(x,y)\).

2. Assume only \(V_b\) is nonzero. Find the potential inside of the pipe and call it \(\Phi_b(x,y)\). Finding this answer should be easy.

3. Assume only \(V_t\) is nonzero. Find the potential inside of the pipe and call it \(\Phi_t(x,y)\). 

4. Assume only \(V_r\) is nonzero. Find the potential inside of the pipe and call it \(\Phi_r(x,y)\). Finding this answer should be easy.

**Answer**

The function 

$$\psi_l(x,y) = A_n\sin(n\pi y/y_0)\sinh\left[n\pi(x-x_0)/y_0\right]$$

satisfies \(\nabla^2\psi=0\) and three of the four boundary conditions. I've skipped the steps used in the notes to show this - after you've done the problem a few times, you can usually skip those steps and write down a function that satisfied Laplace's equation and three of the four boundaries that are at zero potential. To satisfy the non-zero boundary condition, a Fourier sum is needed:

$$\psi_l(x,y)=\sum_{n=1}^\infty A_n\sin(n\pi y/y_0)\sinh\left[n\pi(x-x_0)/y_0\right]$$

Standard Fourier analysis gives

$$A_n=-\frac{4V}{n\pi\sinh (n\pi y_0/x_0)}\quad n=1,3,...$$
$$A_n=0\quad n=2,4,...$$

So the solution is

$$\psi_l(x,y)=\frac{4V}{\pi}\sum_{n=1,3,...}^\infty \frac{\sin(n\pi y/y_0)}{n\sinh (n\pi y_0/x_0)}\sinh\left[n\pi(x_0-x)/y_0\right]$$

The solution to the problem where only \(\psi_r\) is nonzero can be obtained by replacing \(x\) with \(x_0-x\) in the problem where only \(\psi_l\) is non-zero:

$$\psi_r(x,y)=\psi_l(x_0-x,y)=\frac{4V}{\pi}\sum_{n=1,3,...}^\infty \frac{\sin(n\pi y/y_0)}{n\sinh (n\pi y_0/x_0)}\sinh(n\pi x/y_0)$$

The solution to the problem where only \(\psi_t\) is nonzero can be obtained by swapping the coordinate labels in the problem where only \(\psi_l\) is non-zero:

$$\psi_t(x,y)=\frac{4V}{\pi}\sum_{n=1,3,...}^\infty \frac{\sin(n\pi x/x_0)}{n\sinh (n\pi x_0/y_0)}\sinh\left[n\pi(y_0-y)/x_0\right]$$

The solution to the problem where only \(\psi_b\) is nonzero can be obtained by replacing \(y\) with \(y_0-y\) in the problem where only \(\psi_t\) is non-zero:

$$\psi_b(x,y)=\frac{4V}{\pi}\sum_{n=1,3,...}^\infty \frac{\sin(n\pi x/x_0)}{n\sinh (n\pi x_0/y_0)}\sinh(n\pi y/x_0)$$
|}

Claim: The general solution for this problem is

$$\Phi(x,y) = \Phi_l(x,y)+\Phi_r(x,y)+\Phi_t(x,y)+\Phi_b(x,y)$$

5. Justify this claim.

**Answer**

The short answer is "superposition and uniqueness". The associated explanation is that each of the individual potentials \(\Phi_i\) satisfy Laplace's equation \(\nabla^2\Phi_i=0\), so their sum also satisfies Laplace's equation, which follows from

$$\nabla^2\Phi=\nabla^2\Big(\Phi_l(x,y)+\Phi_r(x,y)+\Phi_t(x,y)+\Phi_b(x,y)\Big)=\nabla^2\Phi_l(x,y)+\nabla^2\Phi_r(x,y)+\nabla^2\Phi_t(x,y)+\nabla^2\Phi_b(x,y)=0$$

The sum of the solutions \(\Phi\) also satisfies the boundary conditions of the problem. Therefore, by uniqueness, the general solution is given by \(\Phi\). 

6. Can Gauss' law be used in any way at any location to check your analytic answers derived above? If yes, provide details of your check. The textbook does not cover the fundamentals of Gauss' law in great detail. As background reading, I suggest the Gauss' law section of any upper-division E&M text for physicists or engineers.

Upload your solution to your GitHub account as <code>HW2_1.pdf</code>.

**Answer**

This was discussed extensively in class.

## Laplace' Equation in Two Dimensions - Numerical

1. Verify the numbers in the Step 1 column of Table 1.20 of the textbook. Show your calculations on a piece of paper. Upload your solution to your GitHub account as <code>HW2_2_1.pdf</code>.

2. Verify the numbers in the Step 1 column of Table 1.20 of the textbook using any software (spreadsheet, MATLAB, Python, etc.). Upload your solution to your GitHub account as <code>HW2_2_2.ext</code>, where <code>ext</code> is the file name extension for the software that you used.

**Answer**

See https://github.com/rweigel/phys513, which generates all of the columns in Table 1.20. The maximum difference between my results and the results in the columns for steps 1-5 is 0.03 (for step 4, $\Phi_3$). I don't get the same answer as that in the "Correct Potentials" column of Table 1.20. Based on the testing that was done in the code, I conclude that the values in the book are wrong.

3. Suppose that you were given only the values for the potentials of the surfaces and the potentials at the four interior grid points shown in Figure 1.20a of the textbook. Describe an algorithm for drawing the field lines given only this information. You do not need to implement the algorithm and there is no "correct" answer. Upload your solution to your GitHub account as <code>HW2_2_3.pdf</code>.

**Answer**

As covered in HW #1, to draw a field line, one computes the direction of the the field at a starting point and takes a small step in this direction. Because we don't know the electric field at all points in the domain, one can do a bilinear interpolation using the four nearest points to the point where we want to know the electric field.
|}

# Poynting Theorem

In the diagram, an RC circuit is shown. The capacitor plates are circular and have a radius \(b\). The smaller dotted rectangle represents the cross-section of a cylindrical volume with a radius of \(r_s\) and a height \(h_s\); \(h_s < d\). The larger dotted rectangle represents the cross-section of a cylindrical volume with a radius \(r_l\) and a height \(h_l\); \(d \lt h_l\lt l\).

[[Image:RC_Circuit.png|500px]]

Equation (6) on Page 140 of the textbook is Poynting's theorem for linear and time-invariant media.

1. Using the small cylinder as the volume in Poynting's theorem, show how equation (6) is satisfied after the circuit is closed. State all assumptions that you used for any of the lengths given in the problem and why you made the assumption (e.g., state what simplification the assumptions allowed).

2. Using the large cylinder as the volume in Poynting's theorem, show how equation (6) is satisfied after the circuit is closed. State all assumptions that you used for any of the lengths given in the problem and why you made the assumption (e.g., state what simplification the assumptions allowed).

Assume \(\mu=\mu_o\) and \(\epsilon=\epsilon_o\) everwhere.

Save your answers in a file named <code>HW5_2.pdf</code> and upload it to GitHub.

# HW 9

## Transmission Line/Wave Propagation I

In the previous HW, you derived the relationship between the electric and magnetic fields for a monochromatic plane wave propagating in free space. In class, I derived the equations that related the electric and magnetic fields for the case where a plane wave propagating to the right encountered a change in either the permeability or permittivity (or both). The relationship between the electric fields in the two regions at the interface is $E_1 = E_2$.

In region 1, the electric field is composed of a forward and backward propagating wave, $E_1=E_1^{+}+E_1^{-}$. In region 2, the electric field is composed only of a forward propagating wave, $E_2=E_2^{+}$.

In the image at [https://github.com/rweigel/phys513/blob/master/fdtd/figures/HW8_2.pdf], the 1-D wave propagation code used on a previous HW was used to create a monochromatic plane wave that propagates to the right and encounters a change in $\epsilon$ by a factor of $9$. The code that generated this image is <code>fdtd1d.m</code> at [https://github.com/rweigel/phys513/blob/master/fdtd/]. Based on the parameters used in the code, compute $E_1^{+}$ and $E_1^{-}$ and add lines for these at the time step in the image shown.

Save your answer as <code>HW8_2.pdf</code>. Save any code used to generate this image with a prefix of <code>HW8_2_</code> (e.g., <code>HW8_2_PlotCode.m</code>, etc.). Alternatively, place all of your code in a directory named <code>HW8</code>. Clearly label the lines and add additional useful information (such as equations, important ratios, or lines showing peak values).

## Transmission Line/Wave Propagation II

1. Solve problem 5.8f.

2. Plot the standing wave part of $E_1$ in region 1 on the image shown in the previous problem.

Save your answer in <code>HW8_3.pdf</code>. Save any code used to generate this image with a prefix of <code>HW8_3_</code> (e.g., <code>HW8_3_PlotCode.m</code>, etc.). Alternatively, place all of your code in a directory named <code>HW8</code>. Clearly label the lines and add additional useful information (such as equations, important ratios, or lines showing peak values).

# Multiple Impedances

In each of the $k$th segments ($n=0, 1, 2$) of the transmission line shown at [https://www.mathcha.io/editor/O4lYqspXSQqTP3ozGesgJy7BLHzgOmYjSZ2ez3V], the electric potential can be written in the form of a forward traveling voltage and a backward traveling voltage:
    
`$$\widetilde{V}_n(z) = \widetilde{V}_{n}^+e^{-j\beta_n z}+\widetilde{V}_{n}^-e^{+j\beta_n z}$$`
    
where the real potential is given by
    
`$$V_n(z,t) = \text{Re}\Big[\widetilde{V}_n(z)e^{j\omega t}\Big]$$`

Equivalently, the electric field in each dielectric region can be written in the form of a forward traveling electric field and a backward traveling electric field: 
    
`$$\widetilde{E}_n(z) = \widetilde{E}_{n}^+e^{-jk_n z}+\widetilde{E}_{n}^-e^{+jk_n z}$$`
    
where the real field is given by
    
`$$E_n(z,t) = \text{Re}\Big[\widetilde{E}_n(z)e^{j\omega t}\Big]$$`

Assume that `$\widetilde{V}_{0}^+$` is known. At $z=0$ and $z=\Delta$, the potential and current must be continuous (the equivalent conditions for the dielectric problem are that $E$ and $H$ are continuous). Assume also that region 2 extends extends to infinity so `$V_{2}^{-}=0$`.

Find `$\widetilde{V}_{0}^-(z)$, $\widetilde{V}_{1}^+(z)$, $\widetilde{V}_{1}^-(z)$`, and `$\widetilde{V}_{2}^+(z)$`.

Find `$\widetilde{V}_{0}^-(z)$/$\widetilde{V}_{0}^+(z)$` and `$\widetilde{V}_{1}^-(z)$/$\widetilde{V}_{1}^+(z)$`.

**Answer**

In the following, I use $x$ instead of $z$ for the position coordinate. In addition, $\widetilde{f}(x)$ means a complex function of the coordinate $x$ and $\widetilde{f}$ means a complex constant. For example, a spatially dependent reflection coefficient will be defined as $\widetilde{\rho}(x)=\widetilde{\rho}e^{+2j\beta x}$.

The general equation for potential as a function of $x$ is

`$$\widetilde{V}_n(x) = \widetilde{V}_{n}^+e^{-j\beta_n x}+\widetilde{V}_{n}^-e^{+j\beta_n x}$$`

This can be rewritten as

`$$\widetilde{V}_n(x) = \widetilde{V}_{n}^+e^{-j\beta_n x}\left(1+\frac{\widetilde{V}_{n}^-}{\widetilde{V}_{n}^+}e^{+2j\beta_n x}\right)=\widetilde{V}_{n}^+e^{-j\beta_n x}\left(1+\widetilde{\rho}_ne^{+2j\beta_n x}\right)=\widetilde{V}_{n}^+e^{-j\beta_n x}\big[1+\widetilde{\rho}_n(x)\big]$$`

The general equation for current as a function of $x$ is

`$$\widetilde{I}_n(x) = \frac{1}{Z_n}\left(\widetilde{V}_{n}^+e^{-j\beta_n x}-\widetilde{V}_{n}^-e^{+j\beta_n x}\right)$$`

which can be rewritten as

`$$\widetilde{I}_n(x) =\frac{\widetilde{V}_{n}^+}{Z_n}e^{-j\beta_n x}\left(1-\frac{\widetilde{V}_{n}^-}{\widetilde{V}_{n}^+}e^{+2j\beta_n x}\right)=\frac{\widetilde{V}_{n}^+}{Z_n}e^{-j\beta_n x}\left(1-\widetilde{\rho}_ne^{+2j\beta_n x}\right)=\frac{\widetilde{V}_{n}^+}{Z_n}e^{-j\beta_n x}\big[1-\widetilde{\rho}_n(x)\big]$$`

At the interface, $x_{n,n+1}$, between regions $n$ and $n+1$, the potential and current are continuous:

`$$\widetilde{V}_n(x_{n,n+1}) = \widetilde{V}_{n+1}(x_{n,n+1})\quad\quad\widetilde{I}_n(x_{n,n+1}) = \widetilde{I}_{n+1}(x_{n,n+1})$$`

as so is the spatially dependent impedance defined by 

`$$Z_n(x)\equiv\frac{\widetilde{V}_n(x)}{\widetilde{I}_n(x)}=Z_n\frac{1+\widetilde{\rho}_n(x)}{1-\widetilde{\rho}_n(x)}$$`

To simplify notation, set $n=0$. When complete, generality can be restored by replacing $0$ with $n$ and $1$ with $n+1$. For $n=0$, the interface conditions are

`$$\widetilde{V}_0(x_{01}) = \widetilde{V}_{1}(x_{01})\quad\Rightarrow\quad\widetilde{V}_{0}^+e^{-j\beta_0 x_{01}}\big[1+\widetilde{\rho}_0(x_{01})\big]=\widetilde{V}_{1}^+e^{-j\beta_1 x_{01}}\big[1+\widetilde{\rho}_1(x_{01})\big]$$`

`$$\widetilde{I}_0(x_{01}) = \widetilde{I}_{1}(x_{01})\quad\Rightarrow\quad\frac{\widetilde{V}_{0}^+}{Z_0}e^{-j\beta_0 x_{01}}\big[1-\widetilde{\rho}_0(x_{01})\big]=\frac{\widetilde{V}_{1}^+}{Z_1^+}e^{-j\beta_1 x_{01}}\big[1-\widetilde{\rho}_1(x_{01})\big]$$`

Taking the ratio of these two equations so as to eliminate `$\widetilde{V}_{0}^+$` and `$\widetilde{V}_{1}^+$` gives the equation for the continuity of $Z(x)$ at the region 0/region 1 interface:

`$$Z_0\frac{1+\widetilde{\rho}_0(x_{01})}{1-\widetilde{\rho}_0(x_{01})}=Z_1\frac{1+\widetilde{\rho}_1(x_{01})}{1-\widetilde{\rho}_1(x_{01})}$$`

For the problem given, `$\widetilde{\rho}_2=0$` because `$\widetilde{V}_{2}^-=0$` was given. Incrementing the subscripts by $1$ gives the equation for the continuity of $Z(x)$ at the interface of regions $1$ and $2$:

`$$Z_1\frac{1+\widetilde{\rho}_1(x_{12})}{1-\widetilde{\rho}_1(x_{12})}=Z_2\frac{1+\widetilde{\rho}_2(x_{12})}{1-\widetilde{\rho}_2(x_{12})}$$`

With `$\widetilde{\rho}_2=0$` and `$x_{12}=\Delta$`, this is

`$$Z_1\frac{1+\widetilde{\rho}_1(\Delta)}{1-\widetilde{\rho}_1(\Delta)}=Z_2$$`

and so

`$$\widetilde{\rho}_1(\Delta)=\frac{Z_2-Z_1}{Z_2+Z_1}$$`

Using the definition `$\widetilde{\rho}_n(x)\equiv \widetilde{\rho}_{n}e^{+2j\beta_n x}$`,

`$$\widetilde{\rho}_1e^{+2j\beta_1 \Delta}=\frac{Z_2-Z_1}{Z_2+Z_1}$$`

and so the reflection coefficient for region $1$ is:

`$$\widetilde{\rho}_1=\frac{Z_2-Z_1}{Z_2+Z_1}e^{-2j\beta_1 \Delta}$$`
 
To find the reflection coefficient $\widetilde{\rho}_0$, continuity of impedance can be used at the interface between regions $0$ and $1$:

`$$Z_0\frac{1+\widetilde{\rho}_0(x_{01})}{1-\widetilde{\rho}_0(x_{01})}=Z_1\frac{1+\widetilde{\rho}_1(x_{01})}{1-\widetilde{\rho}_1(x_{01})}$$`

With $x_{01}=0$, and using $\widetilde{\rho}_n(0)=\widetilde{\rho}_n$, this is

`$$Z_0\frac{1+\widetilde{\rho}_0}{1-\widetilde{\rho}_0}=Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}$$`

This is simplified if the spatially dependent impedance notation is used for the right-hand side

`$$Z_0\frac{1+\widetilde{\rho}_0}{1-\widetilde{\rho}_0}=Z_1(0)$$`

Solving for $\widetilde{\rho}_0$ gives

`$$\widetilde{\rho}_0=\frac{Z_1(0)-Z_0}{Z_1(0)+Z_0}$$`

Using `$Z_1(0)=Z_1[1+\widetilde{\rho}_1(0)]/[1-\widetilde{\rho}_1(0)]=Z_1(1+\widetilde{\rho}_1)/(1-\widetilde{\rho}_1)$` gives

`$$\widetilde{\rho}_0=\frac{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}-Z_0}{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}+Z_0}$$`

In summary, the reflection ratios for all of the regions have been found given the reflection ratio in one region.

`$$\frac{\widetilde{V}_1^-}{\widetilde{V}_1^+}=\widetilde{\rho}_1=\frac{Z_2-Z_1}{Z_2+Z_1}e^{-2j\beta_1 \Delta}\qquad\Rightarrow\qquad \frac{\widetilde{V}_1^-(x)}{\widetilde{V}_1^+(x)}=\widetilde{\rho}_1(x)=\frac{Z_2-Z_1}{Z_2+Z_1}e^{-2j\beta_1 (\Delta-x)}$$`

`$$\frac{\widetilde{V}_0^-}{\widetilde{V}_0^+}=\widetilde{\rho}_0=\frac{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}-Z_0}{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}+Z_0}\qquad\Rightarrow\qquad \frac{\widetilde{V}^-_0(x)}{\widetilde{V}_0^+(x)}=\widetilde{\rho}_0(x)=\frac{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}-Z_0}{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}+Z_0}e^{2j\beta_1 x}$$`

----

To find the values for the potentials given their ratios, go back to the continuity equation for potential at the first interface.

`$$\widetilde{V}_{1}(x_{01})=\widetilde{V}_0(x_{01})\quad\Rightarrow\quad\widetilde{V}_{1}^+e^{-j\beta_1 x_{01}}\big[1+\widetilde{\rho}_1(x_{01})\big]=\widetilde{V}_{0}^+e^{-j\beta_0 x_{01}}\big[1+\widetilde{\rho}_0(x_{01})\big]$$`

In this problem, `$\widetilde{V}_{0}^+$` was given. Solving for `$\widetilde{V}_{1}^+$` gives

`$$\widetilde{V}_{1}^+=\frac{1+\widetilde{\rho}_0(x_{01})}{1+\widetilde{\rho}_1(x_{01})}\widetilde{V}_{0}^+e^{-j(\beta_0-\beta_1) x_{01}}=\frac{1+\widetilde{\rho}_0}{1+\widetilde{\rho}_1}\widetilde{V}_{0}^+$$`

The solution for $\widetilde{V}_{2}^+$ is found by incrementing the subscripts in this equation by $1$.

`$$\widetilde{V}_{2}^+=\frac{1+\widetilde{\rho}_1(x_{12})}{1+\widetilde{\rho}_2(x_{12})}\widetilde{V}_{1}^+e^{-j(\beta_1-\beta_2) x_{12}}=\big[1+\widetilde{\rho}_1(\Delta)\big]\widetilde{V}_{1}^+e^{-j(\beta_1-\beta_2) \Delta}$$`

`$$\widetilde{V}_{0}^-=\widetilde{\rho}_0\widetilde{V}_{0}^+=\widetilde{V}_{0}^+\frac{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}-Z_0}{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}+Z_0}$$`

`$$\widetilde{V}_{1}^-=\widetilde{\rho}_1\widetilde{V}_{1}^+=\widetilde{V}_{0}^+\frac{Z_2-Z_1}{Z_2+Z_1}e^{-2j\beta_1 \Delta}$$`

----

`$$\frac{\widetilde{V}^-_0(x)}{\widetilde{V}_0^+(x)}=\widetilde{\rho}_0(x)=\frac{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}-Z_0}{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}+Z_0}e^{2j\beta_1 x}$$`

`$$\frac{\widetilde{V}_1^-(x)}{\widetilde{V}_1^+(x)}=\widetilde{\rho}_1(x)=\frac{Z_2-Z_1}{Z_2+Z_1}e^{+2j\beta_1 (x-\Delta)}$$`

`$$\widetilde{V}_{0}^-(x)=\widetilde{V}_{0}^+\frac{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}-Z_0}{Z_1\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}+Z_0}e^{+j\beta_1 x}$$`

`$$\widetilde{V}_{1}^-(x)=\widetilde{V}_{0}^+\frac{Z_2-Z_1}{Z_2+Z_1}e^{2j\beta_1(x-\Delta)}$$`

`$$\widetilde{V}_{1}^+(x)=\widetilde{V}_{0}^+\frac{1+\widetilde{\rho}_0}{1+\widetilde{\rho}_1}e^{-j\beta_1 x}$$`

`$$\widetilde{V}_{2}^+(x)=\widetilde{V}_{0}^+\frac{1+\widetilde{\rho}_0}{1+\widetilde{\rho}_1}\big[1+\widetilde{\rho}_1(\Delta)\big]e^{-j(\beta_1-\beta_2) \Delta}e^{-j\beta_1 x}$$`

----

The general procedure followed above was

1. Starting at the load interface $x_{n-1,n}$ where $Z_n(x_{n-1,n})$ is known because $\widetilde{\rho}_n$ is known, find all of the reflection coefficients by iteratively using the impedance continuity condition, which followed from the continuity of $\widetilde{V}(x)$ and $\widetilde{I}(x)$

`$$Z_{n-1}(x_{n-1,n})=Z_n(x_{n-1,n})$$`

until $n=1$. Explicitly, the equation to be iterated can be found by solving 

`$$Z_{n-1}\frac{1+\widetilde{\rho}_{n-1}(x_{n-1,n})}{1-\widetilde{\rho}_{n-1}(x_{n-1,n})}=Z_{n}\frac{1+\widetilde{\rho}_{n}(x_{n-1,n})}{1-\widetilde{\rho}_{n}(x_{n-1,n})}$$`

for $\widetilde\rho_{n-1}$

`$$\widetilde\rho_{n-1}=e^{-2j\beta_{n-1}x_{n-1,n}}\frac{\frac{Z_n}{Z_{n-1}}\frac{1+\widetilde{\rho}_n(x_{n-1,n})}{1-\widetilde{\rho}_n(x_{n-1,n})}-1}{\frac{Z_n}{Z_{n-1}}\frac{1+\widetilde{\rho}_n(x_{n-1,n})}{1-\widetilde{\rho}_n(x_{n-1,n})}+1}$$`

2. Starting at the interface between the first two regions (source region 0 and region 1), where $\widetilde{V}^+_{0}$ is known, iterate

`$$\widetilde{V}_{n+1}^+=\widetilde{V}_{n}^+\frac{1+\widetilde{\rho}_n(x_{n,n+1})}{1+\widetilde{\rho}_{n+1}(x_{n,n+1})}e^{-j(\beta_n-\beta_{n+1}) x_{n,n+1}}$$`

----

A common requirement of power systems is that there is no reflected potential, which corresponds to `$\widetilde{V}_{0}^-=0$` and `$\widetilde\rho_{0}=0$`. Given a fixed impedance for the source and load, and impedance and width of a region between the source and load can be adjusted to make `$\widetilde{V}_{0}^-=0$`. To do this, one needs to solve

`$$\widetilde\rho_{0}=0=\frac{\frac{Z_1}{Z_{0}}\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}-1}{\frac{Z_1}{Z_{0}}\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}+1}$$`

which simplifies to

$$0=\frac{Z_1}{Z_{0}}\frac{1+\widetilde{\rho}_1}{1-\widetilde{\rho}_1}-1$$

Using

$$\widetilde\rho_{1}=e^{2j\beta_{1}\Delta}\frac{Z_2-Z_1}{Z_2+Z_1}$$

and simplifying gives

$$e^{-2j\beta_1\Delta}\frac{Z_2-Z_1}{Z_1+Z_2}=\frac{Z_0-Z_1}{Z_0+Z_1}$$

The two unknowns in this equation are $\Delta$ and $Z_1$ can be solved for by equating the real and imaginary parts. In the case where all of the impedances are real (corresponding to propagation with no resistance), $e^{-2j\beta_1\Delta}$ must be real, so

$$2\beta_1\Delta = m\pi$$

Using $\beta_1=2\pi/\lambda_1$ gives the requirement

$$\Delta=m\frac{\lambda_1}{4}\quad m=0,1,...$$

The needed impedance $Z_1$ is found by solving

$$\pm\frac{Z_2-Z_1}{Z_1+Z_2}=\frac{Z_0-Z_1}{Z_0+Z_1}$$

where $+$ corresponds to $m=0,2,...$ and $-$ corresponds to $m=1, 3, ...$ and 

Expanding gives

$$\pm (-Z_1^2 - Z_0Z_1 + Z_1Z_2 + Z_0Z_2)=Z_0Z_2+Z_0Z_1-Z_1Z_2-Z_1^2$$

For the $+$ case, the solution is trivial: $Z_1=Z_0$, which corresponds to no intermediate region.

For the $-$ case, corresponding to $m=1, 3, ...$,

$$Z_1=\sqrt{Z_0Z_2}$$

so that the impedance is the geometric mean of the load and source impedances. 

In summary, given a fixed source and load impedance, a transmission line with a length that is an odd multiple of $\lambda/4$ and impedance that is the geometric mean of the source and load impedance can be placed between the source and the load to ensure no reflected wave in the source region.

# Visualizing VSWR

1. Show that

$$V(z,t)=V^{+}\Big[\cos(\omega t-\beta z) + \rho\cos(\omega t+\beta z)\Big]$$

can be written as the sum of two standing waves:

$$V(z,t)=A\cos(\omega t)\cos(\beta z) + B\sin(\omega t)\sin(\beta z)$$

and find $A$ and $B$.

2. The following program shows a wave of amplitude $V^+=1$ generated at the left boundary traveling to the right.

```
Nx = 300;
x = [1:Nx];
lambda = 100;

figure(1);clf
for i = 1:500
    Ei = cos(2*pi*(x-i)/lambda);
    % Set values to right of wave front to NaN so they won't be plotted.
    Ei(i+1:end) = NaN; 

    % Plot current time step as light grey.
    plot(Ei,'k','LineWidth',1,'Color',[1,1,1,0.4]/2);
    % Keep past time steps
    hold on;
    grid on;
    if i > 1
        % Delete previous current time step thick black line
        delete(h)
    end
    % Plot current time step as thick black line
    h = plot(Ei,'k','LineWidth',2);
    
    set(gca,'Ylim',[-2,2]);
    set(gca,'Xlim',[1,Nx]);
    %legend('V^{+}');
    % Uncomment the following to hide past time steps
    %hold off;
    if mod(i,100) == 0
        % Allow early termination of animation
        input('Continue?');
    end
    drawnow;
end
```

Modify the program so that a wave of amplitude $V^-=1/2$ is generated at the right boundary travels to the left. You are welcome to write re-write this program and your answer in another programming language.

3. Discuss how this plot is related to the VSWR. Could $\rho$ be determined using only this plot?

4. Repeat 2. and 3. with the right boundary at $i_x=550$.

Save your hand-written answers in a file named <code>HW9_2.pdf</code>. Save your program as <code>HW9_2.m</code>.

**Answer**

The following program does the hand calculations. I did the Smith chart calculations in class.

```
clear

p = 3; % Problem number

if p == 1
    Zc = [1/2, 1/3]; % Characteristic impedances of segments
    w  = [1/4];      % Segment width(s)
elseif p == 2
    Zc = [1, 1/2];
    w  = [1/4];
else
    Zc = [1, 1/2, 1/3];
    w  = [1/4,1/8];
end

Z(length(Zc)) = Zc(end);

for n = [length(Zc):-1:2]
    r = Z(n)/Zc(n-1);
    R = exp(-4*pi*1i*w(n-1))*(r - 1)/(r + 1);
    Z(n-1) = Zc(n-1)*(1 + R)/(1 - R);
end

transpose(Z)
```

# Impedance Transformation I

For the [https://www.mathcha.io/editor/v0XeLI1KFnvuWwVjVZT2DvBn4s8DvxDZUeMzd9 transmission line $I.$], compute 

1. $\widetilde{\rho}_1(0)$ and
2. ${Z}_1(-\lambda_1/4)$ 

by hand and using the Smith chart using the methods described below.

Use the Smith chart at [https://www.acs.psu.edu/drussell/Demos/SWR/SmithChart.pdf].

Save your answer as <code>HW10_1.pdf</code>. Include a marked-up copy of the Smith chart.

## Hand Calculation

Use the fact that the spatially dependent impedance

$$Z_n(y)=Z_n\frac{1+\widetilde{\rho}_n(y)}{1-\widetilde{\rho}_n(y)}$$

is continuous and $Z_2(y)=Z_2=Z_o/3$ because line $2$ is not terminated.

## Smith Chart

1. Compute the normalized impedance $Z_2(0)/Z_1$ and the associated normalized resistance, $r$, and reactance, $x$.
2. Find the $(r,x)$ location on the Smith chart and from this location read off $\widetilde{\rho}_1(0)$.
3. Find $\widetilde{\rho}_1(-\lambda_1/4)$ by rotating $\widetilde{\rho}_1(0)$ by an angle of $2\beta_1(-\Delta_1)=-\pi$.
4. At the location of $\widetilde{\rho}_1(-\lambda_1/4)$ found in the previous step, read off $(r,x)$.
5. Use the normalized $(r,x)$ found in the previous step to compute $Z(-\lambda_1/4)$.

## Impedance Transformation II

Repeat the previous problem using [https://www.mathcha.io/editor/v0XeLI1KFnvuWwVjVZT2DvBn4s8DvxDZUeMzd9 transmission line $II$].

Use the Smith chart at [https://www.acs.psu.edu/drussell/Demos/SWR/SmithChart.pdf].

Save your answer as <code>HW10_2.pdf</code>. Include a marked-up copy of the Smith chart.

## Impedance Transformation III

Find the impedance at the source for [https://www.mathcha.io/editor/v0XeLI1KFnvuWwVjVZT2DvBn4s8DvxDZUeMzd9 transmission line $III$].

Use the Smith chart at [https://www.acs.psu.edu/drussell/Demos/SWR/SmithChart.pdf].

Save your answer as <code>HW10_3.pdf</code>. Include a marked-up copy of the Smith chart.

# Final

Due Tuesday, December 15th at 11:59 pm.

In Section 5.2 (page 214) of the text and in class, the partial differential equations for $V$ and $I$ for a transmission line were derived using Maxwell's equations and the assumption that the length scale of variations in $V$ and $I$ was much longer than the separation distance between the conducting plates or cylinder that formed the transmission line; see Figure 5.2 on page 215 for the case of conducting parallel plates. (The length scale assumption allowed us to assume that the fields had the same spatial dependence as a problem with a uniform current and charge distribution on the conductors.)

The partial differential equations derived from Maxwell's equations were equivalent to the equations from a ladder circuit containing repeated ''differential'' nodes (containing inductors and capacitors) of the form shown in Figure 5.2 on page 215.

Given the above, it seems reasonable to expect that a ladder circuit with enough ''discrete'' nodes can approximate a continuous transmission line. Such a circuit is called an artificial transmission line.

In this problem, you will compute how $V$, $I$, and $Z$ vary along an artificial transmission line and compare the results with the respective values for a continuous transmission line.

## Part I

Save your answers in a file named <code>Final_Part_I.pdf</code>.


In the top circuit at [https://www.mathcha.io/editor/XoxD9fqLS21Tw635VQierrkQgIZG9nPVSWP6Lr], the source varies according to $V_0\cos\omega t$.

Use the methods of Section 4.3 (which starts on page 177) to show that

$$\widetilde{V}_1=\widetilde{V}_0-j\omega L\widetilde{I}_1$$

$$\widetilde{I}_2=\widetilde{I}_1-j\omega C\widetilde{V}_1$$

$$\widetilde{V}_2=\widetilde{V}_1-j\omega L\widetilde{I}_2$$

$$\widetilde{I}_2=\frac{\widetilde{V}_2}{Z_L}$$

-----

One can find all of the unknown values of $\widetilde{I}$ and $\widetilde{V}$ using the previous equations given only $\widetilde{V}_0=V_0$. An alternative relationship can also be used:

$$\widetilde{I}_1=\frac{\widetilde{V}_0}{Z_0}$$

where $Z_0$ is the equivalent impedance of the entire circuit.

Defining $Z_1$ as the equivalent impedance of $Z_L$ and the capacitor connected to node 1 and the inductor between node 1 and 2, find $Z_1$ and then $Z_0$.

----

1. Find $\widetilde{I}_k$ for $k=1, 2$ and $\widetilde{V}_k$ for $k=1, 2$.
2. Find $I_k(t)$ for $k=1, 2$ and $V_k(t)$ for $k=1, 2$.

At this point, it will be useful to verify that your answers are correct because the equations will be generalized. 

Describe how you verified your answers.

----

To solve this problem generally for $N$ ladder elements as shown in the bottom circuit at [https://www.mathcha.io/editor/XoxD9fqLS21Tw635VQierrkQgIZG9nPVSWP6Lr]

1. Write an equation that relates $Z_{k-1}$ to $Z_{k}$, $\omega$, $L$, and $C$ that applies for all but the last node;
2. Write an equation that relates `$\widetilde{V}\_{k+1}$` to `$\widetilde{V}\_{k}$` and `$\widetilde{I}\_{k}$`;
3. Write an equation that relates `$\widetilde{I}\_{k+1}$` to `$\widetilde{I}\_{k}$` and `$\widetilde{V}_{k+1}$`;
4. Write a program that takes an input of $\omega$, $L$, $C$, $N$, $Z_L$, and $V_0$ and returns
   1. $Z_k$ for $k=0, 1, ..., N-1$ (These node-dependent impedances are analogous to the position-dependent impedances previously considered. Note that in the last homework, the subscripts corresponded to segments of a transmission line. Here, the subscripts correspond to a position along a single transmission line.)
   2. $\widetilde{I}_k$ for $k=1, ..., N$
   3. $\widetilde{V}_k$ for $k=1, 2, ..., N$

Note that $Z_N=Z_L$ by definition.

## Part II

For this part, use $V_0=1$ V, $L=1$ H, $C=1$ F, $\omega=0.005$ s$^{-1}$, and $N=1000$.

1. Plot $V_k(t)$ at $t=0$.
2. Plot $V_k(t)$ at $t=(2\pi/\omega)/4$.

Justify the following claims using plots that compare the discrete ladder circuit solution with the exact solution.

1. When $Z_L=\sqrt{L/C}$, the ladder network solution is a discrete approximation to an infinitely long continuous transmission line with a characteristic impedance of $\sqrt{L/C}$<sup>*</sup>. (Note that the ladder network only gives a solution in a finite region near the source, similar to an FDTD simulation with a source on the left and a simulation domain with a constant $\mu$ and $\epsilon$ - the wave appears to continue to propagate past the right boundary. Here $Z_L$ is analogous to the right boundary in the FDTD simulation.)

2. When $Z_L\ne \sqrt{L/C}$, the ladder network solution is a discrete approximation of the source region of a continuous transmission line that has a change in characteristic impedance.

3. The discrete approximation to the continuous solution is better for small $\omega$.

Turn in a discussion of your answer in a file named <code>Final_Part_II.pdf</code> and name your figures <code>Final_Part_II_Figure_X.pdf</code>, where <code>X</code> is an integer.

<sup>*</sup> If you are wondering how a circuit containing only inductive and capacitive elements can have a real impedance, see [https://www.feynmanlectures.caltech.edu/II_22.html Section 22-6 of the Feynman Lectures on Physics] - "In a circuit of this kind, energy is continually absorbed from the generator at a constant rate and flows constantly out into the network, supplying energy which is stored in the inductances and capacitances down the line." In the limit of $\omega\rightarrow 0$, $z_0$ in [https://www.feynmanlectures.caltech.edu/II_22.html equation 22.28] becomes $\sqrt{L/C}$.


**Partial Answer**

In the time domain, the voltage across the inductor is

$$V_1(t)-V_0(t) = -L\dot{I_1}(t)$$

At node $1$, KCL gives

$$I_2(t)=I_1(t)-I_C(t)$$

where $I_C$ is the current along the wire connected to the capacitor. Using $Q_C=CV_C$, $\dot{Q}_C=I_C=C\dot{V}_C$,

$$I_2(t)=I_1(t)-C\dot{V}_C(t)$$

Steady state solutions to a system of linear first-order ODEs can be found efficiently (instead of using, say, the method of undetermined coefficients) by assuming solutions of the form

$$V_k(t) = \text{Re}\Big[\widetilde{V}_ke^{j\omega t}\Big]$$

$$I_k(t) = \text{Re}\Big[\widetilde{I}_ke^{j\omega t}\Big]$$

Using this and substation into $V_1(t)-V_0(t) = -L\dot{I_1}(t)$ gives

$$\text{Re}\Big[\widetilde{V}_1e^{j\omega t}-\widetilde{V}_0e^{j\omega t} + L\widetilde{I}_1e^{j\omega t}\Big]=0$$

or

$$\text{Re}\Big[e^{j\omega t}(\widetilde{V}_1-\widetilde{V}_0 + L\widetilde{I}_1)\Big]=0$$

In order for an equation of the form

$$\text{Re}\Big[\widetilde{C}e^{j\omega t}\Big]=0$$

to be true for all $t$, $\widetilde{C}=0$. As a result, the relationship between the complex coefficients is

$$\widetilde{V}_1-\widetilde{V}_0 = -L\widetilde{I}_1$$

The other equations can be obtained using the same arguments used to arrive at this result. 

----

$Z_1$ is found by adding the impedance of the load and inductor in series to get and equivalent impedance of $Z_L+j\omega L$. This impedance is in parallel with a capacitor, so the total equivalent impedance is

$$\frac{1}{Z_1}=\frac{1}{Z_C} + \frac{1}{Z_L+j\omega L}$$

where the impedance of the capacitor is $1/j\omega C$. Substitution and re-writing gives

$Z_1=\frac{1}{j\omega C + \frac{1}{Z_L+j\omega L}}$

This impedance is in series with an inductor, so 

$Z_0=Z_1 + j\omega L$

One could also arrive at the equation for $Z_0$ by solving the four equations from the previous part for $\widetilde{V}_0/\widetilde{I}_1$.

----

As in the problems for transmission lines, we find the impedance at the source by working from the source to the load (or a region transition). Then, the voltages and currents are found by working from the source towards the load. The impedance was found in the previous problem. We can plug $\widetilde{I}_1=\widetilde{V}_0/Z_0$

into the equation

$$\widetilde{V}_1=\widetilde{V}_0-j\omega L\widetilde{I}_1$$

and solve for $\widetilde{V}_1$ in terms of $\widetilde{V}_0$. Then, we can use

$$\widetilde{I}_2=\widetilde{I}_1-j\omega C\widetilde{V}_1$$

to find $\widetilde{I}_2$ in terms of $\widetilde{V}_0$. Finally,

$$\widetilde{V}_2=Z_L\widetilde{I}_2$$

The answers can be verified by

1. Using limits - do your equations give the expected results when $\omega \rightarrow 0$ or $\omega \rightarrow \infty$? What about similar limits for $L$ and $C$?
2. Solving the 4x4 system of equations manually
3. Using a program such as Wolfram Alpha to solve the system of equations. MATLAB also has this capability with its Symbolic Math Toolkit.
4. Find a circuit simulation program and choose arbitrary values of the parameters and verify that the amplitudes and phases from the simulation match your calculations. You can find simple programs that work online [https://www.falstad.com/circuit/] [https://www.circuitlab.com/] and do not require a license or software installation. See also [https://en.wikipedia.org/wiki/List_of_free_electronics_circuit_simulators] [https://www.electronics-lab.com/top-ten-online-circuit-simulators/]
5. Use something like MATLAB's Simulink or PSpice. There are many other options.

----

$$Z_{k-1} = \frac{1}{ \frac{1}{Z_{k} + j\omega L}+ j\omega C }$$

The equations

$$\widetilde{V}_1=\widetilde{V}_0-j\omega L\widetilde{I}_1$$

$$\widetilde{I}_2=\widetilde{I}_1-j\omega C\widetilde{V}_1$$

generalize to

`$$\widetilde{V}_{k+1}=\widetilde{V}_k-j\omega L\widetilde{I}_{k+1}$$`

`$$\widetilde{I}_{k+1}=\widetilde{I}_k-j\omega C\widetilde{V}_k$$`

The above equations were used in the program. In the program, I compare a plot of $Z_k$ and $\widetilde{V}_k/\widetilde{I}_k$ as they should be identical.

The procedure of solution is to start with $k=0$ and solve the first equation. Then A. use the second equation with $k=1$ to get $\widetilde{I}_2$ and B. substitute this into the first equation when $k=1$ to get $\widetilde{V}_2$.  Steps A. and B. are then repeated for $k=2, ...$.

The problem statement asks for the answer in a different form.  The two generalized equations above can be re-written as

`$$\widetilde{V}_{k+1}=\widetilde{V}_k(1-\omega^2LC)-j\omega L\widetilde{I}_{k}$$`

`$$\widetilde{I}_{k+1}=\widetilde{I}_k(1+\omega^2LC)-j\omega C\widetilde{V}_{k+1}$$`

Or, the indexing can be adjusted by subtracting 1 from the `$\widetilde{I}_{k}$` index. (In the diagram, there would be currents `$\widetilde{I}_{0}$` and `$\widetilde{I}_{1}$` instead of `$\widetilde{I}_{1}$` and `$\widetilde{I}_{2}$`.) Then,

`$$\widetilde{V}_{k+1}=\widetilde{V}_k-j\omega L\widetilde{I}_{k}$$`

`$$\widetilde{I}_{k+1}=\widetilde{I}_k-j\omega C\widetilde{V}_{k+1}$$`

----

Ideally the justification of 1. and 2. were done by plotting the continuous solution's impedance, $\widetilde{V}_k$, and $V_k(t)$ which is hinted at given the questions asked earlier. In the case of 1., an animation of $V_k(t)$ will show a rightward traveling wave. In the case of 2., and animation of $V_k(t)$ will show a waveform that looks like the solution studied in previous HWs when there is a reflection. The standing wave ratio could be computed for the discrete case and compared with the continuous case. One could look at the case where $Z_L>\sqrt{L/C}$ and $Z_L<\sqrt{L/C}$ and ask if the solutions match expectations. Most students looked at how the magnitudes changed with respect to the node number but did not consider how the phase changed (it changes approximately linearly; one can phase shift a signal with such a circuit). One could also look at how $Z_k$ depends on $k$ for a case where $Z_L\ne \sqrt{L/C}$ and compare this to the spatially dependent impedance for the continuous case.

The continuous solution was derived in 5.2 of the textbook. A key assumption is that the wavelength is large. In the discrete case, the number of nodes per wavelength should be large so that there are many differential elements per wavelength. The wavelength is inversely proportional to $\omega$ and so smaller $\omega$ gives a larger number of nodes per wave. This can be justified with plots by showing how the difference between the continuous solution and the discrete solution depends on $\omega$.

The code given in the solution can be built upon to do all that is suggested above. Note that the discrete case does not have an intrinsic length scale. The number of nodes per wavelength is not an independent parameter that can be set as one would do in a typical numerical solution. 


```
clear;

L = 5;
C = 5;
w = 0.005;
N = 1000;
Z(N) = sqrt(L/C);
Z0 = Z(N);

wc = 2/sqrt(L*C);

for n = [N:-1:2]
    Z(n-1) = 1/( 1/(Z(n) + 1j*w*L) + 1j*w*C );
end

%transpose(Z)

V(1) = 1;
I(1) = V(1)/Z(1);

for n = [1:N-1]
    I(n+1) = I(n) - 1j*w*C*V(n);
    V(n+1) = V(n) - 1j*w*L*I(n+1);
end

phiV = (180/pi)*atan2(imag(V),real(V));
phiI = (180/pi)*atan2(imag(I),real(I));

T = 2*pi/w;

set(0,'DefaultTextInterpreter','latex')
set(0,'DefaultLegendInterpreter','latex')
set(0,'DefaultAxesTickLabelInterpreter','latex');
set(0,'DefaultTextFontSize',14);
set(0,'DefaultAxesFontSize',14);

figure(1);
    clf;
    plot(abs(V),'k-','LineWidth',2);
    grid on;hold on
    plot(abs(I),'r-','LineWidth',2);
    plot(abs(Z),'g-','LineWidth',2);
    plot(abs(V./I),'k:','LineWidth',1);
    title(sprintf('$\\omega/\\omega_c = %.3f$; $Z_0 = %.1f$; $Z_L = %.1f$',w/wc,Z0,Z(N)));
    legend('$|\widetilde{V}|$','$|\widetilde{I}|$','$|Z|$','$|\widetilde{V}/\widetilde{I}|$');
    xlabel('$k$');
figure(2);
    clf;
    hold on;grid on;
    for i = 0:3
        t =(i/4)*(T);
        plot(real(V*exp(1j*w*t)),'LineWidth',2);
    end
    ylabel('$V(t)$')
    title(sprintf('$\\omega/\\omega_c = %.3f$; $Z_0 = %.1f$; $Z_L = %.1f$',w/wc,Z0,Z(N)));
    legend('$t = 0$','$t = T/4$','$t = T/2$','$t = 3T/4$');
    xlabel('$k$');
figure(3);
    clf;
    hold on;grid on;
    x = [0:length(V)-1];

    % Find the wavelength that gives the best match between discrete
    % and continuous
    for lambda = 1:10000
        S(lambda) = sum( (real(V*exp(1j*w*t))-V(1)*cos(2*pi*x/lambda-w*t)).^2 );
    end
    [~,lambda] = min(S);
    lambda % Number of nodes for a full wave. Dimensionless.
    lambda_m = 2*pi/(w*sqrt(L*C)); % Wavelength in meters if L and C are per meter.
    lambda_m - lambda
    for i = 0:0
        t =(i/4)*(T);
        plot(real(V*exp(1j*w*t)),'g','LineWidth',3);
        plot(V(1)*cos(2*pi*x/lambda-w*t),'k:','LineWidth',1); % This is matched solution only. Need to modify to use general solution.
        plot(1000*(real(V*exp(1j*w*t))-V(1)*cos(2*pi*x/lambda-w*t)),'LineWidth',2);
    end
    ylabel('$V(t)$')
    title(sprintf('$\\omega/\\omega_c = %.3f$; $Z_0 = %.1f$; $Z_L = %.1f$',w/wc,Z0,Z(N)));
    legend('Discrete','Continuous','1000(Discrete - Continuous)');
    xlabel('$k$');
```
