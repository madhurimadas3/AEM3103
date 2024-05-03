# Paper Airplane Numerical Study
  Final Project: AEM 3103 Spring 2024
  - By: Madhurima Das & Jocelyn Prewett

  ## Summary of Findings
  <Show the variations studied in a table>
The height and range were observed while varying the initial vellocity and flight path angle(Gamma). Afterwards, 100 possible trajectories were plotted and a curve fit was applied which captures the avergae of the 100 trajectories. The first derivative of Range vs time and the first derivative of Height vs time plots imply the change in the range and height over time from the fitted line. 
  Summarized what was accomplished in this study.  Describe 2-4 observations from simulating the flight path.
  Reference the figures below as needed.

  *If the analysis falls short of the goal, this is your chance to explain what was done or what were the barriers.*
 
  # Code Listing:
- [PaperPlane.m](https://github.com/madhurimadas3/AEM3103/blob/af7bd46c4f5ee8da65c25e1c3dd182f89c386a7f/PaperPlane.m)
	- Establishes Starting Variables
- [EqMotion.m](https://github.com/madhurimadas3/AEM3103/blob/827eb4b64bd9fb1772f3257a30072cc2b40c96f3/EqMotion.m)
	- Function for the equations of motions for the airplane
- [PartA.m](https://github.com/madhurimadas3/AEM3103/blob/827eb4b64bd9fb1772f3257a30072cc2b40c96f3/PartA.m)
	- Code for the first set of graphs showing Height vs. Range while varying first initial velocity and then gamma
- [PartB.m](https://github.com/madhurimadas3/AEM3103/blob/827eb4b64bd9fb1772f3257a30072cc2b40c96f3/PartB.m)
	- Code for the second set of graphs showing the variations of velocity and gamma with a (red) curve fit, then showing dR/dt over time and dH/dt over time.
- [Animation.m](https://github.com/madhurimadas3/AEM3103/blob/827eb4b64bd9fb1772f3257a30072cc2b40c96f3/Animation.m)
	- Code to create a GIF of V=7.5 and gamma = 0.4 against the nominal line

  # Figures

  ## Fig. 1: Single Parameter Variation
![Height vs Range](Figures/PartAheightvsrange.jpg)
Height vs. 

  ## Fig. 2: Monte Carlo Simulation
  <2D trajectories simulated using random sampling of parameters, overlay polynomial fit onto plot.>

  Briefly describe what is being shown in the figure.

 ## Fig. 3: Time Derivatives
 <Time-derivative of height and range for the fitted trajectory>

  Briefly describe what is being shown in the figure.

  (Below are for teams of 2-3 people)

  # Animation
  ## Point-Mass Animation
  <Animated GIF showing 2D trajectory for nominal and the scenario (V=7.5 m/s, Gam=+0.4 rad)>
  
  


