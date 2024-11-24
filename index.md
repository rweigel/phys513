```mdextension
Title: PHYS 513
Subtitle: Applied Electromagnetic Theory<br>Fall, 2024
```

* Day and Time: Thursday from 4:30 -- 7:10 pm
* Location: 1004 Exploratory Hall
* Instructor: Bob Weigel
* Email: rweigel@gmu.edu
* Office Hour: Thursday from 3:30 -- 4:30 pm
* Office: 259 Planetary Hall
* Course URL: https://rweigel.github.io/phys513

HWs:
[1](hw.html#hw-1) | 
[2](hw.html#hw-2) | 
[3](hw.html#hw-3) | 
[4](hw.html#hw-4) | 
[5](hw.html#hw-5) |
[6](hw.html#hw-6) |
[7](hw.html#hw-7) |
[8](hw.html#hw-8) |
[9](hw.html#hw-9) |
[10](hw.html#hw-10) |
[11](hw.html#hw-11) |
[12](hw.html#hw-12)

# Schedule

## December 12th

In-class final exam: Thursday, December 12th from 4:30--7:15 pm.

The exam will have two problems:

1. One problem based on homework problems covered after mid--term (HWs 8--12)

2. One problem based on symmetry arguments needed to justify the use of
   * Gauss's law to find the field due to a charge distribution or
   * Ampere's law to find the field due to a current distribution

Before writing the exam, I will look at the homework problems, identify the concepts, and write questions that can be solved in the allotted time. You are encouraged to find problems related to the homework problems in other resources and attempt them. Equations for divergence and laplacian in non--cartesian coordinates will be given. Other equations used in the homework problems will not be given.

## December 5th

Last class

* Discuss HW #12
* Final Review

## November 28th

No class

## November 21st

* Discuss final exam
* Discuss HW #11
* Discuss visualization of travelling waves
  * [PHET animation](https://phet.colorado.edu/sims/html/wave-on-a-string/latest/wave-on-a-string_all.html)
  * [MATLAB animation](http://mag.gmu.edu/git-data/phys513/misc/data/)
  * [Desmos animation](https://www.desmos.com/calculator/wteuno5c2u)
* Find reflection coefficient for coaxial cable terminated by 
  1. $Z_L=0$ (short at end)
  2. $Z_0/Z_L=0$ (end is open)
  3. $Z_L=ib$ (that is, the load has no resistive component, and the reactive component has a magnitude of $b$; this requires the assumption that $Z_o$ is real, which is equivalent to the coaxial cable being "ideal" in the sense that it has no resistance, either ohmic or radiative.)


## November 14th
* Discuss HW #10
* Review continuous transmission line (continuous version of AC ladder circuit)
* Cover solutions to continuous transmission line
* Handling boundary conditions
* Discuss 
  * https://www.youtube.com/watch?v=bHIhgxav9LY
  * response video https://www.youtube.com/watch?v=iph500cPK28 and
  * response to response https://www.youtube.com/watch?v=oI_X2cMHNe0

## November 7th

* Discuss HW #9
* Solving general AC circuit problems
* Numerical solution of AC ladder circuit
* Continuous transmission line (continuous version of AC ladder circuit)

## October 31st

* Discuss HW #8
* Additional review of use of Euler's identity
* Finding solution to series AC circuit problem using two methods

## October 24th

* Discuss midterm
* Discuss HW #7
* Faraday's law and Lenz's law
* Inductance

## October 24th

* Discuss midterm
* Discuss HW #7
* Faraday's law
* Inductance

## October 17th

In-class mid-term exam: Thursday, October 17th from 4:30--6:00 pm.
* The problems will be based on concepts covered in homework problems.
* I will look at the homework problems, identify the concepts, and write questions that can be solved in the allotted time.
* You are encouraged to find problems related to the homework problems in other resources and attempt them.
* Equations for divergence and laplacian in non--cartesian coordinates will be given. Other equations used in the homework problems will not be given.

## October 10th

* Ampere's law
* Faraday's law

## October 3rd

* Comments on common errors in [HW #4](hw.html#hw-4)
* Discuss [HW #5](hw.html#hw-5)
* Magnetic force, gyrofrequency, and particle trajectories ([video](https://svs.gsfc.nasa.gov/20237/))
* Biot-Savart law
* Ampere's law

## September 26th

* Comments on common errors in [HW #3](hw.html#hw-3)
* Discuss [HW #4](hw.html#hw-4)
* Polarization, $\mathbf{P}$, and $\mathbf{D}$
* Computing capacitance with dielectrics.

## September 19th

* Comments on common errors in [HW #2](hw.html#hw-2)
* Discuss [HW #3](hw.html#hw-3)
* Numerical solution of 1-D Laplacian
* Polarized slab example

## September 12th

* Discuss [HW #2](hw.html#hw-2)
* Computing capacitance using
  * Gauss's law (put $+Q$ on one conductor $-Q$ on another, compute potential difference)
  * Laplace's equation (put one conductor at a potential of $V_o$ and the other at $0$; compute $\mathbf{E}$ and use it to find $\sigma$; from $\sigma$, compute $Q$)

## September 5th

* GitHub and Discord
* Discuss [HW #1](hw.html#hw-1)
* Field lines
* Gauss's law

## August 29th

* Introductions
* Syllabus
* Overview of Electrostatics
* Line of charge along $x=[-l/2, l/2]$, field at $h$
  * Set-up
  * Two limits
  * Exact solution
* Line offset by $y=h$, find field at origin.
  * Solution using same set-up method as before
  * Solution using answer to non--offset problem
* Ring of charge centered on origin and in $x$--$y$ plane.
  * Solution using formal set-up approach
  * Solution similified by noting features
* (Not covered) Continuous Charge Distributions, Limits, and Dimensional Analysis
  * Dimensional Analysis References:
    * [A good reference to start with for dimensional analysis](https://drive.google.com/file/d/1_up6mplBXCoXJ4oB5rISpRFKCogpdv7a/view?usp=sharing★★★★remove★★★★)
    * [My collection of dimensional analysis references](https://drive.google.com/drive/folders/0B6antUcxBPXcZmR1NjJMZ2JnUWM★★★★remove★★★★)
* Gauss's law (if time)

# Syllabus

## Catalog Description

Classical electromagnetic theory with applications. Topics include electrostatics, magnetic fields and materials, electromagnetic wave propagation, waveguides, transmission lines, radiation, and antennas.

## Format

My primary objective for this course is for students to be able to solve and present advanced electricity and magnetism problems related to the topics given in the catalog description. I will cover topics in chapters 1-6 of [Fields and Waves in Communication Electronics, third edition by Simon Ramo, John R. Whinnery, Theodore Van Duzer, Wiley, 1994](http://www.amazon.ca/Fields-Waves-Communication-Electronics-Simon/dp/0471585513).

Many of the students in this class have had only E&M at the freshman undergraduate level. As a result, not all of the topics in the texbook are covered, and the focus is on a basic understanding of the fundamentals using theoretical and computation problems. In addition, I emphasize problem solving skills: Determining expected features of the solution to a given problem using analogies, limits, or similar problems, using non--dimensionalization to better understand the dependence of solutions on problem parameters, and building computational solutions in small steps with many intermediate checks.

Approximately 1/2 of class time will be a lecture. The rest of the time will be spent with students working on problems or presenting problems using the whiteboard.

The homework assignments will have two parts:

1. Basic problems that cover topics that have not been discussed in class. These problems are intended to prepare the students for the lecture on the topic.
2. Advanced problems that cover topics on the previous HWs basic problems and the lecture.

Homework assignments are due at 11:59 pm on Thursday so you have 3 hours to revise them after class is finished.

## Grading

* Homework: 30%
* Mid-term (part in-class, part take-home): 35%
* Final (part in-class, part take-home): 35%

The course letter grade is nominally determined using > 97: A+, 93 to 96.999: A, 90 to 92.999: A-, 87 to 89.999: B+, 83 to 86.999: B, 80 to 82.999: B-, 70 to 70.999, 60, to 69.999: D, < 60: F. It is quite likely that these grade cut-offs will change downwards.

## Textbook and References

The textbook for this course is [Fields and Waves in Communication Electronics, 3rd edition by Simon Ramo, John R. Whinnery, Theodore Van Duzer, Wiley, 1994](http://www.amazon.ca/Fields-Waves-Communication-Electronics-Simon/dp/0471585513).

You will likely need to reference other textbooks in this course. The following is a partial list of books that you may find useful.

### Mathematical

* A[n Introduction to Fourier Methods and the Laplace Transformation but Philip Franklin](https://www.amazon.com/introduction-Fourier-methods-Laplace-transformation/dp/B0007HQ89I). This short book has many examples related to Maxwell's equations and transmission lines.
* [Fourier Analysis class notes by Peakcock](https://www.roe.ac.uk/~jap/teaching); the [Chapter 12 lecture notes](https://www.roe.ac.uk/japwww/teaching/fourier/fourier1415.pdf) provides a review of the mathematical background and justification for solving ODEs using what Ramo calls "the phasor method".

### Undergraduate-level

* Introduction to Electrodynamics by David J. Griffiths - the most commonly used junior-level undergraduate textbook for physics majors.
* Field and Wave Electromagnetics by David K. Cheng - a commonly used junior-level undergraduate textbook for engineering majors.
* Elements of Electromagnetics by Matthew N. O. Sadiku - a commonly used junior-level undergraduate textbook for engineering majors.
* Electricity and Magnetism (3rd Edition) by Edward M. Purcell and David J. Morin covers the same topics as Griffiths at the same level. If you are looking for an alternative explanation, this textbook will be helpful. The book contains far more examples, discussion, and content than Griffiths. It also includes solutions.
* Schaum's outline of theory and problems of electromagnetics by Joseph A. Edminister is a useful reference for problems with full solutions and summaries of topics. [The 4th edition](https://www.amazon.com/Schaums-Outline-Electromagnetics-4th-Outlines/dp/0071831479/) contains chapters on transmission lines and waveguides.
* Div, Grad, Curl, and All That: An Informal Text on Vector Calculus (4th Edition) by H. M. Schey is an excellent reference for the mathematical background that you need to understand for this course. The book contains a concise and clear review of topics that are covered in a vector calculus course (usually "Calculus III").
* The Feynman Lectures on Physics: Mainly Electromagnetism and Matter, Volume 2, 1977 contains excellent lecture-style expositions on Electricity and Magnetism. The full volume is [available online](http://www.feynmanlectures.caltech.edu/II_toc.html).

### Graduate-level

Two textbooks that cover applied E&M topics in detail are
* Microwave Engineering by David M. Pozar.
* [Electromagnetic Fields and Energy by Hermann Haus and James Melcher. RES.6-001, Spring 2008.](https://ocw.mit.edu/resources/res-6-001-electromagnetic-fields-and-energy-spring-2008/front-end-matter/)
* [Electromagnetic Waves and Antennas by Sophocles J. Orfanidis](https://www.ece.rutgers.edu/~orfanidi/ewa/ewa-2up.pdf). This book is dense and comprehensive, but a supplement such as the course textbook and Microwave Engineering by Pozar is probably needed as a primary reference initially.

Textbooks that cover advanced E&M theory are
* Classical Electrodynamics by David J. Jackson - the most commonly used graduate-level textbook for physics students
* Classical Electricity and Magnetism: Second Edition (Dover Books on Physics) by Wolfgang K. H. Panofsky and Melba Phillips, 2005
* Classical Electromagnetism by Richard Fitzpatrick

## Academic Calendar and University Policy

* [Academic Calendar](https://registrar.gmu.edu/calendars/)
* [University Policy](http://universitypolicy.gmu.edu/)
* Last class Thursday, December 5th

## Disability Accommodations

Disability Services at George Mason University is committed to upholding the letter and spirit of the laws that ensure equal treatment of people with disabilities. Under the administration of University Life, Disability Services implements and coordinates reasonable accommodations and disability-related services that afford equal access to university programs and activities. Students can begin the registration process with Disability Services at any time during their enrollment at George Mason University. If you are seeking accommodations, please visit http://ds.gmu.edu/ for detailed information about the Disability Services registration process. Disability Services is located in Student Union Building I (SUB I), Suite 2500 | ods@gmu.edu | Phone: (703) 993-2474.

If you have a learning disability or other condition that may affect academic performance, please: a) make sure documentation is on file with the Office of Disability Services to determine the accommodations you need; and b) talk with me to discuss your accommodation needs.

## Counseling and Student Support

Counseling and Psychological Services provides confidential psychological services, including 24/7 crisis intervention and consultation to faculty and staff: http://caps.gmu.edu/.

